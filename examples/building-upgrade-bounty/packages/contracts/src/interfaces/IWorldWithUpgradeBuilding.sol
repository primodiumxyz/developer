// SPDX-License-Identifier: MIT

pragma solidity >=0.8.21;
import { PositionData } from "../codegen/index.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

interface IWorldWithUpgradeBuilding {
  /**
   * @dev Upgrades the building at the specified coordinate.
   * @param coord The coordinate of the building to upgrade.
   * @return buildingEntity The new building entity.
   */
  function upgradeBuilding(PositionData memory coord) external returns (bytes32 buildingEntity);

  /**
   * @dev Calls a function from the world system on behalf of a delegator.
   * @param delegator The address of the delegator.
   * @param systemId The ID of the system to call.
   * @param callData The data to pass to the system.
   * @return The result of the system call.
   */
  function callFrom(
    address delegator,
    ResourceId systemId,
    bytes memory callData
  ) external payable returns (bytes memory);
}
