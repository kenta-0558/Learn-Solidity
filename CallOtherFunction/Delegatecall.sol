// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;


contract Storage {
    uint public val;
    
    constructor(uint _v) {
        val = _v;
    }
    
    function setValue(uint _v) external {
        val = _v;
    }
}

contract Machine {
    uint256 public calculateResult;
    
    address public user;
    
    Storage public s;
    
    event AddedValuesByDelegateCall(uint256 a, uint256 b, bool success);
    event AddedValuesByCall(uint256 a, uint256 b, bool success);
    
    constructor(Storage _addr) {
        s = _addr;
        calculateResult = 0;
    }
    
    function saveValue(uint _v) external returns (bool) {
        s.setValue(_v);
        return true;
    }
    
    function getValue() external view returns (uint) {
        return s.val();
    }
    
    function addValuesWithDelegateCall(
        address _calculator, 
        uint256 _a, 
        uint256 _b
    ) 
        public 
        returns (uint256) 
    {
        (bool success, bytes memory result) = _calculator.delegatecall(abi.encodeWithSignature("add(uint256,uint256)", _a, _b));           
        emit AddedValuesByDelegateCall(_a, _b, success);
        return abi.decode(result, (uint256));
    }
    
    function addValuesWithCall(address _calculator, uint256 _a, uint256 _b) public returns (uint256) {
        (bool success, bytes memory result) = _calculator.call(abi.encodeWithSignature("add(uint256,uint256)", _a, _b));
        emit AddedValuesByCall(_a, _b, success);
        return abi.decode(result, (uint256));
    }
}

contract Calculator {
    uint256 public calculateResult;
    
    address public user;
    
    event Add(uint256 a, uint256 b);
    
    function add(uint256 _a, uint256 _b) public returns (uint256) {
        calculateResult = _a + _b;
        assert(calculateResult >= _a);
        
        emit Add(_a, _b);
        user = msg.sender;
        
        return calculateResult;
    }
}