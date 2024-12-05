pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

import {AaveMarketRateTransformer} from "../contracts/AaveMarketRateTransformer.sol";
import {AaveMarketRateTransformerFactory} from "../contracts/AaveMarketRateTransformerFactory.sol";
interface IBaseFactory {
    function isRateProviderFromFactory(address rateProvider) external view returns (bool);
}

contract AaveMarketRateTransformerFactoryTest is Test {

    function setUp() public {
        string memory RPC_URL = vm.envString("RPC_URL");
        vm.createSelectFork(RPC_URL);
    }

    function testFactory() public {
        // the vaults asset price feed
        // wsteth for this example
        address rateSource = 0x72D07D7DcA67b8A406aD1Ec34ce969c90bFEE768;
        address erc4626Vault = 0x775F661b0bD1739349b9A2A3EF60be277c5d2D29;

        // deploy the wrapper factory
        AaveMarketRateTransformerFactory factory = new AaveMarketRateTransformerFactory();

        // deploy the rate provider wrapper
        AaveMarketRateTransformer rateProvider = factory.create(rateSource, erc4626Vault);


        uint256 rate = rateProvider.getRate();
        // check the rate is not zero
        vm.assertGt(rate, 0);
        // vm.assertEq(rate, 1e18);

        

        // test the rp is from the factory
        vm.assertEq(factory.isRateProviderFromFactory(address(rateProvider)), true);
    }
}