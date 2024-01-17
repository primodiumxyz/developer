// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";
import { StandardDelegationsModule } from "@latticexyz/world-modules/src/modules/std-delegations/StandardDelegationsModule.sol";

// make an interface with Primodium world
interface PrimodiumWorldWithUpgradeBuildingSystem {
  function upgradeBuilding(uint256 buildingId) external returns (bytes32 buildingEntity);
}

/*
flow: delegator creates contract, initializes who the true delegatee is in the contract, then delegates (system delegation) to the contract.
The delegatee calls the upgradeDelegatedBuilding contract function, and the contract calls the Primodium world contract function.

For now, assume contract creator is the delegator, but in the future, we could have a neutral third party create the contract, reassign ownership,

*/
contract DelegateUpgradeBuildingSystem is System {
  function upgradeDelegatedBuilding(uint256 buildingId) public {}

  //
}

// Delegator: does the frontend need to have the player call the delegate function on the Primodium world contract?
// Delegatee: need the frontend to index delegations, filter by delegatee (you by default), then filter by delegator, then filter by buildingId.
//            ideally, this would only show buildings that are upgradeable right now.
