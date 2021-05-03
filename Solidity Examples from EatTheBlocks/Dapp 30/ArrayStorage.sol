// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;


contract Crud {
    
    struct User {
        uint id;
        string name;
    }
    
    User[] public users;
    uint public nextId = 1;

    function create(string memory _name) public {
        users.push(User(nextId, _name));
        nextId++;
    }

    function find(uint _id) view internal returns (uint) {
        
        for (uint i = 0; i < users.length; i++) {
            if (users[i].id == _id) {
                return i;
            }
        }
        
        revert("User does not exist");
    }

    function update(uint _id, string memory _newName) public {
        uint index = find(_id);
        users[index].name = _newName;
    } 

    function read(uint _id) public view returns (uint, string memory) {
        uint index = find(_id);
        return (users[index].id, users[index].name);
    }

    function destroy(uint _id) public {
        uint index = find(_id);
        delete users[index];
    }
    
}