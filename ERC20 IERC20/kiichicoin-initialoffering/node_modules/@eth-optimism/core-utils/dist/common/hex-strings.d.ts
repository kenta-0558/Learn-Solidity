/// <reference types="node" />
import { BigNumber } from 'ethers';
export declare const remove0x: (str: string) => string;
export declare const add0x: (str: string) => string;
export declare const isHexString: (inp: any) => boolean;
export declare const fromHexString: (inp: Buffer | string) => Buffer;
export declare const toHexString: (inp: Buffer | string | number | null) => string;
export declare const toRpcHexString: (n: number | BigNumber) => string;
export declare const padHexString: (str: string, length: number) => string;
export declare const getLen: (pos: {
    start;
    end;
}) => number;
export declare const encodeHex: (val: any, len: number) => string;
export declare const toVerifiedBytes: (val: string, len: number) => string;
export declare const getRandomHexString: (byteLength: number) => string;
