# CSCE-5575-HW2-Template
Blockchain Homework 2 Template for Students.

# Table of Contents
1. [Introduction](#introduction)
2. [Tasks](#tasks)
3. [Environment Setup](#environment%20setup)
4. [Help and Tips](#help%20and%20tips)
5. [Contribution](#contribution)

---
# Introduction
This assignment will be continuation of the first homework where you will perform an almost similar task, however, with the twist of introducing Web3 and Blockchain.
We will be using:
- Blockchain side
	- Ethereum Smart Contracts
	- Solidity
	- Truffle Suite Ganache
	- Foundry Toolchain
- Front-end side
	- ReactJS
	- TypeScript
	- Ethers.js v6 Library
	- TypeChain Library
	- MetaMask
	- NodeJS
	- pnpm

This homework is designed roughly following this guide: https://iiiyu.com/2022/10/24/zero-to-one-full-stack-dapp-ethereum-development-based-on-foundry-nextjs-typescript-latest-version/
You can read and follow this guide, but the guide uses `NextJS` and `Ethers.js v5`, which has a lot of differences compared to `v6`.

---
# Tasks
Overview:
1) Run a local blockchain using `Ganache`
2) Write a smart contract
3) Build and test if smart contract works using `Foundry`
4) Deploy the smart contract to your local blockchain using `Foundry`
5) Import your test account from `Ganache` to `MetaMask`
6) Create your front-end that interacts with the smart contract functions and `MetaMask` wallet

Detailed:
The `Counter.sol` file which is created by `Foundry` (will be explained) is your smart contract. The language used in writing it is called `Solidity`.
You can read about it here: https://docs.soliditylang.org/en/v0.8.21/introduction-to-smart-contracts.html
The `num` variable and the "lorem ipsum" array, as well as the necessary functions, such as `setNumber`, will be defined in your smart contract.

The users (front-end/browser) who are ***connected*** to the blockchain with the `MetaMask`wallet will be able to get the public values, pay eth to interact with the smart contract functions and see their wallet address and eth balance.

The front-end ***MUST*** have the following features:
- A connect button when pressed will invoke `MetaMask` wallet and connect to the blockchain
- After connection, the address and current balance of the wallet must be displayed
- After connection the current `num` from the smart contract must be displayed (no need to periodically update for the value)
- A button to call `getNum` from the smart contract
- A text field and a button to `setNum`. This will also invoke `MetaMask` and the user must pay the fee to call the function
- After the connection, the "lorem, ipsum" array must be also acquired and displayed according to the `num` value (same as HW1)
- After each payment, the wallet balance and `num` value must be automatically updated

The front-end GUI components and styling can be anything you like. No restrictions there.

Keep in mind that when accessing the variables, e.g. calling `get` functions from the smart contract, the user does not pay anything. The user only pays, when the state of the smart contract is changed. Such as calling the `setNumber` function.

---
# Environment Setup
***Note: There are a lot of tools to setup with sometimes a rather long installation/compilation time. Not to mention the learning curve.***

### Ganache
Download link: https://trufflesuite.com/ganache/
Executable download and run.
The setup options are the same as in the guide: https://iiiyu.com/2022/10/24/zero-to-one-full-stack-dapp-ethereum-development-based-on-foundry-nextjs-typescript-latest-version/#Setting-up-the-local-chain-for-development

