// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 


library PriceConverter {
    
    function getPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
    (, int256 answer, , , ) = priceFeed.latestRoundData();
    // ETH/USD rate in 18 digits
    return uint256(answer * 1e10); // Multiply by 10^10 to scale to 18 decimals
}


    // 1000000000
   function getConversionRate(
    uint256 ethAmount,
    AggregatorV3Interface priceFeed
) internal view returns (uint256) {
    uint256 ethPrice = getPrice(priceFeed);
    uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
    // the actual ETH/USD conversion rate, after adjusting the extra 0s.
    return ethAmountInUsd;

}
}