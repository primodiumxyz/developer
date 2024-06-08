// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { Script } from "forge-std/Script.sol";
import { console2 } from "forge-std/Test.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { IWorld as IPrimodiumWorld } from "primodium/world/IWorld.sol";

import { Systems } from "@latticexyz/world/src/codegen/tables/Systems.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { FunctionSelectors } from "@latticexyz/world/src/codegen/tables/FunctionSelectors.sol";
import { UNLIMITED_DELEGATION } from "@latticexyz/world/src/constants.sol";

import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";

contract BuildIronMine is Script {
  function run() external {
    address worldAddress = vm.envAddress("WORLD_ADDRESS");
    console2.log("World Address: %x", worldAddress);
    uint256 playerPrivateKeyBob = vm.envUint("PRIVATE_KEY_BOB");
    console2.log("Player Private Key: %x", playerPrivateKeyBob);

    ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14("PluginExamples"));
    ResourceId systemResource = WorldResourceIdLib.encode(RESOURCE_SYSTEM, "PluginExamples", "WriteDemoSystem");

    vm.startBroadcast(playerPrivateKeyBob);

    // you can cache the IWorld, or cast it inline as seen in the test script
    IWorld iworld = IWorld(worldAddress);

    address writeDemoSystem = Systems._getSystem(systemResource);

    // Before a system can take actions on behalf of a player, they have to delegate
    // authority to the system.  There are various delegation levels, but for this demo,
    // we will use the UNLIMITED delegation level.
    iworld.registerDelegation(address(writeDemoSystem), UNLIMITED_DELEGATION, new bytes(0));

    // function format is namespace__function
    iworld.PluginExamples__buildIronMine();

    vm.stopBroadcast();
    console2.log("Iron Mine Built on Main Base");
  }
}
