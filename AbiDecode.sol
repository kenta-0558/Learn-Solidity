// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;


contract AbiDecode {
    
    struct Person {
        string name;
        uint age;
        string nationality;
    }
    
    Person[] public persons;
    
    function initialize(bytes memory _newPerson) public returns (bool) {
        
        Person memory newPerson = abi.decode(_newPerson, (Person)); 
        
        persons.push(Person({
            name: newPerson.name,
            age: newPerson.age,
            nationality: newPerson.nationality
        }));
        
        return true;
    }
}