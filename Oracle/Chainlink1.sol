// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/smartcontractkit/chainlink/blob/master/evm-contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";


contract Oracle {
    
    AggregatorV3Interface public priceAggregator;
    
    function setAddress(address _address) external {
        priceAggregator = AggregatorV3Interface(_address);
    }
    
    function getPrice() external view returns (int) {
        
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceAggregator.latestRoundData();
        
        return price;
    }
}