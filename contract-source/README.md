# Primodium Contract Source

This folder will be the future home of the complete Primodium contract source code. See the [overview](../docs/pages/overview-source.mdx) for more information.

## Quickstart

Contract [Tables](../docs/pages/overview-contracts/tables.mdx):

- [`/contract-source/src/codegen/tables`](./src/codegen/tables): Generated Solidity contracts for each table.
- [`/contract-source/mud.config.ts`](./mud.config.ts): Configuration file that defines each table compliant with the open MUD standard.

Contract [Systems](../docs/pages/overview-contracts/systems.mdx):

- [`/contract-source/src/codegen/world`](./src/codegen/world): Generated Solidity interfaces for each publicly-accessible system.

Contract [Prototype Table Data](../docs/pages/overview-contracts/tables.mdx#prototype-tables):

- [`/contract-source/src/codegen/prototypes/AllPrototype.sol`](./src/codegen/prototypes/AllPrototype.sol): Data populated in prototype tables that store game configuration data such as resource requirements and building costs.

Contract [Prototype Generation Scripts](./overview-source/generation.mdx):

- [`/contract-source/src/codegen/scripts/CreateTerrain.sol`](./src/codegen/scripts/CreateTerrain.sol): [Foundry script](https://book.getfoundry.sh/tutorials/solidity-scripting) for populating terrain ore distribution.
