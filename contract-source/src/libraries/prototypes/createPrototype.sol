// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { Schema } from "@latticexyz/store/src/Schema.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { PackedCounter } from "@latticexyz/store/src/PackedCounter.sol";

function createPrototype(
  IStore store,
  bytes32[] memory key,
  ResourceId[] memory tableIds,
  bytes[] memory staticData,
  PackedCounter[] memory encodedLengths,
  bytes[] memory dynamicData
) {
  for (uint256 i = 0; i < tableIds.length; i++) {
    ResourceId tableId = tableIds[i];
    store.setRecord(tableId, key, staticData[i], encodedLengths[i], dynamicData[i]);
  }
}
