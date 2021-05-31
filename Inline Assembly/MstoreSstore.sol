// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract A {
    
    uint public num;
    
    function set(uint _number) external {
        assembly {
            sstore(0, _number)
        }
    }
    
    fallback() external {
        assembly {
            mstore(0, sload(0))
            return(0, 32)
        }
    }
}

contract B {
    A a;
    
    function setAAddress (address _a) external {
        a = A(_a);
    }
    
    function setNumber(uint _number) external {
        a.set(_number);
    }
    
    function getNumber() external view returns (uint result) {
        (bool ok, bytes memory returnData) = address(a).staticcall("");
        
        if (ok) {
            result = abi.decode(returnData, (uint));    
        }
        
    }
}