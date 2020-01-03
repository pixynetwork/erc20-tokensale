# Pixy token and crowdsale contract

# Introduction

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

The contract consists of two 	

## The ERC20 contract

Function | Purpose 
------- | --- 
Seconds | 283 


## The crowdsale contract

Function | Purpose 
------- | --- 
purchaseTokens | 283 
setPurchaseLimit | Sets the limit which any one address can purchase
updateRate | Updates the price per token
withdrawEth | Withdraws ETH from the contract
withdrawToken | Withdraws Pixy tokens from the contract 
