pragma solidity ^0.8.24;

import { Test } from "forge-std/Test.sol";

import { SavingsUSDSRateProvider } from "../contracts/sUSDSRateProvider.sol";
import { ISSRAuthOracle } from "../contracts/interfaces/ISSRAuthOracle.sol";

contract SavingsUSDSRateProviderTest is Test {
    SavingsUSDSRateProvider rateProvider;

    address oracle = 0x65d946e533748A998B1f0E430803e39A6388f7a1;

    function setUp() public {
        string memory RPC_URL = vm.envString("BASE_RPC_URL");
        vm.createSelectFork(RPC_URL, 25678185);
        rateProvider = new SavingsUSDSRateProvider(ISSRAuthOracle(oracle));
    }

    function testGetsRate() public view {
        uint256 rate = rateProvider.getRate();
        vm.assertGt(rate, 0);
    }

    function testGetsRateScaledDown() public view {
        // get the RAY value from the oracle
        uint256 oracleRate = ISSRAuthOracle(oracle).getChi();
        uint256 downscaledOracleRate = oracleRate / 1e9;

        assertEq(rateProvider.getRate(), downscaledOracleRate);
        assertLt(1e18, rateProvider.getRate());
        assertGt(2e18, rateProvider.getRate());
    }
}
