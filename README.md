# Tested with nodejs v12.13.0

# Install truffle and ganache
```
npm install -g truffle ganache-cli
```
# Install other dependencies
```
npm install
```
# Set the deployment configuration on enviroment
```
export INITIAL_RATE="1000"
export INITIAL_LIMIT="1000000000000000000000"
```
# Build
```
npm run build
```
# Run tests
```
npm run test
```
# Test Deployment

- Run ganache cli

```
ganache-cli
```
- Deploy
```
npm run staging
```
# Mainnet Deployment

- Set network configuration on truffle-config.js
- Set wallet mnemonic into ".secret" file on root folder
- Deploy with
```
npm run deploy
```