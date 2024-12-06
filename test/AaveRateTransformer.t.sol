pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

import {AaveMarketRateTransformer} from "../contracts/AaveMarketRateTransformer.sol";
import {ERC4626RateProvider} from "../contracts/ERC4626RateProvider.sol";

import {IERC4626} from "@openzeppelin/contracts/interfaces/IERC4626.sol";


interface IWrapper {
    function rateProvider() external view returns (address);
}

interface IERC4626RateProvider {
    function getRate() external view returns (uint256);
    function erc4626() external view returns (address);
}

contract AaveMarketRateTransformerTest is Test {

    function setUp() public {
        string memory RPC_URL = vm.envString("RPC_URL");
        vm.createSelectFork(RPC_URL, 21342806);
    }

    function testGetsRate() public {
        // wsteth on mainnetq
        address rateSource = 0x72D07D7DcA67b8A406aD1Ec34ce969c90bFEE768;
        address erc4626Vault = 0x775F661b0bD1739349b9A2A3EF60be277c5d2D29;

        ERC4626RateProvider erc4626rateProvider = new ERC4626RateProvider(IERC4626(erc4626Vault));

        uint256 wstEthRate = IERC4626RateProvider(rateSource).getRate(); 
        uint256 vaultRate = erc4626rateProvider.getRate();

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