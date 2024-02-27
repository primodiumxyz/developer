import { StaticAbiType } from "@latticexyz/schema-type";
import { ConfigFieldTypeToPrimitiveType, StoreConfig } from "@latticexyz/store";

type Tables<C extends StoreConfig, T = undefined> = {
  [Table in keyof C["tables"]]?: {
    [Field in keyof C["tables"][Table]["valueSchema"]]: T extends undefined
      ? ConfigFieldTypeToPrimitiveType<C["tables"][Table]["valueSchema"][Field]>
      : C["tables"][Table]["keySchema"] extends T
      ? ConfigFieldTypeToPrimitiveType<C["tables"][Table]["valueSchema"][Field]>
      : never;
  };
};

export type PrototypeConfig<C extends StoreConfig> = {
  keys?: { [x: string]: StaticAbiType }[];
  tables?: Tables<C>;
  levels?: Record<number, Tables<C, { level: "uint256" | "ESize" } | { id: unknown }>>;
};

export type PrototypesConfig<C extends StoreConfig> = Record<string, PrototypeConfig<C>>;

export type StoreConfigWithPrototypes = StoreConfig & {
  prototypeConfig: PrototypesConfig<StoreConfig>;
};
