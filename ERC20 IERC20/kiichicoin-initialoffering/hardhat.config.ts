/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 import { HardhatUserConfig } from 'hardhat/config';
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
import '@openzeppelin/hardhat-upgrades';
// import "@openzeppelin/contracts";

const config: HardhatUserConfig = {
  networks: {
    hardhat: {
      // accounts: {
      //   mnemonic: "test test test test test test test test test test test junk"
      // }
    },
  },
  solidity: {
    version: '0.8.3',
    settings: {
      outputSelection: {
        "*": {
            "*": ["storageLayout"],
        },
      },
    }
  },
}

export default config