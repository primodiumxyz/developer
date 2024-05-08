// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;
import { PositionData } from "../codegen/index.sol";
import { OwnedBy } from "../codegen/index.sol";
import { BuildingTileKey } from "./Keys.sol";

library LibHelpers {
  /* ----------------------------- Picked from Internal Library --------------------------------- */
  // circumvented LibEncode library, will fix DevEx in future update (only necessary for coord)
  function getHash(bytes32 key, PositionData memory position) internal pure returns (bytes32) {
    return keccak256(abi.encode(key, position.x, position.y, position.parent));
  }

  // circumvented LibBuilding library, will fix DevEx in future update by refactoring buildings/coord
  function getBuildingFromCoord(PositionData memory coord) internal view returns (bytes32) {
    bytes32 buildingTile = getHash(BuildingTileKey, coord);
    return OwnedBy.get(buildingTile);
  }

  function addressToEntity(address a) internal pure returns (bytes32) {
    return bytes32(uint256(uint160((a))));
  }

  function entityToAddress(bytes32 a) internal pure returns (address) {
    return address(uint160(uint256((a))));
  }

  // If you believe that more libraries or functions need to be released, please contact the Primodium team.
}
