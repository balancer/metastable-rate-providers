pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

interface IWrapper {
    function rateProvider() external view returns (address);
}

interface IERC4626RateProvider {
    function getRate() external view returns (uint256);
    function erc4626() external view returns (address);
}

import {AaveMarketRateTransformer} from "../contracts/AaveMarketRateTransformer.sol";
contract AaveMarketRateTransformerTest is Test {

    function setUp() public {
        string memory RPC_URL = vm.envString("RPC_URL");
        vm.createSelectFork(RPC_URL);
    }

    function testGetsRate() public {
        // wsteth on mainnetq
        address rateSource = 0x72D07D7DcA67b8A406aD1Ec34ce969c90bFEE768;
        address erc4626Vault = 0x775F661b0bD1739349b9A2A3EF60be277c5d2D29;

        uint256 wstEthRate = 1186768427816612869; // was somewhere around 21330267 block
        uint256 vaultRate = 1000804101867303003; // was somewhere around 21330267 block


        // deploy the rate provider wrapper
        AaveMarketRateTransformer rateProvider = new AaveMarketRateTransformer(rateSource, erc4626Vault);
        // get the rate
        uint256 rate = rateProvider.getRate();
        // check the rate is not zero
        vm.assertGt(rate, 0);

        // check that the rate is bigger than the erc4626 rate.
        vm.assertGt(rate, IERC4626RateProvider(rateSource).getRate());

        vm.assertEq(rate, (wstEthRate * vaultRate) / 1e18);
    }
}