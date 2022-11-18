// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/**
 * @title Coinbase Staked ETH interface to return exchangeRate
 */
interface IcbETH {
    /**
     * @notice get exchange rate
     * @return Returns the current exchange rate scaled by by 10**18
     */
    function exchangeRate() external view returns (uint256);
}
