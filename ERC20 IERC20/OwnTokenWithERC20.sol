// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract KiichiToken is ERC20 {
    
    constructor() ERC20("Kiichi", "KTT") {
            _mint(msg.sender, 100);
    }
    
}