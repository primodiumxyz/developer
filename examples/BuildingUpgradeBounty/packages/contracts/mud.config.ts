import { defineWorld } from "@latticexyz/world";

export default defineWorld({
  namespace: "upgradeBounty",
  systems: {
    UpgrBounSystem: {
      openAccess: true,
      name: "UpgrBounSystem",
      // deposits and withdrawals track the depositor and amount
    },
  },
  tables: {
    UpgradeBounty: {
      key: ["depositorEntity", "buildingEntity"],
      schema: {
        depositorEntity: "bytes32",
        buildingEntity: "bytes32",

        value: "uint256",
      },
    },

    /* --------------------------------- Common --------------------------------- */

    Position: {
      key: ["entity"],
      schema: { entity: "bytes32", x: "int32", y: "int32", parent: "bytes32" },
    },

    OwnedBy: {
      key: ["entity"],
      schema: { entity: "bytes32", value: "bytes32" },
    },
  },
});
