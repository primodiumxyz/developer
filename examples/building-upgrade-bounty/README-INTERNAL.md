# building-upgrade-bounty

An example of how to extend the Primodium world using namespaces, private systems, and access control.

This example will implement a bounty for an allowlist of addresses to upgrade the owner's buildings in exchange for a small reward of ETH.

## Testing

Internal testing, given that v0.10.0 is not live yet.

### Launch Base Primodium World

Open up a terminal in the root Primodium directory and run:

```bash
echo "PRI_CHAIN_ID=\"dev\"" >> ./.env && echo "PRI_DEV=\"true\"" >> ./.env
pnpm i
pnpm build
pnpm dev:node
```

Open up a second terminal in the root Primodium directory and run:

```bash
pnpm dev:contracts
```

Open up a third terminal in the root Primodium directory and run:

```bash
pnpm dev:client
```

### Staging

Open the client at `localhost:3000/game`. Use Alice's key to connect to the game: `0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d`

Using the client as Alice, construct 3 Iron Mines on the top right plots.

For faster, easier testing, use the `setWorldSpeed` cheatcode in the dev client to hasten the rate of production for all mines.

### Deploy World Extension

Rename `primodium/examples/building-upgrade-bounty/packages/contracts/.env.example` to `primodium/examples/building-upgrade-bounty/packages/contracts/.env`.

Open a new terminal, and navigate to `primodium/examples/building-upgrade-bounty`.

Execute the following:

```bash
pnpm i
pnpm build
```

Navigate to `primodium/examples/building-upgrade-bounty/packages/contracts`.

Next we're going to deploy and register Alice's `upgradeBounty` namespace, systems, functions, and tables to the Admin's world, as well as delegate Alice's `UpgradeBuildingSystem` control to the `UpgrBounSystem` address.

Execute the following:

```bash copy
forge script script/UpgradeBountyExtension.s.sol --rpc-url http://localhost:8545 --broadcast
```

Next, we're going to have Alice use her namespace admin rights to give Bob system access so he can call `UpgrBounSystem` functions.

Execute the following:

```bash copy
forge script script/UpgrBounSystemAccess.s.sol --rpc-url http://localhost:8545 --broadcast
```

Finally, we're going to do the following actions within the same script.

1. Alice deposits a bounty for a building at a specific coordinate.
2. Alice withdraws that bounty (to test it is possible).
3. Alice deposits a new bounty for the same building and coordinate.
4. Bob uses the special delegation that `UpgrBounSystem` has from Alice to upgrade Alice's building on her behalf. He also claims the bounty in the same atomic action.

Execute the following:

```bash copy
forge script script/UpgradeBountyActions.s.sol --rpc-url http://localhost:8545 --broadcast
```

Look at the client, notice that a specific Iron Mine has been upgraded to Iron Mine II!
Additionally, use the `primodium/examples/building-upgrade-bounty/packages/contracts` terminal to check Alice and Bob's ETH balances:

```bash
source .env
cast balance $ADDRESS_ALICE
cast balance $ADDRESS_BOB
```

## Running Test Forks

Given that the complete contract source code for Primodium is not yet released, the most effective way for a third party to test their World Extension is to fork the live testnet and run tests against it. We will use [Foundry](https://book.getfoundry.sh/cheatcodes/create-select-fork)'s `vm.createSelectFork()` test function to achieve this. Here are the suggested steps to complete building a test by forking the live Primodium testnet:

1. Copy `examples/building-upgrade-bounty/packages/contracts/.env.example` and paste it in the same directory, while renaming it to `.env`.
2. Change the `PRIMODIUM_RPC_URL` to the appropriate URL. Our current testnet is `https://primodium-sepolia.rpc.caldera.xyz/http`
3. Change the `WORLD_ADDRESS` to the appropriate contract address. Our current Primodium world address is `0xd5d9aad645671a285d1cadf8e68aef7d74a8a7d0`.
4. Change the `BLOCK_NUMBER` to the your desired block. The current Primodium world was deployed at block number `3007935`, however you may want to use the most recent block given that we may be updating the chain and it will represent the most recent state of the world.
5. If you haven't already, make a new test file in the test folder, like `packages/contracts/test/[YOUR_TEST_FILE_NAME].t.sol`
6. As seen in `examples/building-upgrade-bounty/packages/contracts/test/UpgradeBountyExtension.t.sol`, use `vm.createSelectFork(vm.envString("PRIMODIUM_RPC_URL"), vm.envUint("BLOCK_NUMBER"));` to fork the chain and run Foundry tests against it.
7. In your test file, make sure to at minimum import the following files. See `examples/building-upgrade-bounty/packages/contracts/test/UpgradeBountyExtension.t.sol` for more useful imports.

```solidity
import "forge-std/Test.sol";
import { MudTest } from "@latticexyz/world/test/MudTest.t.sol";
```

8. In order to run the tests, make sure you have navigated your terminal to `examples/building-upgrade-bounty/packages/contracts` and then run `forge test`.

Refer to the [Foundry book](https://book.getfoundry.sh/forge/tests?highlight=test#tests) to learn more about building tests.

## Future Improvements

- [ ] Implement `AgreementMembersSystem.sol` for more readability of access permissions
- [ ] fix coord type in System (future Primodium version)
