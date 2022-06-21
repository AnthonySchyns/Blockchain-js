// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    // constant when we can to spend less gas

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // immutable when we don't declare value immediatly to spend less gas

    address public immutable i_owner;

    //constructor is called when we deploy the contract

    constructor() {
        i_owner = msg.sender;
    }

 function fund() public payable {
     // Send eth to the contract
     require(msg.value.getConversionRate() > MINIMUM_USD, "Didn't send enough"); // 1e18 = 1eth in wei
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
     // revert does the same as require but whe don't store a string and then pay less gas
     if (msg.sender != i_owner) {revert NotOwner();}
     //require(msg.sender == i_owner, "Sender is not owner");
     //then continue code
     _;
 }

 receive() external payable {
     fund();
 }

 fallback() external payable {
     fund();
 }

}