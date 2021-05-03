// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract Crud {
    
    struct User {
        uint id;
        string name;
    }
    
    User[] public users;
    uint public nextId = 1;
}