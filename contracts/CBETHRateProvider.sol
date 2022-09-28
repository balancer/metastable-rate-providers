// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./interfaces/IcbETH.sol";
import "./interfaces/IRateProvider.sol";


/**
 * @title Coinbase wrapped staked Eth Rate Provider
 * @notice Returns value of cbEth in terms of Eth
 */
contract CbEthRateProvider is IRateProvider {
    IcbETH public immutable cbETH;
    address public origin;

    constructor(IcbETH _cbETH) {
        cbETH = _cbETH;

    }

    /**
     * @return value of cbETH in terms of Eth scaled by 10**18
     */
    function getRate() public view override returns (uint256) {
        return cbETH.exchangeRate();
    }
}