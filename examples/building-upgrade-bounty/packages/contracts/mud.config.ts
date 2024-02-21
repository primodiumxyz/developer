import { mudConfig } from "@latticexyz/world/register";

export default mudConfig({
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
      keySchema: {
        depositorEntity: "bytes32",
        buildingEntity: "bytes32",
      },
      valueSchema: "uint256",
    },

    /* --------------------------------- Common --------------------------------- */

    Position: {
      keySchema: { entity: "bytes32" },
      valueSchema: {
        x: "int32",
        y: "int32",
        parent: "bytes32",
      },
    },

    OwnedBy: {
      keySchema: { entity: "bytes32" },
      valueSchema: {
        value: "bytes32",
      },
    },
  },
});
