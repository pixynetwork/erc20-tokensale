# Pixy token and crowdsale contract

This repository contains the Pixy Network ERC20 contract and the corresponding crowd sale contract. The crowd sale will be performed by whitelisting individuals that has undergone KYC after which they can purchase tokens up to a given limit.

The ERC20 token is a standard Open Zeppelin implementation with a total supply of 107,000,000. The crowdsale contract is based on Open Zeppelin Signer and Whitelisted roles with custom logic to manage the token sale. 

# Building, testing and deploying

This project was developed with Node version XX.YY.

## Dependencies
First we install truffle and ganache
```
npm install -g truffle ganache-cli
```
To install the project dependencies

```
npm install
```
## Set the deployment configuration on enviroment

Before running and building the project, we export these test configuration variables for the gas rate and limits:

```
export INITIAL_RATE="1000"
export INITIAL_LIMIT="1000000000000000000000"
```
## Build

To build the project run:

```
npm run build
```
## Run tests

Tests are ran by:

```
npm run test
```
## Test Deployment

- Run ganache cli

```
ganache-cli
```

- Deploy

```
npm run staging
```

## Mainnet Deployment

- Set network configuration on truffle-config.js
- Set wallet mnemonic into ".secret" file on root folder
- Deploy with 

```
npm run deploy
```

# Description of contract

The contract consists of two contracts. The first contract is a standard Open Zeppelin ERC20 contract and will not be described here. The second contract is the crowd sale contract. This one contains custom logic. We describe the purpose of the logic below:


## The crowdsale contract

Function | Purpose 
------- | --- 
purchaseTokens | Used to purchase tokens. 
setPurchaseLimit | Sets the limit which any one address can purchase. 
updateRate | Updates the price per token. 
withdrawEth | Withdraws ETH from the contract
withdrawToken | Withdraws Pixy tokens from the contract 
