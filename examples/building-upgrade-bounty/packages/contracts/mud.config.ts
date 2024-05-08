import { defineWorld } from "@latticexyz/world";

export default defineWorld({
  namespace: "upgradeBounty",
  systems: {
    UpgrBounSystem: {
      openAccess: true,
      name: "UpgrBounSystem",
    },
  },
  tables: {
    UpgradeBounty: {
      key: ["depositorEntity", "buildingEntity"],
      schema: {
        depositorEntity: "bytes32",
        buildingEntity: "bytes32",
        bounty: "uint256",
      },
    },

    /* --------------------------------- Common --------------------------------- */

    Position: {
      key: ["entity"],
      schema: {
        entity: "bytes32",
        x: "int32",
        y: "int32",
        parent: "bytes32",
      },
    },

    OwnedBy: {
      key: ["entity"],
      schema: {
        entity: "bytes32",
        value: "bytes32",
      },
    },
  },
});
