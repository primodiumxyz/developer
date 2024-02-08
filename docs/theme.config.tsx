import React from "react";
import { DocsThemeConfig } from "nextra-theme-docs";
import { useRouter } from "next/router";

const config: DocsThemeConfig = {
  logo: <span className="logo">Primodium Developers</span>,
  useNextSeoProps() {
    const { asPath } = useRouter();
    return {
      titleTemplate:
        asPath === "/" ? "Primodium Developers" : "%s – Primodium Developers",
    };
  },
  project: {
    link: "https://github.com/primodiumxyz/docs",
  },
  chat: {
    link: "https://discord.gg/fFFtwhTVWm",
  },
  head: (
    <>
      <meta property="title" content="Primodium Developer Documentation" />
      <link rel="icon" href="/favicon.ico" />
    </>
  ),
  docsRepositoryBase:
    "https://github.com/primodiumxyz/developers/tree/main/docs",
  footer: {
    text: "© 2024 Primodium",
  },
  primaryHue: {
    dark: 190,
    light: 190,
  },
  primarySaturation: {
    dark: 100,
    light: 80,
  },
};

export default config;
