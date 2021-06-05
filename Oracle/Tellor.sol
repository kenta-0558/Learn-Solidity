// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/tellor-io/usingtellor/blob/master/contracts/UsingTellor.sol";


contract Tellor is UsingTellor {
    
    // address payable kovanTellor = payable(address(0x20374E579832859f180536A69093A126Db1c8aE9));
    uint256 public btcPrice;
    uint256 btcRequestId = 1;
    
    constructor(address payable _address) UsingTellor(_address) {}
    
    function getEthPrice() external {
        bool _didGet;
        uint _timestamp;
        (_didGet, btcPrice, _timestamp) = getCurrentValue(btcRequestId);
        
    }
}
