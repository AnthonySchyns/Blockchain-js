// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 50;

 function fund() public payable {
     // Send eth to the contract
     require(msg.value > minimumUsd, "Didn't send enough"); // 1e18 = 1eth in wei
     // gas spend after require is give back if require isn't met
 }

 function getPrice() public view returns(uint256) {
     // 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
     AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
     (, int256 price,,,) = priceFeed.latestRoundData();

     return uint256(price * 1e10);
 }

 function getVersion() public view returns (uint256) {
     AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
     return priceFeed.version();
 }

 function getConversionRate(ethAmount) public view returns(uint256) {

 }

 // function withdraw() {}

}