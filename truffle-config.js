require('babel-polyfill');
require('babel-register');

require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');

const test_mnemonic = process.env.TEST_MNEMONIC;

module.exports = {
  networks: {
    develop: {
      provider() {
        return new HDWalletProvider(
          test_mnemonic,
          'http://localhost:8545',
          0,
          10,
        );
      },
      network_id: '1337',
    },
  },

  mocha: {
    timeout: 1000000,
  },

  compilers: {
    solc: {
      version: '^0.6.0',
      settings: {
        optimizer: {
          enabled: true,
          runs: 100,
        },
      },
    },
  },
};
