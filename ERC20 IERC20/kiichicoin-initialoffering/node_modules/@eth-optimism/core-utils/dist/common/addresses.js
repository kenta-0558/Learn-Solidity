"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getRandomAddress = void 0;
const ethers_1 = require("ethers");
const hex_strings_1 = require("./hex-strings");
const getRandomAddress = () => {
    return ethers_1.ethers.utils.getAddress(hex_strings_1.getRandomHexString(20));
};
exports.getRandomAddress = getRandomAddress;
//# sourceMappingURL=addresses.js.map