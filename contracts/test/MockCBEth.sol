//SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract MockCBEth {
    uint256 private _exchangeRate = 1; 

    function exchangeRate() external view returns(uint256){
        return _exchangeRate*1e18;
    } 

    // anyone can set the rate in this mock example
    function setExchangeRate(uint256 newRate) external {
        _exchangeRate = newRate;
    }
}


