// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Script.sol";

import "../src/MerkleChallenge/Hack.sol";

contract Runner is Script {
    Hack hack;
    address public developer;

    // use contract wallet to prevent MEV attacks
    function setUp() public {
        hack = new Hack();

        uint256 privateKey = uint256(vm.envBytes32("PRIVATE_KEY"));
        developer = vm.addr(privateKey);
        require(developer == hack.owner(), "wrong owner");
    }

    function run() public {
        uint256 balanceBefore = developer.balance;

        vm.startBroadcast(developer);
        hack.run();
        vm.stopBroadcast();

        uint256 balanceAfter = developer.balance;
        require(balanceAfter > balanceBefore + 0.9 ether, "no profit");
    }
}
