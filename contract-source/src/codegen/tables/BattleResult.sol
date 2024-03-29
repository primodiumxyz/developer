// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout, FieldLayoutLib } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { RESOURCE_TABLE, RESOURCE_OFFCHAIN_TABLE } from "@latticexyz/store/src/storeResourceTypes.sol";

ResourceId constant _tableId = ResourceId.wrap(
  bytes32(abi.encodePacked(RESOURCE_OFFCHAIN_TABLE, bytes14(""), bytes16("BattleResult")))
);
ResourceId constant BattleResultTableId = _tableId;

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x00e0070220202020202020000000000000000000000000000000000000000000
);

struct BattleResultData {
  bytes32 aggressorEntity;
  uint256 aggressorDamage;
  bytes32 targetEntity;
  uint256 targetDamage;
  bytes32 winner;
  bytes32 rock;
  uint256 timestamp;
  bytes32[] aggressorAllies;
  bytes32[] targetAllies;
}

library BattleResult {
  /**
   * @notice Get the table values' field layout.
   * @return _fieldLayout The field layout for the table.
   */
  function getFieldLayout() internal pure returns (FieldLayout) {
    return _fieldLayout;
  }

  /**
   * @notice Get the table's key schema.
   * @return _keySchema The key schema for the table.
   */
  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _keySchema = new SchemaType[](1);
    _keySchema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_keySchema);
  }

  /**
   * @notice Get the table's value schema.
   * @return _valueSchema The value schema for the table.
   */
  function getValueSchema() internal pure returns (Schema) {
    SchemaType[] memory _valueSchema = new SchemaType[](9);
    _valueSchema[0] = SchemaType.BYTES32;
    _valueSchema[1] = SchemaType.UINT256;
    _valueSchema[2] = SchemaType.BYTES32;
    _valueSchema[3] = SchemaType.UINT256;
    _valueSchema[4] = SchemaType.BYTES32;
    _valueSchema[5] = SchemaType.BYTES32;
    _valueSchema[6] = SchemaType.UINT256;
    _valueSchema[7] = SchemaType.BYTES32_ARRAY;
    _valueSchema[8] = SchemaType.BYTES32_ARRAY;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "battleId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](9);
    fieldNames[0] = "aggressorEntity";
    fieldNames[1] = "aggressorDamage";
    fieldNames[2] = "targetEntity";
    fieldNames[3] = "targetDamage";
    fieldNames[4] = "winner";
    fieldNames[5] = "rock";
    fieldNames[6] = "timestamp";
    fieldNames[7] = "aggressorAllies";
    fieldNames[8] = "targetAllies";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Set aggressorEntity.
   */
  function setAggressorEntity(bytes32 battleId, bytes32 aggressorEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((aggressorEntity)), _fieldLayout);
  }

  /**
   * @notice Set aggressorEntity.
   */
  function _setAggressorEntity(bytes32 battleId, bytes32 aggressorEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((aggressorEntity)), _fieldLayout);
  }

  /**
   * @notice Set aggressorDamage.
   */
  function setAggressorDamage(bytes32 battleId, uint256 aggressorDamage) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((aggressorDamage)), _fieldLayout);
  }

  /**
   * @notice Set aggressorDamage.
   */
  function _setAggressorDamage(bytes32 battleId, uint256 aggressorDamage) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((aggressorDamage)), _fieldLayout);
  }

  /**
   * @notice Set targetEntity.
   */
  function setTargetEntity(bytes32 battleId, bytes32 targetEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((targetEntity)), _fieldLayout);
  }

  /**
   * @notice Set targetEntity.
   */
  function _setTargetEntity(bytes32 battleId, bytes32 targetEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((targetEntity)), _fieldLayout);
  }

  /**
   * @notice Set targetDamage.
   */
  function setTargetDamage(bytes32 battleId, uint256 targetDamage) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((targetDamage)), _fieldLayout);
  }

  /**
   * @notice Set targetDamage.
   */
  function _setTargetDamage(bytes32 battleId, uint256 targetDamage) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((targetDamage)), _fieldLayout);
  }

  /**
   * @notice Set winner.
   */
  function setWinner(bytes32 battleId, bytes32 winner) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((winner)), _fieldLayout);
  }

  /**
   * @notice Set winner.
   */
  function _setWinner(bytes32 battleId, bytes32 winner) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((winner)), _fieldLayout);
  }

  /**
   * @notice Set rock.
   */
  function setRock(bytes32 battleId, bytes32 rock) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 5, abi.encodePacked((rock)), _fieldLayout);
  }

  /**
   * @notice Set rock.
   */
  function _setRock(bytes32 battleId, bytes32 rock) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.setStaticField(_tableId, _keyTuple, 5, abi.encodePacked((rock)), _fieldLayout);
  }

  /**
   * @notice Set timestamp.
   */
  function setTimestamp(bytes32 battleId, uint256 timestamp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 6, abi.encodePacked((timestamp)), _fieldLayout);
  }

  /**
   * @notice Set timestamp.
   */
  function _setTimestamp(bytes32 battleId, uint256 timestamp) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.setStaticField(_tableId, _keyTuple, 6, abi.encodePacked((timestamp)), _fieldLayout);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(
    bytes32 battleId,
    bytes32 aggressorEntity,
    uint256 aggressorDamage,
    bytes32 targetEntity,
    uint256 targetDamage,
    bytes32 winner,
    bytes32 rock,
    uint256 timestamp,
    bytes32[] memory aggressorAllies,
    bytes32[] memory targetAllies
  ) internal {
    bytes memory _staticData = encodeStatic(
      aggressorEntity,
      aggressorDamage,
      targetEntity,
      targetDamage,
      winner,
      rock,
      timestamp
    );

    PackedCounter _encodedLengths = encodeLengths(aggressorAllies, targetAllies);
    bytes memory _dynamicData = encodeDynamic(aggressorAllies, targetAllies);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    bytes32 battleId,
    bytes32 aggressorEntity,
    uint256 aggressorDamage,
    bytes32 targetEntity,
    uint256 targetDamage,
    bytes32 winner,
    bytes32 rock,
    uint256 timestamp,
    bytes32[] memory aggressorAllies,
    bytes32[] memory targetAllies
  ) internal {
    bytes memory _staticData = encodeStatic(
      aggressorEntity,
      aggressorDamage,
      targetEntity,
      targetDamage,
      winner,
      rock,
      timestamp
    );

    PackedCounter _encodedLengths = encodeLengths(aggressorAllies, targetAllies);
    bytes memory _dynamicData = encodeDynamic(aggressorAllies, targetAllies);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32 battleId, BattleResultData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.aggressorEntity,
      _table.aggressorDamage,
      _table.targetEntity,
      _table.targetDamage,
      _table.winner,
      _table.rock,
      _table.timestamp
    );

    PackedCounter _encodedLengths = encodeLengths(_table.aggressorAllies, _table.targetAllies);
    bytes memory _dynamicData = encodeDynamic(_table.aggressorAllies, _table.targetAllies);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32 battleId, BattleResultData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.aggressorEntity,
      _table.aggressorDamage,
      _table.targetEntity,
      _table.targetDamage,
      _table.winner,
      _table.rock,
      _table.timestamp
    );

    PackedCounter _encodedLengths = encodeLengths(_table.aggressorAllies, _table.targetAllies);
    bytes memory _dynamicData = encodeDynamic(_table.aggressorAllies, _table.targetAllies);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  )
    internal
    pure
    returns (
      bytes32 aggressorEntity,
      uint256 aggressorDamage,
      bytes32 targetEntity,
      uint256 targetDamage,
      bytes32 winner,
      bytes32 rock,
      uint256 timestamp
    )
  {
    aggressorEntity = (Bytes.slice32(_blob, 0));

    aggressorDamage = (uint256(Bytes.slice32(_blob, 32)));

    targetEntity = (Bytes.slice32(_blob, 64));

    targetDamage = (uint256(Bytes.slice32(_blob, 96)));

    winner = (Bytes.slice32(_blob, 128));

    rock = (Bytes.slice32(_blob, 160));

    timestamp = (uint256(Bytes.slice32(_blob, 192)));
  }

  /**
   * @notice Decode the tightly packed blob of dynamic data using the encoded lengths.
   */
  function decodeDynamic(
    PackedCounter _encodedLengths,
    bytes memory _blob
  ) internal pure returns (bytes32[] memory aggressorAllies, bytes32[] memory targetAllies) {
    uint256 _start;
    uint256 _end;
    unchecked {
      _end = _encodedLengths.atIndex(0);
    }
    aggressorAllies = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_bytes32());

    _start = _end;
    unchecked {
      _end += _encodedLengths.atIndex(1);
    }
    targetAllies = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_bytes32());
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   * @param _encodedLengths Encoded lengths of dynamic fields.
   * @param _dynamicData Tightly packed dynamic fields.
   */
  function decode(
    bytes memory _staticData,
    PackedCounter _encodedLengths,
    bytes memory _dynamicData
  ) internal pure returns (BattleResultData memory _table) {
    (
      _table.aggressorEntity,
      _table.aggressorDamage,
      _table.targetEntity,
      _table.targetDamage,
      _table.winner,
      _table.rock,
      _table.timestamp
    ) = decodeStatic(_staticData);

    (_table.aggressorAllies, _table.targetAllies) = decodeDynamic(_encodedLengths, _dynamicData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 battleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 battleId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    bytes32 aggressorEntity,
    uint256 aggressorDamage,
    bytes32 targetEntity,
    uint256 targetDamage,
    bytes32 winner,
    bytes32 rock,
    uint256 timestamp
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(aggressorEntity, aggressorDamage, targetEntity, targetDamage, winner, rock, timestamp);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(
    bytes32[] memory aggressorAllies,
    bytes32[] memory targetAllies
  ) internal pure returns (PackedCounter _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = PackedCounterLib.pack(aggressorAllies.length * 32, targetAllies.length * 32);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(
    bytes32[] memory aggressorAllies,
    bytes32[] memory targetAllies
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode((aggressorAllies)), EncodeArray.encode((targetAllies)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dyanmic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    bytes32 aggressorEntity,
    uint256 aggressorDamage,
    bytes32 targetEntity,
    uint256 targetDamage,
    bytes32 winner,
    bytes32 rock,
    uint256 timestamp,
    bytes32[] memory aggressorAllies,
    bytes32[] memory targetAllies
  ) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData = encodeStatic(
      aggressorEntity,
      aggressorDamage,
      targetEntity,
      targetDamage,
      winner,
      rock,
      timestamp
    );

    PackedCounter _encodedLengths = encodeLengths(aggressorAllies, targetAllies);
    bytes memory _dynamicData = encodeDynamic(aggressorAllies, targetAllies);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 battleId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = battleId;

    return _keyTuple;
  }
}
