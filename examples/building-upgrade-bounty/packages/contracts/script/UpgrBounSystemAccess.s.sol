// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { IBaseWorld } from "@latticexyz/world-modules/src/interfaces/IBaseWorld.sol"; // get definitions common to all World contracts

import { AccessManagementSystem } from "@latticexyz/world/src/modules/core/implementations/AccessManagementSystem.sol";

// Create resource identifiers (for the namespace and system)
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";

// For getting world and table data
import { IWorld } from "../src/codegen/world/IWorld.sol";
import { PositionData } from "../src/codegen/index.sol";

contract UpgrBounSystemAccess is Script {
  function run() external {
    address deployerAddress = vm.envAddress("ADDRESS_ALICE");
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_ALICE");
    address delegateeAddress = vm.envAddress("ADDRESS_BOB");
    uint256 delegateePrivateKey = vm.envUint("PRIVATE_KEY_BOB");
    address worldAddress = vm.envAddress("WORLD_ADDRESS");

    console.log("Alice address: %x", deployerAddress);
    console.log("Alice private key: %x", deployerPrivateKey);
    console.log("Bob address: %x", delegateeAddress);
    console.log("Bob private key: %x", delegateePrivateKey);
    console.log("World Address: %x", worldAddress);

    // Prep encoding the Ids before executing anything
    AccessManagementSystem worldAccess = AccessManagementSystem(worldAddress);
    ResourceId upgrBounSystemResource = WorldResourceIdLib.encode(RESOURCE_SYSTEM, "upgradeBounty", "UpgrBounSystem");
    // Visual debug check
    console.log("Bounty System ID:    %d", uint256(ResourceId.unwrap(upgrBounSystemResource)));

    // Alice uses her namespace admin rights to give Bob system access control
    vm.startBroadcast(deployerPrivateKey);
    worldAccess.grantAccess(upgrBounSystemResource, delegateeAddress);
    vm.stopBroadcast();
    console.log("Alice granted Bob access to UpgrBounSystem. He can now attempt to call any function in the system.");
  }
}
