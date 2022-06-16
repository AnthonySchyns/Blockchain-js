// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    //constrtor is called when we deploy the contract

    constructor() {
        owner = msg.sender;
    }

 function fund() public payable {
     // Send eth to the contract
     require(msg.value.getConversionRate() > minimumUsd, "Didn't send enough"); // 1e18 = 1eth in wei
     // gas spend after require is give back if require isn't met
     funders.push(msg.sender);
     addressToAmountFunded[msg.sender] += msg.value;

 }

 function withdraw() public onlyOwner {
     for (uint256 funderIndex; funderIndex < funders.length; funderIndex++) {
         address funder = funders[funderIndex];
         addressToAmountFunded[funder] = 0;
     }
     funders = new address[](0);
     //transfer
     //payable(msg.sender).transfer(address(this).balance);
     //send
    // bool sendSuccess = payable(msg.sender).send(address(this).balance);
     //require(sendSuccess, "Send Failed");
     //call
     (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
     require(callSuccess, "Call Failed");
 }

 modifier onlyOwner {
     require(msg.sender == owner, "Sender is not owner");
     //then continuer code
     _;
 }

}