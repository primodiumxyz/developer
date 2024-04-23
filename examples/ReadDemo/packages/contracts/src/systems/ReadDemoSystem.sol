// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { System } from "@latticexyz/world/src/System.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

import { Home } from "primodium/tables/Home.sol";
import { Level } from "primodium/tables/Level.sol";

// We're building a System, to extend the System contract
contract ReadDemoSystem is System {
  function readMainBaseLevel() public returns (uint32) {
    // we want to read from the Primodium World, not the Extension World
    StoreSwitch.setStoreAddress(_world());

    // Get the players ID
    // msg.sender in this case will be the World. We want the player instead.
    // use _msgSender() to get the address of the player calling the function
    bytes32 playerEntity = bytes32(uint256(uint160(_msgSender())));

    // Home.get is dual purpose. Using it on a player ID returns their home asteroid ID
    // Using it on an asteroid ID returns the base building ID of that asteroid

    // get the ID of the players home base asteroid
    bytes32 asteroidEntity = Home.get(playerEntity);

    // get the ID of the base building on the players home base asteroid
    bytes32 baseEntity = Home.get(asteroidEntity);

    // get and return the level of the base building
    return uint32(Level.get(baseEntity));
  }
}
