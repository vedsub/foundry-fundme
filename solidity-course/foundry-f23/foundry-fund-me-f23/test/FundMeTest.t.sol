// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    uint256 favNumber;
    bool greatCourse;
DeployFundMe public deployFundMe;
FundMe public fundMe;
address alice = makeAddr("alice");
   

    function setUp() external {
        favNumber = 1337;
        greatCourse = true;
        console.log("this will be printed first");
        deployFundMe = new DeployFundMe();
    // Initialize fundMe here
    fundMe = deployFundMe.run();
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }
           
    function testPriceFeedVersionIsAccurate() public {
    uint256 version = fundMe.getVersion();
    assertEq(version, 4);

}
function testOwnerIsMsgSender() public {
    assertEq(fundMe.i_owner(), msg.sender);

}
function testFundFailsWIthoutEnoughETH() public {
    vm.expectRevert(); // <- The next line after this one should revert! If not test fails.
    fundMe.fund();     // <- We send 0 value

}
function testFundUpdatesFundDataStructure() public {
    fundMe.fund{value: 10 ether}();
    uint256 amountFunded = fundMe.getAddressToAmountFunded(address(this));
    assertEq(amountFunded, 10 ether);

}
function testFundUpdatesFundDataStructure() public {
    vm.prank(alice);
    fundMe.fund{value: SEND_VALUE}();
    uint256 amountFunded = fundMe.getAddressToAmountFunded(alice);
    assertEq(amountFunded, SEND_VALUE);

}

}
