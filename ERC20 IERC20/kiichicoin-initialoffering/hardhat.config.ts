/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 import { HardhatUserConfig } from 'hardhat/config';
import "@nomiclabs/hardhat-waffle";
import '@openzeppelin/hardhat-upgrades';
// import "@openzeppelin/contracts";

const config: HardhatUserConfig = {
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