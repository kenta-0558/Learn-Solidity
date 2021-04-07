//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;


interface IERC20 {
    function getTotalSupply() external view returns (uint256);
}

contract KiichiToken is IERC20 {
    
    
    string public constant name = "KiichiToken";
    string public constant symbol = "KTT";
    uint8 public constant decimals = 18;
    
    uint256 totalSupply;
    
    constructor(uint256 _totalSupply) public {
        totalSupply = _totalSupply;
    }
    
    function getTotalSupply() public override view returns (uint256) {
        return totalSupply;
    }
}