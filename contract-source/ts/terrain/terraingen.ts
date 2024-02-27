import { formatAndWriteSolidity } from "@latticexyz/common/codegen";
import fs from "fs";
import path from "path";

type terrainFile = { id: string; filePath: string };
type JsonCoords = {
  coord: { x: number; y: number };
  index: number;
  value: string;
};
export async function terraingen(csvSrcs: terrainFile[], outputBaseDirectory: string) {
  const json = csvToJsonCoords(csvSrcs);
  const content = generateContent(json);
  const finalContent = addContext(content);
  const fullOutputPath = path.join(outputBaseDirectory, `scripts/CreateTerrain.sol`);
  await formatAndWriteSolidity(finalContent, fullOutputPath, `Generated terrain`);
}

const numberBase: Record<string, string> = {
  1: "Copper",
  2: "Iron",
  3: "Lithium",
  4: "Sulfur",
  5: "Titanium",
  6: "Kimberlite",
  7: "Iridium",
  8: "Platinum",
};

function csvToJsonCoords(csvUrls: terrainFile[]) {
  const result: Array<JsonCoords> = [];

  csvUrls.forEach((csvUrl) => {
    const csv = fs.readFileSync(csvUrl.filePath, "utf-8");
    const lines = csv.split("\n");
    for (let i = 0; i < lines.length; i++) {
      const currentLine = lines[i]
        .replace(/\s+/g, "")
        .split(",")
        .filter((x) => !!x);
      for (let j = 0; j < currentLine.length; j++) {
        if (currentLine[j] == "-1") continue;
        const value = numberBase[currentLine[j]];
        if (!value) throw new Error(`Invalid value ${currentLine[j]} at line ${i}, column ${j}`);
        result.push({
          coord: { x: j, y: i },
          index: Number(csvUrl.id),
          value: value,
        });
      }
    }
  });

  return result;
}

function generateContent(jsonContent: JsonCoords[]) {
  return jsonContent
    .map((elem) => `P_Terrain.set(${elem.index}, ${elem.coord.x}, ${elem.coord.y}, uint8(EResource.${elem.value}));`)
    .join("");
}

function addContext(str: string) {
  return `// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { P_Terrain } from "codegen/index.sol";
import { EResource } from "codegen/common.sol";

  function createTerrain() {
    ${str}
}
`;
}
