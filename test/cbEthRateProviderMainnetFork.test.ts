import { ethers } from 'hardhat';
import { expect } from 'chai';
import { BigNumber, Contract } from 'ethers';

describe('Coinbase Eth rate provider - mainnet fork', function () {
  let cBEthRateProvider: Contract;
  const cbEthAddress = '0xBe9895146f7AF43049ca1c1AE358B0541Ea49704'; //mainnet

  before('setup eoas', async () => {
    console.log('Starting test from block:', await ethers.provider.getBlockNumber());
  });

  beforeEach('deploy rate provider', async () => {
    const CBEthRateProvider = await ethers.getContractFactory('CbEthRateProvider');
    cBEthRateProvider = await CBEthRateProvider.deploy(cbEthAddress);
  });
  it('checks if proxy = asset in rate provider', async () => {
    expect(await cBEthRateProvider.cbETH()).to.equal(cbEthAddress);
  });
  it('greater than 18 decimals scale - scaled', async () => {
    const currentRate = await cBEthRateProvider.getRate();
    expect(currentRate.gt(BigNumber.from(10).pow(18))).to.be.true;
  });
  it('is lower than 19 decimals - scaled', async () => {
    const currentRate = await cBEthRateProvider.getRate();
    expect(currentRate.lt(BigNumber.from(10).pow(19))).to.be.true;
  });
});
