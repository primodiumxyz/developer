// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { MudTest } from "@latticexyz/world/test/MudTest.t.sol";
import { console2 } from "forge-std/Test.sol";

import { WorldRegistrationSystem } from "@latticexyz/world/src/modules/init/implementations/WorldRegistrationSystem.sol";
import { System } from "@latticexyz/world/src/System.sol";

import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { UNLIMITED_DELEGATION } from "@latticexyz/world/src/constants.sol";

import { WriteDemoSystem } from "../src/systems/WriteDemoSystem.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { IWorld as IPrimodiumWorld } from "primodium/world/IWorld.sol";

// import {FunctionSelectors} from "@latticexyz/world/src/codegen/tables/FunctionSelectors.sol";
// import {EBuilding} from "../src/primodium/common.sol";

import { Home, PositionData, Spawned } from "primodium/index.sol";

contract WriteDemoTest is MudTest {
  // address public worldAddress; // inherited from MudTest

  // the environment variables are pulled from your .env
  address extensionDeployerAddress = vm.envAddress("ADDRESS_ALICE");
  address playerAddressActive = vm.envAddress("ADDRESS_PLAYER_ACTIVE");
  address playerAddressInactive = vm.envAddress("ADDRESS_PLAYER_INACTIVE");

  address playerAddressBob = vm.envAddress("ADDRESS_BOB");
  uint256 playerPrivateKeyBob = vm.envUint("PRIVATE_KEY_BOB");

  // defining these up top for use below.
  // namespaces are truncated to 14 bytes, and systems to 16 bytes.
  // namespaces must be unique, so if you get an Already Exists revert, try changing the namespace.
  // systems are also unique within a namespace, but redeploying a system will overwrite the previous version.
  bytes14 PRIMODIUM_NAMESPACE = bytes14("Pri_11");
  bytes14 namespace = bytes14("PluginExamples");
  bytes16 system = bytes16("WriteDemoSystem");

  // override MudTest setUp
  // the setUp function is run before each test function that follows
  function setUp() public override {
    // import MUD specific test setup
    super.setUp();

    // configure the target world
    worldAddress = vm.envAddress("WORLD_ADDRESS");
    StoreSwitch.setStoreAddress(worldAddress);

    // this test forks the live world state, and runs it on a local anvil instance
    // changes made in this test will not affect the live world state
    vm.createSelectFork(vm.envString("PRIMODIUM_RPC_URL"), vm.envUint("BLOCK_NUMBER"));
    console2.log("\nForkLivePrimodium is running.");

    // cache an instance of the WorldRegistrationSystem for the world
    WorldRegistrationSystem world = WorldRegistrationSystem(worldAddress);

    // derive the namespaceResource and systemResource from the namespace and system
    // specifics can be found at https://mud.dev/guides/extending-a-world
    // in the Deploy to the Blockchain Explanation spoiler
    ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14(namespace));
    ResourceId systemResource = WorldResourceIdLib.encode(RESOURCE_SYSTEM, namespace, system);
    console2.log("World Address: ", worldAddress);
    console2.log("Namespace ID:   %x", uint256(ResourceId.unwrap(namespaceResource)));
    console2.log("System ID:      %x", uint256(ResourceId.unwrap(systemResource)));

    // interacting with the chain requires us to pretend to be someone
    // here, we are pretending to be the extension deployer
    vm.startPrank(extensionDeployerAddress);

    // register the namespace
    world.registerNamespace(namespaceResource);

    WriteDemoSystem writeDemoSystem = new WriteDemoSystem();
    console2.log("WriteDemoSystem address: ", address(writeDemoSystem));

    // register the system
    world.registerSystem(systemResource, writeDemoSystem, true);

    // register all functions in the system
    // if you have multiple functions, you will need ro register each one
    world.registerFunctionSelector(systemResource, "buildIronMine()");
    console2.log(
      "Alice successfully registered the PluginExamples namespace, WriteDemoSystem contract, buildIronMine function selector, to the Primodium world address."
    );

    // stop being the system deployer
    vm.stopPrank();

    vm.startBroadcast(playerPrivateKeyBob);

    world.registerDelegation(address(writeDemoSystem), UNLIMITED_DELEGATION, new bytes(0));
    console2.log("Bob successfully delegated to WriteDemoSystem for unlimited delegation.");

    // stop being the active player
    vm.stopBroadcast();

    // uint256 height = block.number;
    // vm.roll(height + 10);
  }

  function test_buildIronMine() public {
    console2.log("\ntest_buildIronMine");

    // interact with the world as the active player
    vm.startBroadcast(playerPrivateKeyBob);

    // attempting to spawn the player if they have not started the game yet
    bytes32 playerEntity = bytes32(uint256(uint160(playerAddressBob)));
    bool playerIsSpawned = Spawned.get(playerEntity);
    if (!playerIsSpawned) {
      console2.log("Spawning Player");
      IPrimodiumWorld(worldAddress).Pri_11__spawn();
    }

    // build an iron mine on their home base
    console2.log("Building Iron Mine");
    bytes32 buildingEntity = IWorld(worldAddress).PluginExamples__buildIronMine();

    // assert that the iron mine was built
    assert(uint256(buildingEntity) != 0);
    console2.log("confirmed new IronMine Entity: %x", uint256(buildingEntity));

    // stop interacting with the chain
    vm.stopBroadcast();
  }

  // DEBUG Tests.  Leaving for reference.

  // I found that I lose visibility to some console.log outputs that are deeper in the system, when running from test.
  // To do debug, I ended up taking some of the internal system code, and bringing it up to the test level,
  // so the debug comments would remain visible.

  // The commented out code below is an example of how to build an Iron Mine directly, without calling the System function.

  // function test_buildIronMineDirect() public {
  //     console2.log("\ntest_buildIronMineDirect");
  //     vm.startBroadcast(playerPrivateKeyBob);

  //     bytes32 playerEntity = bytes32(uint256(uint160(playerAddressBob)));
  //     console2.log("playerEntity:    %x", uint256(playerEntity));

  //     // check if the player is spawned
  //     bool playerIsSpawned = Spawned.get(playerEntity);
  //     console2.log("playerIsSpawned: ", playerIsSpawned);

  //     // attempting to spawn the player says it's already spawned
  //     if (!playerIsSpawned) {
  //         console2.log("Spawning Player");
  //         IPrimodiumWorld(worldAddress).Pri_11__spawn();
  //     }
  //     // check if the player is spawned
  //     playerIsSpawned = Spawned.get(playerEntity);
  //     console2.log("playerIsSpawned: ", playerIsSpawned);

  //     bytes32 asteroidEntity = Home.get(playerEntity);
  //     console2.log("asteroidEntity:  %x", uint256(asteroidEntity));

  //     EBuilding building = EBuilding.IronMine;
  //     PositionData memory position;
  //     position.x = 15;
  //     position.y = 8;
  //     position.parentEntity = asteroidEntity;

  //     ResourceId buildSystemId = WorldResourceIdLib.encode(RESOURCE_SYSTEM, PRIMODIUM_NAMESPACE, "BuildSystem");
  //     // console2.log("Pri_11__build((uint256,(int32, int32, bytes32))");
  //     console2.log("building enum: %s", uint256(building));
  //     console2.log("position x: %s", uint256(int256(position.x)));
  //     console2.log("position y: %s", uint256(int256(position.y)));
  //     console2.log("position parent: %x", uint256(position.parentEntity));
  //     console2.log("buildSystemId: %x", uint256(ResourceId.unwrap(buildSystemId)));

  //     bytes4 worldFunctionSelector = bytes4(keccak256(bytes("Pri_11__build(uint8,(int32,int32,bytes32))")));
  //     console2.log("worldFunctionSelector:");
  //     console2.logBytes4(worldFunctionSelector);

  //     (ResourceId systemId, bytes4 systemFunctionSelector) = FunctionSelectors.get(worldFunctionSelector);
  //     console2.log("systemId: %x", uint256(ResourceId.unwrap(systemId)));
  //     console2.logBytes4(systemFunctionSelector);

  //     console2.logBytes(
  //         abi.encodeWithSignature("Pri_11__build(uint8,(int32,int32,bytes32))", building, (position))
  //     );
  //     console2.logBytes(
  //         abi.encodeWithSelector(
  //             bytes4(systemFunctionSelector), building, position.x, position.y, position.parentEntity
  //         )
  //     );

  //     bytes memory buildingEntity = IPrimodiumWorld(worldAddress).callFrom(
  //         playerAddressBob,
  //         systemId,
  //         abi.encodeWithSelector(
  //             bytes4(systemFunctionSelector), building, position.x, position.y, position.parentEntity
  //         )
  //     );

  //     // TODO: add an assert to confirm functionality

  //     vm.stopBroadcast();
  // }
}
