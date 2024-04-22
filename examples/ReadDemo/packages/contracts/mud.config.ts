import { defineWorld } from "@latticexyz/world";

export default defineWorld({
  namespace: "PluginExamples",
  systems: {
    ReadDemoSystem: {
      name: "ReadDemoSystem",
      openAccess: true,
    },
  },
  tables: {},
});
