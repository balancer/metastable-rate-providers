// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IStakedTokenV1.sol";
import "./interfaces/IRateProvider.sol";

/**
 * @title Coinbase Staked Token interface to return exchangeRate
 * @notice Coinbase Staked token is an ERC20 token backed by staked cryptocurrency reserves
 * `StakedTokenV1` inherits and extends centre's `FiatTokenV2_1`. It is issued to represent
 * the corresponding staked wrapped asset. `StakedTokenV1` implements an additional
 * `exchangeRate` parameter to improve composability. StakedTokenV1 is built on Coinbase's StakedTokenV1.
 * https://github.com/coinbase/wrapped-tokens-os/blob/main/contracts/wrapped-tokens/staking/StakedTokenV1.sol.
 * Coinbase controls the oracle's address and updates exchangeRate
 * every 24 hours at 4pm UTC. This update cadence may change
 * in the future.
 */
contract StakedTokenV1RateProvider is IRateProvider {
    IStakedTokenV1 public immutable stakedTokenV1;

    constructor(IStakedTokenV1 _stakedTokenV1) {
        stakedTokenV1 = _stakedTokenV1;
    }

    /**
     * @return value of StakedTokenV1 exchangeRate in terms of it's underlying scaled by 10**18
     */
    function getRate() public view override returns (uint256) {
        return stakedTokenV1.exchangeRate();
    }
}
