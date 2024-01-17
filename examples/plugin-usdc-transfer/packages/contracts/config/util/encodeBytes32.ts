import { Hex, stringToHex } from "viem";

function encode(value: string | number, length: number): Hex {
  if (typeof value === "number") {
    return `0x${value}`;
  }
  return stringToHex(value.substring(0, length), { size: length });
}

export default function encodeBytes32(value: string | number): Hex {
  return encode(value, 32);
}

export function encodeAddress(value: number | string) {
  return `address(${encode(value, 20)})` as Hex;
}