### Foundry
Foundry is written in `Rust`. So, you need to install `rustup` first. (https://rustup.rs/)
After installing `rustup`, follow this guide (https://book.getfoundry.sh/getting-started/installation) and install `Foundry`.

### ReactJS
You should know this from the first homework. In your `front-end` directory (explained later), install the `TypeChain` and `Ethers` libraries using `pnpm`.

### MetaMask
It is a browser plugin. If you are using FireFox: https://addons.mozilla.org/en-US/firefox/addon/ether-metamask/
To import your test account, follow the Ganache guide.

### Project files
You will have two main directories, one is for the smart contract `chain_end`, the other is for the front-end `front_end`.
So,

```bash
mkdir HW_2 # Create your HW folder
cd HW_2
mkdir chain_end
mkdir front_end
```

Inside the `chain_end`, run:

```bash
forge init .
```

In the `src`, you will see the `Counter.sol`. This is the smart contract file you are going to work with.

In the `front_end` directory, run:

```bash
cd front_end
pnpm create react-app . --template typescript
# Install the required libraries
pnpm install ethers
pnpm install typechain @typechain/ethers-v6
# Start the server
pnpm start
```

---
# Help and Tips
Links:
- Must read: https://iiiyu.com/2022/10/24/zero-to-one-full-stack-dapp-ethereum-development-based-on-foundry-nextjs-typescript-latest-version
- Deploying Smart Contracts using Foundry `forge`: https://book.getfoundry.sh/forge/deploying
- Accessing functions and variables with Foundry `cast`: https://book.getfoundry.sh/cast/
- Ethers library docs: https://docs.ethers.org/v6/getting-started/

### Some Terminology
Taken from https://docs.ethers.org/v6/getting-started/#starting-glossary
- Provider: is a read-only connection to the blockchain, which allows querying the blockchain state, such as account, block or transaction details, querying event logs or evaluating read-only code using call.
  If you are coming from Web3.js, you are used to a Provider offering both read and write access. In Ethers, all write operations are further abstracted into another Object, the Signer.
- Signer: wraps all operations that interact with an account. An account generally has a private key located somewhere, which can be used to sign a variety of types of payloads.
  The private key may be located in memory (using a Wallet) or protected via some IPC layer, such as MetaMask which proxies interaction from a website to a browser plug-in, which keeps the private key out of the reach of the website and only permits interaction after requesting permission from the user and receiving authorization.

### Tips for Smart Contract:
After editing the solidity file, instead of deploying it and trying to access the functions and variables from the front-end, just use `forge`. If you try to do it from the front-end, there may be errors in your contract and/or in your front-end. So, no need to waste time on that.
An example of accessing a function and a public value using `foundry forge`:
```bash
# Inside chain_end directory
# Deploy the contract
forge create --rpc-url http://127.0.0.1:8545 --private-key <test_account_private_key> src/Counter.sol:Counter --legacy
# You will see some output and also the transaction data on Ganache interface.

# Accessing number variable
cast call <contract_address> "num()" --rpc-url http://127.0.0.1:8545
# Contract address can be seen both from Ganache or as the output of the `forge create` command
# Note that we didn't need the private key, since we are not changing the state of the smart contract

# Calling a function / changing the state
cast send <contract_address> "increment()" --rpc-url http://127.0.0.1:8545 --private-key <test_account_private_key> --legacy
```

To get the test account private key, read the Ganache part of the provided guide. Everything you need can be obtained through the `Ganache` UI

***Important: After every change to your smart contract, you must re-deploy it. Re-deployed contracts will have a new address.***
### Example code for connecting to MetaMask
The guide uses `Ethers v5` and the latest version is `v6`. Unfortunately, there were some major changes, so you will not be able to use the guide.
Here are some example codes to interact with the wallet and public values, as well as give you some idea on how to use `Ethers v6`.

***Important: Deal with front-end stuff after you are sure that your contract works and has no bugs.***
After you deploy your contract, make sure to create the `TypeScript code from ABI`. To do this:

```bash
# In the front-end/src directory
pnpm typechain --target ethers-v6 --out-dir generated/contract-types '../../chain_end/out/Counter.sol/Counter.json'
```

After creating the ABI bindings, make sure to import that in your `App.tsx` as well:

```tsx
import { Counter__factory } from './generated/contract-types';
```

### Wallet Connection Example

```tsx
const handleConnectWallet = async () => {
	// ethers.BrowserProvider is a provider for state changes. It will trigger MetaMask
	const myProvider = new ethers.BrowserProvider(window.ethereum)
	setProvider(myProvider) // You must define the setProvider function just like HW1
    if (provider) { // TypeScript is strict with types and you must check for `undefined` variables
      await provider.send('eth_requestAccounts', [])
      const signer = await provider.getSigner()
      setAddress(await signer.getAddress())
	}
}
```

### Accessing Public Value Example

```tsx
const getNumber = async () => {
	// ethers.JsonRpcProvider is for non-state changing operations. It will NOT trigger MetaMask. This uses the TypeChain output.
    const provider = new ethers.JsonRpcProvider()
    const counter = Counter__factory.connect('<contract_address_here>', provider)
    const n = await counter.number()
	console.log(ethers.formatUnits(n)) // Or other operations
}
```

You must use `useEffect` and `setState` to dynamically update acquired values.

---
# Contribution
If you see any errors in descriptions or need more details, please open an Issue Ticket.