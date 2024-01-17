# Primodium Developer Docs and Examples

This monorepo contains documentation and examples for Primodium developers.

```
/packages
  /docs
  /example-usdc-reward # TODO for Cometshock
  /example-delegate-oribiting-fleet # TODO for Cometshock
```

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
