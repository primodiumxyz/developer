// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { IBaseWorld } from "@latticexyz/world-modules/src/interfaces/IBaseWorld.sol"; // get definitions common to all World contracts

// For getting world and table data
import { IWorld } from "../src/codegen/world/IWorld.sol";
import { PositionData } from "../src/codegen/index.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

contract UpgradeBountyActions is Script {
  function run() external {
    address deployerAddress = vm.envAddress("ADDRESS_ALICE");
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_ALICE");
    address delegateeAddress = vm.envAddress("ADDRESS_BOB");
    uint256 delegateePrivateKey = vm.envUint("PRIVATE_KEY_BOB");
    address worldAddress = vm.envAddress("WORLD_ADDRESS");
    bytes memory bountyBuildingBytes = vm.envBytes("BOUNTY_BUILDING_ENTITY");
    bytes32 bountyBuildingEntity = vm.envBytes32("BOUNTY_BUILDING_ENTITY");

    console.log("Alice address: %x", deployerAddress);
    console.log("Alice private key: %x", deployerPrivateKey);
    console.log("Bob address: %x", delegateeAddress);
    console.log("Bob private key: %x", delegateePrivateKey);
    console.log("World Address: %x", worldAddress);
    console.log("Bounty Building Entity: %s", vm.toString(bountyBuildingBytes));

    IWorld world = IWorld(worldAddress);
    StoreSwitch.setStoreAddress(worldAddress);

    uint256 bountyAmount = vm.envUint("BOUNTY_AMOUNT");

    // Alice deposits a bounty for a specific building
    vm.startBroadcast(deployerPrivateKey);
    uint256 bountyValue = world.upgradeBounty__depositBounty{ value: bountyAmount }(bountyBuildingEntity);
    vm.stopBroadcast();
    console.log("Alice set a bounty for %d wei.", bountyValue);

    // Alice withdraws a bounty for the same building
    vm.startBroadcast(deployerPrivateKey);
    bountyValue = world.upgradeBounty__withdrawBounty(bountyBuildingEntity);
    vm.stopBroadcast();
    console.log("Alice withdrew a %d wei bounty.", bountyValue);

    // Alice deposits a bounty again for the same building
    vm.startBroadcast(deployerPrivateKey);
    bountyValue = world.upgradeBounty__depositBounty{ value: bountyAmount }(bountyBuildingEntity);
    vm.stopBroadcast();
    console.log("Alice set another bounty for %d wei.", bountyValue);

    // Bob upgrades Alice's building. Note Alice needs to have the requisite upgrade resources for it to succeed.
    vm.startBroadcast(delegateePrivateKey);
    bytes memory newBuildingEntity = world.upgradeBounty__upgradeForBounty(deployerAddress, bountyBuildingEntity);
    vm.stopBroadcast();
    console.log("Bob upgraded Alice's building and claimed the bounty.");
  }
}
