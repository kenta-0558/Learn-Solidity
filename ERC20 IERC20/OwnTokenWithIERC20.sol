//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;


interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
}

contract KiichiToken is IERC20 {
    
    
    string public constant name = "KiichiToken";
    string public constant symbol = "KTT";
    uint8 public constant decimals = 18;
    
    mapping (address => uint256) balances;
    
    uint256 totalSupply_;
    
    constructor(uint256 _totalSupply) {
        totalSupply_ = _totalSupply;
        balances[msg.sender] = totalSupply_;
    }
    
    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }
    
    function balanceOf(address _accountOwner) public override view returns (uint256) {
        return balances[_accountOwner];
    }
}