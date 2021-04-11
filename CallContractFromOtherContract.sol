// https://ethereum.stackexchange.com/questions/45277/calling-one-contract-to-another-contract-method
// https://ethereum.stackexchange.com/questions/1599/basic-example-of-interaction-between-2-contracts

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract Base {
    
    uint public A;
    string public B;
    
    function setAB(uint _a, string memory _b) public {
        A = _a;
        B = _b;
    }
    
    function getA() public view returns (uint) {
        return A;
    }
    
    function getB() public view returns (string memory) {
        return B;
    }
}

contract Extra {
    
    Base base;
    
    function createBase() public {
        base = new Base();
    }
    
    function getBaseAddress() public view returns (address) {
        return address(base);
    }
    
    function baseSetAB(uint _a, string memory _b) public returns (bool success) {
        base.setAB(_a, _b);
        return true;
    }
    
    function getBaseA() public view returns (uint) {
        return base.getA();
    }
    
    function getBaseB() public view returns (string memory) {
        return base.getB();
    }
    
}

contract Extra2 {
    
    Base base;
    
    function setBase(address _address) public {
        base = Base(_address);
    }
    
    function getBaseAddress() public view returns (address) {
        return address(base);
    }
    
    function baseSetAB(uint _a, string memory _b) public returns (bool success) {
        base.setAB(_a, _b);
        return true;
    }
    
    function getBaseA() public view returns (uint) {
        return base.getA();
    }
    
    function getBaseB() public view returns (string memory) {
        return base.getB();
    }
    
}
