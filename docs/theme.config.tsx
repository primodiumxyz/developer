import React from "react";
import { DocsThemeConfig } from "nextra-theme-docs";

const config: DocsThemeConfig = {
  logo: <span className="logo">Primodium Developers</span>,
  project: {
    link: "https://github.com/primodiumxyz/docs",
  },
  chat: {
    link: "https://discord.gg/fFFtwhTVWm",
  },
  docsRepositoryBase:
    "https://github.com/primodiumxyz/developers/tree/main/docs",
  footer: {
    text: "© 2024 Primodium",
  },
};

export default config;
