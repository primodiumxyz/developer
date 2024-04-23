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

contract BuildIronMine is Script {
  function run() external {
    address worldAddress = vm.envAddress("WORLD_ADDRESS");
    console2.log("World Address: %x", worldAddress);
    uint256 playerPrivateKeyBob = vm.envUint("PRIVATE_KEY_BOB");
    console2.log("Player Private Key: %x", playerPrivateKeyBob);

    vm.startBroadcast(playerPrivateKeyBob);

    // you can cache the IWorld, or cast it inline as seen in the test script
    IWorld iworld = IWorld(worldAddress);

    bytes4 worldFunctionSelector = IPrimodiumWorld(worldAddress).Primodium__build.selector;
    (ResourceId systemId, ) = FunctionSelectors.get(worldFunctionSelector);

    address writeDemoSystem = Systems._getSystem(systemId);

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
