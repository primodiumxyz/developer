import { StaticAbiType } from "@latticexyz/schema-type";
import { Hex } from "viem";
import { BASE_RESERVE, RESERVE_RESOURCE, SCALE } from "../../config/constants";
import { EResource, MUDEnums } from "../../config/enums";
import encodeBytes32 from "../../config/util/encodeBytes32";

export const encodeArray = (names: string[]) => names.map(encodeBytes32);

export const indexifyResourceArray = (resources: string[]) =>
  resources.map((resource) => MUDEnums.EResource.indexOf(resource));

/**
 * Generates a supply table for a marketplace given a resource and its ratio to the reserve currency.
 *
 * @param {EResource} resource - The specific resource for which to generate the supply table.
 * @param {number} ratio - The ratio of the resource to the reserve currency. The larger the number, the more reserves there are, and the cheaper the resource in relation to the reserve.
 * @returns An object containing keys and tables for the marketplace supply.
 *          The keys array contains objects with resource types and their corresponding data types.
 *          The tables object includes 'Reserves' with 'amountB' and 'amountA', calculated based on the provided ratio.
 */

export const marketplaceSupplyTable = (
  resource: EResource,
  ratio: number,
  reserveSize?: number
) => {
  const reserve = (reserveSize ?? BASE_RESERVE) * SCALE;
  if (resource == RESERVE_RESOURCE)
    throw new Error(
      "[marketplaceSupplyTable] Cannot use the reserve resource as the marketplace resource"
    );

  // sort the resources so that the reserve resource is always the second key
  const keys =
    resource < RESERVE_RESOURCE
      ? [resource, RESERVE_RESOURCE]
      : [RESERVE_RESOURCE, resource];

  // calculate the reserve amounts based on the ratio
  const inputResourceAmount = BigInt(Math.round(reserve * ratio));
  const reserveResourceAmount = BigInt(reserve);

  const [reserveA, reserveB] =
    resource < RESERVE_RESOURCE
      ? [inputResourceAmount, reserveResourceAmount]
      : [reserveResourceAmount, inputResourceAmount];

  return {
    keys: [{ [keys[0]]: "uint8" }, { [keys[1]]: "uint8" }] as {
      [x: string]: "uint8";
    }[],
    tables: { Reserves: { amountA: reserveA, amountB: reserveB } },
  };
};

export const upgradesByLevel = (
  name: string,
  upgrades: Record<number, Record<string, number>>
) =>
  Object.entries(upgrades).reduce((prev, [level, upgrades]) => {
    const name32 = encodeBytes32(name);
    const upgradesObject = Object.entries(upgrades).reduce(
      (prev, [resource, max]) => {
        const resourceIndex = MUDEnums.EResource.indexOf(resource);
        prev[`${name}${resource}L${level}Upgrade`] = {
          keys: [
            { [name32]: "bytes32" },
            { [resourceIndex]: "uint8" },
            { [level]: "uint32" },
          ],
          tables: {
            P_ByLevelMaxResourceUpgrades: {
              value: BigInt(
                Math.round(
                  max * (unscaledResources.has(resourceIndex) ? 1 : SCALE)
                )
              ),
            },
          },
        };
        return prev;
      },
      {} as Record<
        string,
        {
          keys: { [x: string]: StaticAbiType }[];
          tables: { P_ByLevelMaxResourceUpgrades: { value: bigint } };
        }
      >
    );
    return { ...prev, ...upgradesObject };
  }, {});

export const getResourceValue = (resourceValue: { [x: string]: number }) => {
  const [resource, amount] = Object.entries(resourceValue)[0];
  return {
    resource: MUDEnums.EResource.indexOf(resource),
    amount: BigInt(Math.round(amount * SCALE)),
  };
};

export const getPUnitData = (data: {
  hp: number;
  attack: number;
  defense: number;
  cargo: number;
  speed: number;
  trainingTime: number;
}) => {
  return {
    hp: BigInt(data.hp * SCALE),
    attack: BigInt(data.attack * SCALE),
    defense: BigInt(data.defense * SCALE),
    cargo: BigInt(data.cargo * SCALE),
    speed: BigInt(data.speed),
    trainingTime: BigInt(data.trainingTime),
  };
};
/**
 *
 * @param resourceValues Record of resources and their scaled amounts
 * @param noScale If true, the amounts will not be scaled
 * @returns An object containing the resources and their amounts
 */

const unscaledResources = new Set([
  EResource.U_Housing,
  EResource.U_MaxFleets,
  EResource.U_CapitalShipCapacity,
  EResource.M_DefenseMultiplier,
]);
export const getResourceValues = (resourceValues: Record<string, number>) => {
  // unzip the array
  const [resources, amounts] = Object.entries(resourceValues).reduce(
    (acc, [resource, amount]) => {
      const resourceIndex = MUDEnums.EResource.indexOf(resource);
      acc[0].push(resourceIndex);
      acc[1].push(
        BigInt(
          Math.round(
            amount * (unscaledResources.has(resourceIndex) ? 1 : SCALE)
          )
        )
      );
      return acc;
    },
    [[], []] as [number[], bigint[]]
  );
  return { resources, amounts };
};
export const getPirateObjectiveResourceValues = (
  resourceValues: Record<string, number>
) => {
  const amounts = getResourceValues(resourceValues);
  return { ...amounts, resourceAmounts: amounts.amounts };
};

export const getUnitValues = (unitValues: Record<string, number>) => {
  const [units, amounts] = Object.entries(unitValues).reduce(
    (acc, [resource, amount]) => {
      acc[0].push(encodeBytes32(resource));
      acc[1].push(BigInt(amount));
      return acc;
    },
    [[], []] as [Hex[], bigint[]]
  );
  return { units, amounts };
};

export const upgradesToList = (upgrades: Record<string, number>) => {
  return Object.keys(upgrades).map((resource) =>
    MUDEnums.EResource.indexOf(resource)
  );
};

export const idsToPrototypes = (ids: string[]) =>
  ids
    .map((building, i) => ({
      [i]: {
        P_EnumToPrototype: { value: encodeBytes32(building) },
      },
    }))
    .reduce((acc, curr) => ({ ...acc, ...curr }), {});
