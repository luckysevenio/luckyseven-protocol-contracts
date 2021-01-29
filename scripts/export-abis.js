const LuckySeven = artifacts.require('LuckySeven');
const fs = require('fs');
const path = require('path');

const files = {
  LuckySeven: {
    constName: 'export const LuckySevenABI: AbiItem[] =',
    tsFileName: 'LuckySevenABI.ts',
    abi: LuckySeven.abi,
  },
};

const base_path = '../abis';
const importAbiItem = "import { AbiItem } from 'web3-utils/types';\n\n";

module.exports = async (callback) => {
  try {
    for (const file of Object.values(files)) {
      const { constName, tsFileName, abi } = file;
      fs.writeFileSync(
        path.resolve(__dirname, `${base_path}/${tsFileName}`),
        importAbiItem + constName + JSON.stringify(abi),
      );
    }
    callback(null);
  } catch (error) {
    callback(error);
  }
};
