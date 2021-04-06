// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract PersonBase {
    
    event NewMember(string firstname, string familyname, uint age, string nationality);
    
    struct Person {
        string firstname;
        string familiyname;
        uint age;
        string nationality;
    }
    
    Person[] public persons;
    
    mapping (address => Person) addressToPerson;
    
    function createPerson(
        string memory _firstname, 
        string memory _familyname,
        uint _age,
        string memory _nationality
    ) external 
      returns (uint)
    {
        require(
            bytes(_firstname).length != 0 ||
            bytes(_familyname).length != 0 ||
            _age != 0 ||
            bytes(_nationality).length != 0 
        );
        
        Person memory newPerson = Person(_firstname, _familyname, _age, _nationality);
        
        persons.push(newPerson);
        
        addressToPerson[msg.sender] = newPerson;
        
        emit NewMember(_firstname, _familyname, _age, _nationality);
        
        uint newPersonId = persons.length - 1;
        
        return newPersonId;
        
    }
    
    function getPersons() public view returns(Person[] memory) {
        return persons;
    }
    
    function getMyData() public view returns(Person memory) {
        return addressToPerson[msg.sender];
    }
    
}