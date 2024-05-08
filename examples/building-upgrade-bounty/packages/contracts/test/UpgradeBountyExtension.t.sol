// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import "forge-std/Test.sol";
import { MudTest } from "@latticexyz/world/test/MudTest.t.sol";
import { console } from "forge-std/console.sol";

import { WorldRegistrationSystem } from "@latticexyz/world/src/modules/init/implementations/WorldRegistrationSystem.sol"; // registering namespaces and systems
import { AccessManagementSystem } from "@latticexyz/world/src/modules/init/implementations/AccessManagementSystem.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { WorldResourceIdLib, ROOT_NAMESPACE } from "@latticexyz/world/src/WorldResourceId.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";
import { UNLIMITED_DELEGATION } from "@latticexyz/world/src/constants.sol";

// For registering the table
import { UpgradeBounty } from "../src/codegen/index.sol";
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { UpgrBounSystem } from "../src/systems/UpgrBounSystem.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { PositionData } from "../src/codegen/index.sol";
import { EXTENSION_NAMESPACE } from "../src/libraries/Constants.sol";

// For registering Delegation
import { SystemboundDelegationControl } from "@latticexyz/world-modules/src/modules/std-delegations/SystemboundDelegationControl.sol";
import { SYSTEMBOUND_DELEGATION } from "@latticexyz/world-modules/src/modules/std-delegations/StandardDelegationsModule.sol";

import { Home, Position, Spawned } from "primodium/index.sol";

contract UpgradeBountyExtensionTest is Test {
  uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_ALICE");
  address deployerAddress = vm.envAddress("ADDRESS_ALICE");
  address worldAddress = vm.envAddress("WORLD_ADDRESS");
  address delegateeAddress = vm.envAddress("ADDRESS_BOB");

  ResourceId immutable extensionNamespaceResourceId = WorldResourceIdLib.encodeNamespace(EXTENSION_NAMESPACE);
  ResourceId immutable upgrageBountySystemId =
    WorldResourceIdLib.encode({ typeId: RESOURCE_SYSTEM, namespace: EXTENSION_NAMESPACE, name: "UpgrBounSystem" });
  ResourceId immutable upgradeBuildingSystemId =
    WorldResourceIdLib.encode({ typeId: RESOURCE_SYSTEM, namespace: ROOT_NAMESPACE, name: "UpgradeBuildingS" });

  UpgrBounSystem upgrBounSystem;

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

    // Visual debug check
    console.log("Namespace ID: %x", uint256(ResourceId.unwrap(extensionNamespaceResourceId)));
    console.log("System ID:    %x", uint256(ResourceId.unwrap(upgrageBountySystemId)));

    primodiumWorld.registerNamespace(extensionNamespaceResourceId); // registers namespace to world address
    StoreSwitch.setStoreAddress(worldAddress); // sets the store address to the world address
    UpgradeBounty.register(); // registers the UpgradeBounty table to the world address

    upgrBounSystem = new UpgrBounSystem(); // creates/deploys a new UpgrBounSystem contract, store its address
    console.log("UpgrBounSystem address: ", address(upgrBounSystem));

    // Does registerSystem return a ResourceId?
    primodiumWorld.registerSystem(upgrageBountySystemId, upgrBounSystem, false); // registers the UpgrBounSystem contract address to the UpgrBounSystem namespace and resourceID in the world address

    primodiumWorld.registerFunctionSelector(upgrageBountySystemId, "depositBounty((int32,int32,bytes32))");
    primodiumWorld.registerFunctionSelector(upgrageBountySystemId, "withdrawBounty((int32,int32,bytes32))");
    primodiumWorld.registerFunctionSelector(upgrageBountySystemId, "upgradeForBounty(address,(int32,int32,bytes32))");
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
    bytes32 newBuildingEntity = iworld.upgradeBounty__upgradeForBounty(deployerAddress, bountyCoord);
    vm.stopPrank();
  }

  function testDepositBounty() public {
    vm.startPrank(deployerAddress);
    vm.deal(deployerAddress, 1 ether);

    // check world balance before deposit
    assertEq(worldAddress.balance, 0 ether);

    IWorld iworld = IWorld(worldAddress);
    uint256 bountyValue = iworld.upgradeBounty__depositBounty{ value: bountyAmount }(bountyCoord);

    assertEq(bountyValue, bountyAmount);

    // check world balance after deposit
    assertEq(worldAddress.balance, bountyAmount);

    vm.stopPrank();
  }

  function testUpgradeForBounty() public {
    vm.startPrank(deployerAddress);
    // Alice delegates to the UpgrBounSystem contract
    WorldRegistrationSystem world = WorldRegistrationSystem(worldAddress);

    world.registerDelegation(address(upgrBounSystem), UNLIMITED_DELEGATION, new bytes(0));
    console.log("Alice successfully registered her delegation to the UpgrBounSystem contract address.");

    // Alice uses her namespace admin rights to give Bob system access control
    AccessManagementSystem worldAccess = AccessManagementSystem(worldAddress);

    worldAccess.grantAccess(upgrageBountySystemId, delegateeAddress);
    console.log("Alice granted Bob access to UpgrBounSystem. He can now attempt to call any function in the system.");

    // Alice creates a bounty
    vm.deal(deployerAddress, 1 ether);

    IWorld iworld = IWorld(worldAddress);
    iworld.upgradeBounty__depositBounty{ value: bountyAmount }(bountyCoord);

    vm.stopPrank();

    // Bob completes the bounty
    vm.startPrank(delegateeAddress);
    assertEq(delegateeAddress.balance, 0 ether);

    bytes32 newBuildingEntity = iworld.upgradeBounty__upgradeForBounty(deployerAddress, bountyCoord);

    assertEq(worldAddress.balance, 0 ether);
    assertEq(delegateeAddress.balance, bountyAmount);

    vm.stopPrank();
  }
  // More tests to come later
}
