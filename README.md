# <img src="logo.svg" alt="Balancer" height="128px">

# Balancer Metastable Rate Providers

[![CI Status](https://github.com/balancer-labs/metastable-rate-providers/workflows/CI/badge.svg)](https://github.com/balancer-labs/metastable-rate-providers/actions)
[![License](https://img.shields.io/badge/License-GPLv3-green.svg)](https://www.gnu.org/licenses/gpl-3.0)

This repository contains adaptors which provide accurate values of tokens to be used in the Balancer Protocol V2 metastable pools, along with their tests, configuration, and deployment information.

To see how these are used in Balancer V2, see the [Stable Pool package](https://github.com/balancer-labs/balancer-v2-monorepo/tree/master/pkg/pool-stable) in the Balancer V2 monorepo.


## Build and Test

On the project root, run:

```bash
$ yarn # install all dependencies
$ yarn build # compile all contracts
$ yarn test # run all tests
```

## Licensing

Most of the Solidity source code is licensed under the GNU General Public License Version 3 (GPL v3): see [`LICENSE`](./LICENSE).

## on Coinbase staked Ether

cbETH is Coinbase Wrapped Staked Ether. The verified contract can be found [here](https://etherscan.io/address/0xBe9895146f7AF43049ca1c1AE358B0541Ea49704#readProxyContract%23F12) The exchange rate can be pulled from the smart contract. cbETH is built on Coinbase's [wrapping token contract](https://github.com/coinbase/wrapped-tokens-os). Coinbase controls the oracle's address and will update the exchangeRate every 24 hours at 4pm UTC. This update cadence may change in the future. It was audited by [OpenZeppelin](https://blog.openzeppelin.com/coinbase-liquid-staking-token-audit/).

## on Coinbase staked Ether rate provider

A verified version of this rateProvider is avilable on goerli on `0xdF36De97c05fD5114E26212cfBD67d368AE03374`

