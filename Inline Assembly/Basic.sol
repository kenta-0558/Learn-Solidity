// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract Assembly {
    function addition(uint _x, uint _y) public pure returns (uint) {
        assembly {
            let result := add(_x, _y)
            mstore(0x0, result)
            return(0x0, 32)
        }
    }
}