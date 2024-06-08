// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { EResource } from "src/Types.sol";

/**
 * @title IMarketplaceSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IMarketplaceSystem {
  function Pri_11__toggleMarketplaceLock() external;

  function Pri_11__addLiquidity(
    EResource resourceA,
    EResource resourceB,
    uint256 liquidityA,
    uint256 liquidityB
  ) external;

  function Pri_11__removeLiquidity(
    EResource resourceA,
    EResource resourceB,
    uint256 liquidityA,
    uint256 liquidityB
  ) external;

  function Pri_11__swap(bytes32 marketEntity, EResource[] memory path, uint256 amountIn, uint256 amountOutMin) external;
}