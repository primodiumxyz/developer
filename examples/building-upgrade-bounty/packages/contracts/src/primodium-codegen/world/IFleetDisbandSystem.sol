// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

/**
 * @title IFleetDisbandSystem
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IFleetDisbandSystem {
  function disbandFleet(bytes32 fleetId) external;

  function disbandUnitsAndResourcesFromFleet(
    bytes32 fleetId,
    uint256[] calldata unitCounts,
    uint256[] calldata resourceCounts
  ) external;

  function disbandUnits(bytes32 fleetId, uint256[] calldata unitCounts) external;

  function disbandResources(bytes32 fleetId, uint256[] calldata resourceCounts) external;
}
