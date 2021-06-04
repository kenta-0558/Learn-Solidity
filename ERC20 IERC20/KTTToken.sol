// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

interface IKTTToken is IERC20 {
    event KTTTokenBalanceUpdated(address _user, uint _amount);

    function sendToPool(address _sender,  address poolAddress, uint256 _amount) external;
    // function returnFromPool(address poolAddress, address user, uint256 _amount ) external;
    
    function mint(address _account, uint256 _amount) external;
    function burn(address _account, uint256 _amount) external;    
} 

contract Pool {
    
}

contract KTTToken is IKTTToken {
    using SafeMath for uint256;

    address poolAddress;
    
    uint256 private _totalSupply;
    string constant public _NAME = "KTT TOKEN";
    string constant public _SYMBOL = "LUSD";
    
    mapping (address => uint256) public _balances;

    constructor(address _poolAddress) {
        poolAddress = _poolAddress;
    }
    
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }
    
    function balanceOf(address _account) external override view returns (uint256) {
        return _balances[_account];    
    }
    
    function _mint(address _account, uint256 _amount) external {
        checkAddress(_account); 
        _totalSupply += _amount;
        _balances[_account] += _amount;
        emit KTTTokenBalanceUpdated(_account, _amount);
    }

    function sendToPool(uint256 _amount) external override {
        _transfer(msg.sender, poolAddress, _amount);       
    }
    
    function checkAddress(address _address) internal {
        require(_address != address(0), "No address");
    }
    
}