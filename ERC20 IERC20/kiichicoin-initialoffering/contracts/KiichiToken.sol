// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract KiichiToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Kiichi Token", "KTT") {
        _mint(msg.sender, initialSupply);
    }
} 