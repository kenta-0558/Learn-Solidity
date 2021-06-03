// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";


interface IKTTToken is IERC20 {
    event KTTTokenBalanceUpdated(address _user, uint _amount);

    function mint(address _account, uint256 _amount) external;
    function burn(address _account, uint256 _amount) external;    
} 

contract KTTToken is IKTTToken {
    
    uint256 private _totalSupply;
    string constant public _NAME = "KTT TOKEN";
    string constant public _SYMBOL = "LUSD";

    mapping (address => uint256) public _balances;
    
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _account) external view override returns (uint256) {
        return _balances[_account];    
    }

    function checkAddress(address _address) internal {
        require(_address != address(0), "No address");
    }

    function _mint(address _account, uint256 _amount) external override {
        checkAddress(_account); 
        _totalSupply += _amount;
        _balances[_account] += _amount;
        emit KTTTokenBalanceUpdated(_account, _amount);
    }
    
}