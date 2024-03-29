// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

import { EObjectives } from "src/Types.sol";

/**
 * @title IClaimObjectiveSystem
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IClaimObjectiveSystem {
  function claimObjective(bytes32 spaceRockEntity, EObjectives objective) external;
}
