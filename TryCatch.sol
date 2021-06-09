// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract Test {
    
    address public owner;
    
    event Created(address owner);
    
    constructor (address _owner) {
        require(_owner != address(0), "invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
        emit Created(_owner);
    }
    
    function called(uint x) public pure returns (string memory) {
        require(x != 0, "require failed");
        return "CALLED";
    }
}

contract TryCatch {
    event Log(string message);
    event LogBytes(bytes data);
    
    Test public test;
    
    constructor() {
        test = new Test(msg.sender);
    }
    
    function tryCatchExternalCall(uint _number) public {
        try test.called(_number) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("function call failed");
        }
    }
    
    function tryCatchNewContract(address _owner) public {
        try new Test(_owner) {
            emit Log("contract Test created");
        } catch Error(string memory reason) {
            emit Log(reason);
        } catch (bytes memory  reason) {
            emit LogBytes(reason);
        }
    }
}