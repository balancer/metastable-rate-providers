import { HardhatUserConfig } from 'hardhat/config';

import '@nomiclabs/hardhat-ethers';
import '@nomiclabs/hardhat-waffle';
import '@nomiclabs/hardhat-etherscan';

const CHAIN_IDS = {
  hardhat: 31337, // chain ID for hardhat testing
};

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: '0.8.8',
      },
      {
        version: '0.7.4',
        settings: {
          optimizer: {
            enabled: true,
            runs: 9999,
          },
        },
      },
    ],
  },
  etherscan: {
    apiKey: {
      goerli: 'etherscan key',
      mainnet: 'etherscan key',
    },
  },
  networks: {
    hardhat: {
      chainId: CHAIN_IDS.hardhat,
      forking: {
        url: `archival node`,
        blockNumber: 15868474,
      },
    },
    goerli: {
      url: 'endpoint',
      accounts: ['pk'],
    },
    mainnet: {
      url:'endpoint',
      accounts: ['pk'],
    }
  },
};

export default config;

