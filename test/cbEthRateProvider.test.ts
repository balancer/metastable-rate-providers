import { ethers } from 'hardhat';
import { expect } from 'chai';
import { Contract } from 'ethers';

describe('StakedTokenV1RateProvider', function () {
  let mockStakedTokenV1: Contract;
  let stakedTokenV1RateProvider: Contract;
  let tempAddress;

  before('setup eoas', async () => {
    console.log('Starting test from block:', await ethers.provider.getBlockNumber());
  });

  beforeEach('deploy mock & rate provider', async () => {
    const MockStakedTokenV1 = await ethers.getContractFactory('MockStakedTokenV1');
    mockStakedTokenV1 = await MockStakedTokenV1.deploy();
    tempAddress = mockStakedTokenV1.address;
    const StakedTokenV1RateProvider = await ethers.getContractFactory('StakedTokenV1RateProvider');
    stakedTokenV1RateProvider = await StakedTokenV1RateProvider.deploy(tempAddress);
  });

  it('returns rate scaled correctly', async () => {
    expect(await mockStakedTokenV1.exchangeRate()).to.equal(ethers.utils.parseUnits('1', 18));
  });
  it('can set rate', async () => {
    await mockStakedTokenV1.setExchangeRate(2);
    expect(await mockStakedTokenV1.exchangeRate()).to.equal(ethers.utils.parseUnits('2', 18));
  });
  it('gets rate from rateProvider', async () => {
    expect(await stakedTokenV1RateProvider.getRate()).to.equal(ethers.utils.parseUnits('1', 18));
  });
  it('gets correct rate from rateProvider after underlying rate update', async () => {
    await mockStakedTokenV1.setExchangeRate(2);
    expect(await stakedTokenV1RateProvider.getRate()).to.equal(ethers.utils.parseUnits('2', 18));
  });
});
