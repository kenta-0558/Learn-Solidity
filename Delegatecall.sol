// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;


contract Test {
    
    string public name;
    address public sender;
    uint public value;
    
    function setVariables(string memory _name) public payable {
        name = _name;
        sender = msg.sender;
        value = msg.value;
    }
}

contract Delegatecall {
    
    string public name;
    address public sender;
    uint public value;
    
    function updateVariables(Test test, string memory  _name) public payable {
        
        (bool success, bytes memory data) = address(test).delegatecall(
            abi.encodeWithSignature("setVariables(string)", _name)    
        );
        
    }
}