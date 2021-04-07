// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

// learn from 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol 
// https://forum.openzeppelin.com/t/deploy-a-simple-erc20-token-in-remix/1203
// https://forum.openzeppelin.com/t/simple-erc20-token-example/4403


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract KiichiToken is ERC20 {
    
    constructor() ERC20("Kiichi", "KTT") {
            _mint(msg.sender, 100);
    }
    
}