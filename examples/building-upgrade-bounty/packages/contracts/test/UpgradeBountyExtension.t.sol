// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "forge-std/Test.sol";
import { MudTest } from "@latticexyz/world/test/MudTest.t.sol";
import { console } from "forge-std/console.sol";

import { WorldRegistrationSystem } from "@latticexyz/world/src/modules/core/implementations/WorldRegistrationSystem.sol"; // registering namespaces and systems
import { System } from "@latticexyz/world/src/System.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { WorldResourceIdLib, ROOT_NAMESPACE } from "@latticexyz/world/src/WorldResourceId.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";

// For registering the table
import { UpgradeBounty } from "../src/codegen/index.sol";
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { UpgrBounSystem } from "../src/systems/UpgrBounSystem.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { PositionData } from "../src/codegen/index.sol";

contract UpgradeBountyExtensionTest is Test {
  uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_ALICE");
  address deployerAddress = vm.envAddress("ADDRESS_ALICE");
  address worldAddress = vm.envAddress("WORLD_ADDRESS");
  address delegateeAddress = vm.envAddress("ADDRESS_BOB");

  // Establish the bounty coordinates.
  PositionData bountyCoord =
    PositionData({
      x: int32(vm.envInt("BOUNTY_X_COORD")),
      y: int32(vm.envInt("BOUNTY_Y_COORD")),
      parent: vm.envBytes32("BOUNTY_PARENT_ROCK")
    });
  uint256 bountyAmount = vm.envUint("BOUNTY_AMOUNT");

  function setUp() public {
    // setUp is called before each test. This setUp also registers the namespace and system to the world address.

    uint256 forkId = vm.createSelectFork(vm.envString("PRIMODIUM_RPC_URL"), vm.envUint("BLOCK_NUMBER"));
    console.log("ForkLivePrimodium is running.");

    vm.startPrank(deployerAddress);
    // Prep encoding the Ids before executing anything
    WorldRegistrationSystem primodiumWorld = WorldRegistrationSystem(worldAddress);
    ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14("upgradeBounty"));
    ResourceId systemResource = WorldResourceIdLib.encode(RESOURCE_SYSTEM, "upgradeBounty", "UpgrBounSystem");

    // Visual debug check
    console.log("Namespace ID: %x", uint256(ResourceId.unwrap(namespaceResource)));
    console.log("System ID:    %x", uint256(ResourceId.unwrap(systemResource)));

    primodiumWorld.registerNamespace(namespaceResource); // registers namespace to world address
    StoreSwitch.setStoreAddress(worldAddress); // sets the store address to the world address
    UpgradeBounty.register(); // registers the UpgradeBounty table to the world address

    UpgrBounSystem upgrBounSystem = new UpgrBounSystem(); // creates/deploys a new UpgrBounSystem contract, store its address
    console.log("UpgrBounSystem address: ", address(upgrBounSystem));

    // Does registerSystem return a ResourceId?
    primodiumWorld.registerSystem(systemResource, upgrBounSystem, false); // registers the UpgrBounSystem contract address to the UpgrBounSystem namespace and resourceID in the world address

    primodiumWorld.registerFunctionSelector(systemResource, "depositBounty((int32,int32,bytes32))");
    primodiumWorld.registerFunctionSelector(systemResource, "withdrawBounty((int32,int32,bytes32))");
    primodiumWorld.registerFunctionSelector(systemResource, "upgradeForBounty(address,(int32,int32,bytes32))");
    console.log(
      "Alice successfully registered the upgradeBounty namespace, UpgradeBounty table, and UpgrBounSystem contract to the Admin's world address."
    );

    vm.stopPrank();
  }

  function testSystemAccessRestriction() public {
    vm.startPrank(delegateeAddress);
    IWorld iworld = IWorld(worldAddress);
    // Bob tries to use the UpgrBounSystem before she has given Bob system access.
    vm.expectRevert();
    bytes memory newBuildingEntity = iworld.upgradeBounty_UpgrBounSystem_upgradeForBounty(deployerAddress, bountyCoord);
    vm.stopPrank();
  }

  function testDepositBounty() public {
    vm.startPrank(deployerAddress);
    vm.deal(deployerAddress, 1 ether);
    IWorld iworld = IWorld(worldAddress);
    uint256 bountyValue = iworld.upgradeBounty_UpgrBounSystem_depositBounty{ value: bountyAmount }(bountyCoord);
    vm.stopPrank();
  }
  // More tests to come later
}
