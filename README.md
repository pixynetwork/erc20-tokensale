# Pixy token and crowdsale contract

This repository contains the Pixy Network ERC20 contract and the corresponding crowd sale contract. The crowd sale will be performed by whitelisting individuals that has undergone KYC after which they can purchase tokens up to a given limit.

The ERC20 token is a standard Open Zeppelin implementation with a total supply of 107,000,000. The crowdsale contract is based on Open Zeppelin Signer and Whitelisted roles with custom logic to manage the token sale. 

# Building, testing and deploying

This project was developed with Node version 10.16. To install this on mac, do

```
brew install node@10
brew link node@10
```
You will also need to setup environment variables:
```
export LDFLAGS="-L/usr/local/opt/node@10/lib"
export CPPFLAGS="-I/usr/local/opt/node@10/include"
export PATH="/usr/local/opt/node@10/bin:$PATH"
```

## Dependencies
If you have not done so already, install Ethereum:
```
brew tap ethereum/ethereum
brew install ethereum
```
Next we install truffle and ganache
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
Before you can build, you will need to generate a `.secret` with 12 words in it. To build the project run:

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
