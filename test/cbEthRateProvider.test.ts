import { ethers } from 'hardhat';
import { expect } from 'chai';
import { Contract } from 'ethers';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/dist/src/signer-with-address';


describe('Coinbase Eth rate provider', function() {
    let mockCBEth: Contract;
    let cBEthRateProvider: Contract;
    let signer: SignerWithAddress;
    let tempAddress;

    before('setup eoas', async () => {
        [signer, ] = await ethers.getSigners();
    })

    beforeEach('deploy mock & rate provider', async () =>{
        const MockCBEth = await ethers.getContractFactory('MockCBEth');
        mockCBEth = await MockCBEth.deploy();
        tempAddress = mockCBEth.address;
        const CBEthRateProvider = await ethers.getContractFactory('CbEthRateProvider');
        cBEthRateProvider = await CBEthRateProvider.deploy(tempAddress);

    })

    it('returns rate scaled correctly', async () => {
        expect(await mockCBEth.exchangeRate()).to.equal(ethers.utils.parseUnits('1', 18));
    })
    it('can set rate', async () => {
        await mockCBEth.setExchangeRate(2)
        expect(await mockCBEth.exchangeRate()).to.equal(ethers.utils.parseUnits('2', 18));
    })
    it('gets rate from rateProvider',async () => {
        expect(await cBEthRateProvider.getRate()).to.equal(ethers.utils.parseUnits('1', 18));
    })
    it('gets correct rate from rateProvider after underlying rate update',async () => {
        await mockCBEth.setExchangeRate(2);
        expect(await cBEthRateProvider.getRate()).to.equal(ethers.utils.parseUnits('2', 18));
    })
})