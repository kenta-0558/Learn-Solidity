"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getRandomHexString = exports.toVerifiedBytes = exports.encodeHex = exports.getLen = exports.padHexString = exports.toRpcHexString = exports.toHexString = exports.fromHexString = exports.isHexString = exports.add0x = exports.remove0x = void 0;
const ethers_1 = require("ethers");
const remove0x = (str) => {
    if (str === undefined) {
        return str;
    }
    return str.startsWith('0x') ? str.slice(2) : str;
};
exports.remove0x = remove0x;
const add0x = (str) => {
    if (str === undefined) {
        return str;
    }
    return str.startsWith('0x') ? str : '0x' + str;
};
exports.add0x = add0x;
const isHexString = (inp) => {
    return typeof inp === 'string' && inp.startsWith('0x');
};
exports.isHexString = isHexString;
const fromHexString = (inp) => {
    if (typeof inp === 'string' && inp.startsWith('0x')) {
        return Buffer.from(inp.slice(2), 'hex');
    }
    return Buffer.from(inp);
};
exports.fromHexString = fromHexString;
const toHexString = (inp) => {
    if (typeof inp === 'number') {
        return ethers_1.BigNumber.from(inp).toHexString();
    }
    else {
        return '0x' + exports.fromHexString(inp).toString('hex');
    }
};
exports.toHexString = toHexString;
const toRpcHexString = (n) => {
    let num;
    if (typeof n === 'number') {
        num = '0x' + n.toString(16);
    }
    else {
        num = n.toHexString();
    }
    if (num === '0x0') {
        return num;
    }
    else {
        return num.replace(/^0x0/, '0x');
    }
};
exports.toRpcHexString = toRpcHexString;
const padHexString = (str, length) => {
    if (str.length === 2 + length * 2) {
        return str;
    }
    else {
        return '0x' + str.slice(2).padStart(length * 2, '0');
    }
};
exports.padHexString = padHexString;
const getLen = (pos) => (pos.end - pos.start) * 2;
exports.getLen = getLen;
const encodeHex = (val, len) => exports.remove0x(ethers_1.BigNumber.from(val).toHexString()).padStart(len, '0');
exports.encodeHex = encodeHex;
const toVerifiedBytes = (val, len) => {
    val = exports.remove0x(val);
    if (val.length !== len) {
        throw new Error('Invalid length!');
    }
    return val;
};
exports.toVerifiedBytes = toVerifiedBytes;
const getRandomHexString = (byteLength) => {
    return ('0x' +
        [...Array(byteLength * 2)]
            .map(() => {
            return Math.floor(Math.random() * 16).toString(16);
        })
            .join(''));
};
exports.getRandomHexString = getRandomHexString;
//# sourceMappingURL=hex-strings.js.map