pragma solidity ^0.8.3;


contract Storage {
    string public data;

    function setData(string calldata _data) external {
        data = _data;
    }    
}