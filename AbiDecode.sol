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

// parameter to call initialize function of contract from frontend with web3
// const Web3 = require('web3');

// let web3 = new Web3("http://localhost:8545");

// const getEncoded = (name, age, nationality) => {

//     const parameter = {
//         name,
//         age,
//         nationality
//     };

//     const encoded = web3.eth.abi.encodeParameter(
//         {
//             "Person": {
//                 "name": "string",
//                 "age": "uint",
//                 "nationality": "string"
//             },
//         },
//         parameter
//     ); 

//     return encoded;
// }

// const encoded = getEncoded("Ichina", 4, "japanese");

// console.log(encoded);

