// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";


interface IKTTToken is IERC20 {
    function mint(address _account, uint256 _amount) external;
    function burn(address _account, uint256 _amount) external;    
} 