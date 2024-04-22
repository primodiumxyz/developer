# Primodium Extension - Read Demo

This demo will show you how to read `Table` data from the Primodium `World` using a World Extension contract.

## Quickstart

### The demo includes four important files:

- System Contract: `src/ReadDemoSystem.sol`
- System Tests: `test/ReadDemoSystem.t.sol`
- Deployment Script: `scripts/RegisterReadDemoSystem.s.sol`
- Interaction Script: `scripts/ReadMainBaseLevel.s.sol`

### Actions

- Change your active directory:
  - `cd examples/ReadDemo/packages/contracts`
- Install the necessary packages:
  - `pnpm i`
- Build the project:
  - `pnpm build`
- Test the project:
  - `forge test`
- Do a dry-run of deployment:
  - `forge script script/RegisterReadDemoSystem.s.sol --fork-url https://primodium-sepolia.rpc.caldera.xyz/http`
- Deploy the System:
  - `forge script script/RegisterReadDemoSystem.s.sol --fork-url https://primodium-sepolia.rpc.caldera.xyz/http --broadcast`
- Use a script to interact with the system:
  - `forge script script/ReadMainBaseLevel.s.sol --fork-url https://primodium-sepolia.rpc.caldera.xyz/http --broadcast`

## Getting Started (Walkthrough)

It is assumed you have scanned the resources available here:

- https://mud.dev/guides/extending-a-world
- https://developer.primodium.com/world-extension/setup

You shouldn't need it, but the chain config for the Primodium Testnet is:

- Chain ID: 10017
- RPC: https://primodium-sepolia.rpc.caldera.xyz/http
- Block Explorer: https://primodium-sepolia.explorer.caldera.xyz/
- Native Symbol and Currency Name: ETH

## MUD Versions

This tutorial was built against MUD version `2.0.1`. If needed, the command to update to the latest MUD version is:

```bash
pnpm mud set-version --mudVersion 2.0.1 && pnpm i && pnpm build
```

The world address for the extension developer testnet v0.11.x is `0x46c1e9dd144fcf5477a542d3152d28bc0cfba0b6`

The `WORLD_ADDRESS` and `BLOCK_NUMBER` are pre-configured in the `.env.example`. You should copy this to `.env`, and make any desired changes there. This guide was written before the world was deployed, so the `BLOCK_NUMBER` will need to be updated.

The `.gitignore` is already configured to not upload your `.env`, but it is always good practice to confirm the ignores in your `.gitignore` for yourself. Anything pushed to Git lives there forever and can be retrieved by anyone even if you delete it in later commits. Check twice (maybe 3 times), push once. NEVER push live private keys or .env files to Git.

## Extending the World

Since we are interacting with an existing World (Primodium), we will need to know what `Tables` and `Systems` are currently deployed for that World. We have included them in this demo at `packages/contracts/primodium`.

## Setting up mudConfig

The code can be found in `packages/contracts/mud.config.ts`

Every plugin will need a mudConfig, which is stored in `mud.config.ts`. Plugins must exist in a `namespace`. Multiple `Systems` can exist in a namespace.

Since this demo only deploys a system for reading data, we will not need any new `Tables`, but we will need to declare a `Namespace` and `System`.

## Create the System

The commented code can be found in `packages/contracts/src/systems/ReadDemoSystem.sol`

The code should compile with `pnpm build`.

`System` contracts are created in `packages/contracts/src/systems`. They are fairly standard smart contracts that only need to import the critical functionality from MUD or the `World` you are interacting with.

The contract itself is a `System` so we need to import that MUD library. We also need to tell the contract our `Store` target. In this case, we aren't interacting with any local `Table`s since we have none. `StoreSwitch` allows us to specify the `World` address where our target `Table`s reside. The `_world()` function allows us to get the address of the calling `World`, which is the Primodium world in this case.

We import the necessary `Table` libraries from the target `World`. These libraries are constructed by MUD scripts during `pnpm build`, and include the specific `tableId`s and `fieldLayout`s, with appropriate setters and getters. They handle the encoding and decoding of the underlying storage records for us.

## Testing the World Extension

The commented code can be found in `packages/contracts/test/ReadDemoSystem.t.sol`

The test should execute by running `forge test` within the `packages/contracts/` folder. If you want to see additional details, you can run `forge test -vvvv` with 1-5 `v`s to increase verbosity. I generally recommend 4 or 5 for debug.

Before we deploy this system, we should run tests. We'll be using `forge test` in this example, to test against a live deployment. `pnpm mud test` is another option, that has some additional complexities, so we are not using it for now.

We need the import specific features and types to our World Extension. These are found in `../src/codegen/`.

MUD worlds only allow a single instance of a namespace, so if someone has already used a namespace, you can't also use it. The revert should say something like `World_ResourceAlreadyExists()` if there is a namespace collision.

## Deploying the World Extension

The commented code can be found in `packages/contracts/scripts/RegisterReadDemoSystem.s.sol`

Deploying your extension looks much like testing your extension, but occurs in a script. Most of the code is identical to the test, which is kind of the point. Test thoroughly before deploying; deployments are permanent.

Key differences are:

- This is a `Script`, not a `MudTest`.
  - Tests (and MudTests) use vm cheatcodes like startPrank to execute a local simulation. Nothing is impacted on the live chain
  - Scripts can read from and broadcast to the live chain, causing permanent changes.
- We must declare and specify the `WORLD_ADDRESS` variable; it is not inherited from `MudTest`.
- When deploying, you must use a `PRIVATE_KEY` in `.env`, since this action will cost gas.
- Writing to the chain requires startBroadcast() instead of startPrank()

You can do a simulation of a deployment with the following command:

```bash
forge script script/RegisterReadDemoSystem.s.sol --fork-url https://primodium-sepolia.rpc.caldera.xyz/http
```

When you are CERTAIN you are ready to deploy, add the --broadcast option:

```bash
forge script script/RegisterReadDemoSystem.s.sol --fork-url https://primodium-sepolia.rpc.caldera.xyz/http --broadcast
```

## Testing the Deployment

The commented code can be found in `packages/contracts/scripts/ReadMainBaseLevel.s.sol`

Now that the code is live, we can use a script that largely replicates the function we wrote in the test.

```bash
forge script script/ReadMainBaseLevel.s.sol --fork-url https://primodium-sepolia.rpc.caldera.xyz/http --broadcast
```
