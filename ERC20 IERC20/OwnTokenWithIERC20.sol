//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;


interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approve(address indexed sender, address indexed to, uint256 amount);
}

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}


contract KiichiToken is IERC20 {
    
    
    string public constant name = "KiichiToken";
    string public constant symbol = "KTT";
    uint8 public constant decimals = 18;
    
    mapping (address => uint256) balances;
    
    mapping (address => mapping(address => uint256)) allowances;
    
    uint256 totalSupply_;
    
    using SafeMath for uint256;
    
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
    
    function transfer(address _recipient, uint256 _amount) public override returns (bool) {
        
        require(balances[msg.sender] >= _amount, "you do not have enough token in your account");
        
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_recipient] =  balances[_recipient].add(_amount);
        emit Transfer(msg.sender, _recipient, _amount);
        return true;
    }
    
    function allowance(address _owner, address _spender) public override view returns (uint256) {
        return allowances[_owner][_spender];
    }
    
    function approve(address _spender, uint256 _amount) public override returns (bool) {
        allowances[msg.sender][_spender] = _amount;
        emit Transfer(msg.sender, _spender, _amount);
        return true;
    }
}