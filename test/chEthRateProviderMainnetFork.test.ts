import { ethers } from 'hardhat';
import { expect, assert } from 'chai';
import { BigNumber, Contract } from 'ethers';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/dist/src/signer-with-address';



describe('Coinbase Eth rate provider', function() {
    let cBEthRateProvider: Contract;
    let signer: SignerWithAddress;
    let cbEthAddres = '0xBe9895146f7AF43049ca1c1AE358B0541Ea49704'; //mainnet

    before('setup eoas', async () => {
        [signer, ] = await ethers.getSigners();
    })

    beforeEach('deploy rate provider', async () =>{
        const CBEthRateProvider = await ethers.getContractFactory('CbEthRateProvider');
        cBEthRateProvider = await CBEthRateProvider.deploy(cbEthAddres);
    })
    it('checks if proxy = asset in rate provider',async () => {
        expect(await cBEthRateProvider.cbETH()).to.equal(cbEthAddres)
    })
    it('greater than 18 decimals scale - scaled',async () => {
        let currentRate = await cBEthRateProvider.getRate();
        expect(currentRate.gt(BigNumber.from(10).pow(18))).to.be.true;
    })
    it('is lower than 19 decimals - scaled',async () => {
        let currentRate = await cBEthRateProvider.getRate();
        expect(currentRate.lt(BigNumber.from(10).pow(19))).to.be.true;
    })
})