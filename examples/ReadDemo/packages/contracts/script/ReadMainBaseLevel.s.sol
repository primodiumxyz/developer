// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { Script } from "forge-std/Script.sol";
import { console2 } from "forge-std/Test.sol";

import { ReadDemoSystem } from "../src/systems/ReadDemoSystem.sol";
import { IWorld } from "../src/codegen/world/IWorld.sol";

contract ReadMainBaseLevel is Script {
  function run() external {
    address worldAddress = vm.envAddress("WORLD_ADDRESS");
    console2.log("World Address: %x", worldAddress);
    address playerAddress = vm.envAddress("ADDRESS_PLAYER");
    console2.log("Player Address: %x", playerAddress);

    vm.startBroadcast(playerAddress);

    // you can cache the IWorld, or cast it inline as seen in the test script
    IWorld iworld = IWorld(worldAddress);

    // function format is namespace__function
    uint32 baseLevel = iworld.PluginExamples__readMainBaseLevel();

    vm.stopBroadcast();
    console2.log("baseLevel: ", baseLevel);
  }
}
