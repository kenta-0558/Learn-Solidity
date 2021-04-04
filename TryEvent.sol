// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

//https://ethereum.org/ig/developers/tutorials/logging-events-smart-contracts/

contract Counter {
    
    event ValueChanged(uint oldValue, uint newValue);
    
    uint private count = 0;
    
    function increment() public {
        count += 1;
        emit ValueChanged(count - 1, count);
    }
    
    function getCount() public view returns (uint) {
        return count;
    }
}

//https://www.bitdegree.org/learn/solidity-events

contract SimpleAuction {
    event HighestBidIncreased(address bidder, uint amount);
    
    function bid() public payable {
        
        emit HighestBidIncreased(msg.sender, msg.value);
    }
}

// contract clientReceipt {
//     event Deposit(address indexed _from, bytes32 indexed _id, uint _value);
    
//     function deposit(bytes32 _id) public payable {
        
//         emit Deposit(msg.sender, _id, msg.value);
//     }
// }

// https://github.com/ethchange/smart-exchange/blob/master/lib/contracts/SmartExchange.sol

// contract TestEvent {
    
//     event Transfer()
// }