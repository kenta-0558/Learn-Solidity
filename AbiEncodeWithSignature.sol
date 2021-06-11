// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;


contract Callee {
    
    string public name;
    uint public age;
    
    function setName(string memory _name) external returns (string memory) {
        name = _name;
        return name;
    }
    
    function setAge(uint256 _age) external returns (uint) {
        age = _age;
        return age;
    }
    
}


contract Caller {
    
    address callee;
    
    event AgeUpdated(uint age);
    event NameUpdated(string name);
    
    constructor(address _callee) {
        callee = _callee;
    }
  
    function updateName(string memory _newName) external {
        
        (bool success, bytes memory data) = callee.call(abi.encodeWithSignature("setName(string)", _newName));
        
        if (success) {
            emit NameUpdated(_newName);
        }
    } 
    
    function updateAge(uint256 _age) external {
        
        (bool success, bytes memory data) = callee.call(abi.encodeWithSignature("setAge(uint256)",_age));
        
        if (success) {
            emit AgeUpdated(_age);
        }
    } 
} 