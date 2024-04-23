import { defineWorld } from "@latticexyz/world";

export default defineWorld({
  namespace: "PluginExamples",
  systems: {
    WriteDemoSystem: {
      name: "WriteDemoSystem",
      openAccess: true,
    },
  },
  tables: {},
});
