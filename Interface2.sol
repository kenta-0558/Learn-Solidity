// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface ITest {
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);
    function owner() external view returns (address);
}


contract Test is ITest{
    
    address public override owner;
    
    constructor() {
        owner = msg.sender;
        emit OwnerChanged(address(0), msg.sender);
    }
}