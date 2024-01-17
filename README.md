# Primodium Developer Docs and Examples

This monorepo contains documentation and examples for Primodium developers.

## Directories

```
/docs
/examples
  /plugin-minimal # TODO for Cometshock
  /plugin-usdc-transfer # TODO for Cometshock
  /plugin-delegate-oribiting-fleet # TODO for Cometshock
```

NOTE: The example MUD projects in `examples` are meant to be used independently as templates. A `packages` directory will be created for relevant external packages for plugin examples in the future.

## Testnet Deployment

Primodium is currently deployed to an OP Stack rollup hosted by Caldera that resolves to Sepolia. Before deploying, you will need to bridge ETH from Sepolia to the Primodium testnet. You can do this using the [Caldera Bridge](https://sepolia.calderabridge.xyz/).

To deploy a MUD contract to the Primodium testnet for interoperability with the testnet Primodium world contract, use the following deployment settings.

```
[profile.caldera-sepolia]
eth_rpc_url = "https://primodium-sepolia.rpc.caldera.xyz/http"
chain_id = 10017
```

Testnet links:

- [Primodium Production Deployment](https://www.primodium.com)
- [Bridge from Sepolia to Primodium testnet](https://primodium-sepolia.calderabridge.xyz/)
- [Block Explorer](https://primodium-sepolia.explorer.caldera.xyz/)
