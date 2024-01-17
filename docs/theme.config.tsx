import React from "react";
import { DocsThemeConfig } from "nextra-theme-docs";

const config: DocsThemeConfig = {
  logo: <span>My Project</span>,
  project: {
    link: "https://github.com/primodiumxyz/docs",
  },
  chat: {
    link: "https://discord.gg/fFFtwhTVWm",
  },
  docsRepositoryBase:
    "https://github.com/primodiumxyz/developers/packages/docs",
  footer: {
    text: "Nextra Docs Template",
  },
};

export default config;
