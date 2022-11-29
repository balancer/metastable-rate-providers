// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title Coinbase Staked Token interface to return exchangeRate
 * @notice Coinbase Staked token is an ERC20 token backed by staked cryptocurrency reserves
 * `StakedTokenV1` inherits and extends centre's `FiatTokenV2_1`. It is issued to represent
 * the corresponding staked wrapped asset. `StakedTokenV1` implements an additional
 * `exchangeRate` parameter to improve composability.
 */
interface IStakedTokenV1 {
    /**
     * @notice get exchange rate
     * @return returns the current exchange rate scaled by by 10**18
     */
    function exchangeRate() external view returns (uint256);
}
