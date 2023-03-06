# Use Foundry with Solidity CTF

Prepare your environment:

```bash
$ curl -L https://foundry.paradigm.xyz | bash
$ foundryup

$ cp .env.example .env
# edit .env
# charge your address with some BNB
```

Put the challenge source code in `src/` like `src/TenYearsChallenge.sol`.

Create the solution file in `script/` like `script/TenYearsChallenge.s.sol`.

Run the solution with Foundry and the network forking feature as below.

It will use a local node to run the solution and fork the mainnet to get the state.

You can run tests with the same environment without spending any gas.

```bash
$ forge script ./script/TenYearsChallenge.s.sol --fork-url ${RPC_BSC}
```

After you solve the challenge, you can run your solution in the mainnet with the following command.

```bash
$ forge script ./script/TenYearsChallenge.s.sol --rpc-url ${RPC_BSC} --broadcast --private-key ${PRIVATE_KEY}
```