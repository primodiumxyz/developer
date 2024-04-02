import React from "react";
import { DocsThemeConfig } from "nextra-theme-docs";
import { useRouter } from "next/router";

const config: DocsThemeConfig = {
  logo: <span className="logo">Primodium Developer</span>,
  useNextSeoProps() {
    const { asPath } = useRouter();
    return {
      titleTemplate:
        asPath === "/" ? "Primodium Developer" : "%s – Primodium Developer",
    };
  },
  project: {
    link: "https://github.com/primodiumxyz/developer",
  },
  head: (
    <>
      <meta property="title" content="Primodium Developer Documentation" />
      <link rel="icon" href="/favicon.ico" />
    </>
  ),
  docsRepositoryBase:
    "https://github.com/primodiumxyz/developer/tree/main/docs",
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
  sidebar: {
    defaultMenuCollapseLevel: 3,
  },
};

export default config;
