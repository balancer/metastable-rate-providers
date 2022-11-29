import { ethers } from 'hardhat';
import { expect } from 'chai';
import { BigNumber, Contract } from 'ethers';

describe('Coinbase Eth rate provider - mainnet fork', function () {
  let stakedTokenV1RateProvider: Contract;
  // mainnet coinbase staked ether
  const stakedTokenV1Address = '0xBe9895146f7AF43049ca1c1AE358B0541Ea49704';

  before('setup eoas', async () => {
    console.log('Starting test from block:', await ethers.provider.getBlockNumber());
  });

  beforeEach('deploy rate provider', async () => {
    const StakedTokenV1RateProvider = await ethers.getContractFactory('StakedTokenV1RateProvider');
    stakedTokenV1RateProvider = await StakedTokenV1RateProvider.deploy(stakedTokenV1Address);
  });
  it('checks if proxy = asset in rate provider', async () => {
    expect(await stakedTokenV1RateProvider.stakedTokenV1()).to.equal(stakedTokenV1Address);
  });
  it('greater than 18 decimals scale - scaled', async () => {
    const currentRate = await stakedTokenV1RateProvider.getRate();
    expect(currentRate.gt(BigNumber.from(10).pow(18))).to.be.true;
  });
  it('is lower than 19 decimals - scaled', async () => {
    const currentRate = await stakedTokenV1RateProvider.getRate();
    expect(currentRate.lt(BigNumber.from(10).pow(19))).to.be.true;
  });
});
