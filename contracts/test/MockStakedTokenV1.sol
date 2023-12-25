//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MockStakedTokenV1 {
    uint256 private _exchangeRate = 1; 

    function exchangeRate() external view returns(uint256){
        return _exchangeRate*1e18;
    } 

    // anyone can set the rate in this mock example
    function setExchangeRate(uint256 newRate) external {
        _exchangeRate = newRate;
    }
}


