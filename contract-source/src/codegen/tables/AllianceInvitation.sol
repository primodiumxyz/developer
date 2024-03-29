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
  bytes32(abi.encodePacked(RESOURCE_TABLE, bytes14(""), bytes16("AllianceInvitati")))
);
ResourceId constant AllianceInvitationTableId = _tableId;

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x0040020020200000000000000000000000000000000000000000000000000000
);

struct AllianceInvitationData {
  bytes32 inviter;
  uint256 timeStamp;
}

library AllianceInvitation {
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
    SchemaType[] memory _keySchema = new SchemaType[](2);
    _keySchema[0] = SchemaType.BYTES32;
    _keySchema[1] = SchemaType.BYTES32;

    return SchemaLib.encode(_keySchema);
  }

  /**
   * @notice Get the table's value schema.
   * @return _valueSchema The value schema for the table.
   */
  function getValueSchema() internal pure returns (Schema) {
    SchemaType[] memory _valueSchema = new SchemaType[](2);
    _valueSchema[0] = SchemaType.BYTES32;
    _valueSchema[1] = SchemaType.UINT256;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "entity";
    keyNames[1] = "alliance";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](2);
    fieldNames[0] = "inviter";
    fieldNames[1] = "timeStamp";
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
   * @notice Get inviter.
   */
  function getInviter(bytes32 entity, bytes32 alliance) internal view returns (bytes32 inviter) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (bytes32(_blob));
  }

  /**
   * @notice Get inviter.
   */
  function _getInviter(bytes32 entity, bytes32 alliance) internal view returns (bytes32 inviter) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (bytes32(_blob));
  }

  /**
   * @notice Set inviter.
   */
  function setInviter(bytes32 entity, bytes32 alliance, bytes32 inviter) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((inviter)), _fieldLayout);
  }

  /**
   * @notice Set inviter.
   */
  function _setInviter(bytes32 entity, bytes32 alliance, bytes32 inviter) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((inviter)), _fieldLayout);
  }

  /**
   * @notice Get timeStamp.
   */
  function getTimeStamp(bytes32 entity, bytes32 alliance) internal view returns (uint256 timeStamp) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get timeStamp.
   */
  function _getTimeStamp(bytes32 entity, bytes32 alliance) internal view returns (uint256 timeStamp) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set timeStamp.
   */
  function setTimeStamp(bytes32 entity, bytes32 alliance, uint256 timeStamp) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((timeStamp)), _fieldLayout);
  }

  /**
   * @notice Set timeStamp.
   */
  function _setTimeStamp(bytes32 entity, bytes32 alliance, uint256 timeStamp) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((timeStamp)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get(bytes32 entity, bytes32 alliance) internal view returns (AllianceInvitationData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(bytes32 entity, bytes32 alliance) internal view returns (AllianceInvitationData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(bytes32 entity, bytes32 alliance, bytes32 inviter, uint256 timeStamp) internal {
    bytes memory _staticData = encodeStatic(inviter, timeStamp);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(bytes32 entity, bytes32 alliance, bytes32 inviter, uint256 timeStamp) internal {
    bytes memory _staticData = encodeStatic(inviter, timeStamp);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32 entity, bytes32 alliance, AllianceInvitationData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.inviter, _table.timeStamp);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32 entity, bytes32 alliance, AllianceInvitationData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.inviter, _table.timeStamp);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(bytes memory _blob) internal pure returns (bytes32 inviter, uint256 timeStamp) {
    inviter = (Bytes.slice32(_blob, 0));

    timeStamp = (uint256(Bytes.slice32(_blob, 32)));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   *
   *
   */
  function decode(
    bytes memory _staticData,
    PackedCounter,
    bytes memory
  ) internal pure returns (AllianceInvitationData memory _table) {
    (_table.inviter, _table.timeStamp) = decodeStatic(_staticData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 entity, bytes32 alliance) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 entity, bytes32 alliance) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(bytes32 inviter, uint256 timeStamp) internal pure returns (bytes memory) {
    return abi.encodePacked(inviter, timeStamp);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dyanmic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    bytes32 inviter,
    uint256 timeStamp
  ) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData = encodeStatic(inviter, timeStamp);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 entity, bytes32 alliance) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = entity;
    _keyTuple[1] = alliance;

    return _keyTuple;
  }
}
