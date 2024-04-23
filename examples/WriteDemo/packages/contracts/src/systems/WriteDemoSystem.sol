// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { System } from "@latticexyz/world/src/System.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { FunctionSelectors } from "@latticexyz/world/src/codegen/tables/FunctionSelectors.sol";

// previously, we imported these directly,
// but MUD collects and exposes them in index.sol automatically
// so we can import them all from there
import { Asteroid, Home, Level, Dimensions, DimensionsData, PositionData, Spawned, UsedTiles, P_AsteroidData, P_Asteroid, P_Blueprint, P_EnumToPrototype, P_MaxLevel, P_RequiredTile, P_Terrain } from "primodium/index.sol";

import { Bounds, EResource } from "src/Types.sol";
import { BuildingKey, ExpansionKey } from "src/Keys.sol";

import { EBuilding } from "primodium/common.sol";
import { IWorld as IPrimodiumWorld } from "primodium/world/IWorld.sol";

import { console } from "forge-std/console.sol";

// We're building a System, to extend the System contract
contract WriteDemoSystem is System {
  bytes14 PRIMODIUM_NAMESPACE = bytes14("Primodium");

  function buildIronMine() public returns (bytes32 buildingEntity) {
    // we want to read from the Primodium World, not the Extension World
    StoreSwitch.setStoreAddress(_world());

    // Get the players ID
    // instead of bytes32(uint256(uint160(_msgSender())))
    // this time we're going to use a helper function
    bytes32 playerEntity = addressToEntity(_msgSender());
    // console.log("playerEntity:    %x", uint256(playerEntity));

    // check if the player is spawned
    bool playerIsSpawned = Spawned.get(playerEntity);
    require(playerIsSpawned, "[WriteDemoSystem] Player is not spawned");

    // get the ID of the players home base asteroid
    bytes32 asteroidEntity = Home.get(playerEntity);
    // console.log("asteroidEntity:  %x", uint256(asteroidEntity));

    // the building list is stored in a list of enums
    EBuilding building = EBuilding.IronMine;

    // Normally we would need to fetch the cost of a building
    // and allocate resources. However, Mines are free if you your main base is high enough level.
    // Iron Mines have no level requirement, so we're skipping this step.
    // P_RequiredResourcesData memory requiredResources = getBuildCost(building);

    // Now we need to find a valid resource tile to build on.
    // We're going to use some helper functions for this.
    // These are similar/the same to what we use internally.
    // They are included further down the contract.
    PositionData memory position = getTilePosition(asteroidEntity, building);

    // if we didn't revert in the above step, then we have found a valid tile position to build on

    // this is the correct way to implement this.  however, there is a bug in how MUD handles function selectors
    // when using callFrom, so we're going to have to do it a different way.

    // ResourceId buildSystemId = WorldResourceIdLib.encode(RESOURCE_SYSTEM, PRIMODIUM_NAMESPACE, "BuildSystem");
    // bytes memory buildingEntity = IPrimodiumWorld(_world()).callFrom(
    //     _msgSender(),
    //     buildSystemId,
    //     abi.encodeWithSignature("Primodium__build(uint8,(int32,int32,bytes32))", building, (position))
    // );

    // find the expected function selector
    bytes4 worldFunctionSelector = IPrimodiumWorld(_world()).Primodium__build.selector;

    // look up that function selector in the MUD FunctionSelectors talbe, and get the actual function selector.
    // eventually, these should match, but currently that is not the case.
    (ResourceId buildSystemId, bytes4 buildSystemFunctionSelector) = FunctionSelectors.get(worldFunctionSelector);

    // now we can call the build function in the BuildSystem
    bytes memory result = IPrimodiumWorld(_world()).callFrom(
      _msgSender(),
      buildSystemId,
      abi.encodeWithSelector(
        bytes4(buildSystemFunctionSelector),
        building,
        position.x,
        position.y,
        position.parentEntity
      )
    );

    buildingEntity = abi.decode(result, (bytes32));
  }

  /*//////////////////////////////////////////////////////////////
                        HELPER/LIBRARY FUNCTIONS
    //////////////////////////////////////////////////////////////*/
  function addressToEntity(address a) internal pure returns (bytes32) {
    return bytes32(uint256(uint160((a))));
  }

  function getTilePosition(bytes32 asteroidEntity, EBuilding buildingType) internal view returns (PositionData memory) {
    // we use EBuilding to track our list of buildings
    // the the actual building data is stored in a Prototype table
    // the P_EnumToPrototype table allows us to look them up
    // BuildingKey is a constant defined in the Keys.sol file
    bytes32 buildingPrototype = P_EnumToPrototype.get(BuildingKey, uint8(buildingType));

    // As you upgrade your asteroid, the bounds that you can build in increases
    // we need to find the bounds, then search wtihin them to find a valid tile
    Bounds memory bounds = getAsteroidBounds(asteroidEntity);

    // we're going to loop through the bounds to find a valid tile
    for (int32 i = bounds.minX; i < bounds.maxX; i++) {
      for (int32 j = bounds.minY; j < bounds.maxY; j++) {
        // PositionData also includes a link to the parent entity
        // this is used to check the map configuration
        PositionData memory coord = PositionData(i, j, asteroidEntity);

        // we're going to use a helper function to check:
        // if building's required terrain matches the terrain of the given coord
        // if attempting to build here will be successful
        // if we can't build here, keep looking
        if (!canBuildOnTile(buildingPrototype, coord)) continue;
        if (!canPlaceBuildingTiles(asteroidEntity, buildingPrototype, coord, bounds)) continue;
        return coord;
      }
    }
    revert("Valid tile position not found");
  }

  // @notice Gets the boundary limits for a asteroid
  // @param asteroidEntity The entity ID of the asteroid
  // @return bounds The boundary limits
  function getAsteroidBounds(bytes32 asteroidEntity) internal view returns (Bounds memory bounds) {
    // the asteroid level determines the possible dimensions and range of an asteroid
    uint256 asteroidLevel = Level.get(asteroidEntity);

    // find the range based on the current expansion level
    // ExpansionKey is a constant defined in the Keys.sol file
    DimensionsData memory range = Dimensions.get(ExpansionKey, asteroidLevel);

    // get the dimensions of the asteroid
    P_AsteroidData memory asteroidDims = P_Asteroid.get();

    // fetch, calculate, and return the locations where you can build
    return
      Bounds({
        maxX: (asteroidDims.xBounds + range.width) / 2 - 1,
        maxY: (asteroidDims.yBounds + range.height) / 2 - 1,
        minX: (asteroidDims.xBounds - range.width) / 2,
        minY: (asteroidDims.yBounds - range.height) / 2
      });
  }

  /// @notice Checks if a building can be constructed on a specific tile
  /// @param prototype The type of building
  /// @param coord The coordinate to check
  /// @return True if the building's required terrain matches the terrain of the given coord
  function canBuildOnTile(bytes32 prototype, PositionData memory coord) internal view returns (bool) {
    // what resource is on this tile
    EResource resource = EResource(P_RequiredTile.get(prototype));

    // get the map details
    uint8 mapId = Asteroid.getMapId(coord.parentEntity);

    // return if no resource is require, or if the resource required matches the resource on this tile
    return resource == EResource.NULL || uint8(resource) == P_Terrain.get(mapId, coord.x, coord.y);
  }

  function canPlaceBuildingTiles(
    bytes32 asteroidEntity,
    bytes32 buildingPrototype,
    PositionData memory position,
    Bounds memory bounds
  ) internal view returns (bool) {
    // prototypes get translated into blueprints for placement
    int32[] memory blueprint = P_Blueprint.get(buildingPrototype);

    // a building can take up more than one tile
    int32[] memory tileCoords = new int32[](blueprint.length);

    // check that the building will fit within the bounds
    for (uint256 i = 0; i < blueprint.length; i += 2) {
      int32 x = blueprint[i] + position.x;
      int32 y = blueprint[i + 1] + position.y;
      if (bounds.minX > x || bounds.minY > y || bounds.maxX < x || bounds.maxY < y) return false;
      tileCoords[i] = blueprint[i] + position.x;
      tileCoords[i + 1] = blueprint[i + 1] + position.y;
    }

    // return true if all specified tiles are available
    return allTilesAvailable(asteroidEntity, tileCoords);
  }

  /**
   * @dev Checks if all specified tiles are available.
   * @param asteroidEntity Identifier for a set of tiles.
   * @param coords Array of coordinates, structured as [x1, y1, x2, y2, ...]. Must be even length.
   * @return bool True if all specified tiles are available, false otherwise.
   * Requires coords length to be even. Returns true if no tiles are used for the given asteroid. Validates each tile's availability based on its position in a bitmap.
   */
  function allTilesAvailable(bytes32 asteroidEntity, int32[] memory coords) internal view returns (bool) {
    require(coords.length % 2 == 0, "Invalid coords length");
    uint256[] memory bitmap = UsedTiles.get(asteroidEntity);
    if (bitmap.length == 0) return true;

    int32 width = Dimensions.getWidth(ExpansionKey, P_MaxLevel.get(ExpansionKey));
    for (uint256 i = 0; i < coords.length; i += 2) {
      uint256 index = uint256(uint32(coords[i] * width + coords[i + 1]));
      uint256 wordIndex = index / 256;
      if (wordIndex >= bitmap.length) return false; // out of bounds (not available)
      uint256 bitIndex = index % 256;

      if ((bitmap[wordIndex] >> bitIndex) & 1 == 1) return false;
    }

    return true;
  }
}

// I'm following this function since it matched my original idea
// PrimodiumTest.t.sol line 281

//   function buildBuilding(address player, EBuilding building) internal returns (bytes32) {
//     P_RequiredResourcesData memory requiredResources = getBuildCost(building);
//     PositionData memory position = getTilePosition(Home.get(addressToEntity(player)), building);
//     provideResources(position.parentEntity, requiredResources);
//     uint256 requiredMainBaseLevel = P_RequiredBaseLevel.get(P_EnumToPrototype.get(BuildingKey, uint8(building)), 1);
//     upgradeMainBase(player, requiredMainBaseLevel);
//     vm.startPrank(player);
//     bytes32 buildingEntity = world.Primodium__build(building, position);
//     vm.stopPrank();
//     return buildingEntity;
//   }
