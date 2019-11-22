const truffleAssert = require("truffle-assertions");

const PXY = artifacts.require("PXY");
const Crowdsale = artifacts.require("Crowdsale");

const INITIAL_RATE = process.env.INITIAL_RATE;
const INITIAL_LIMIT = process.env.INITIAL_LIMIT;

contract("Crowdsale", accounts => {
  const testAmount = web3.utils
    .toBN(INITIAL_LIMIT)
    .div(web3.utils.toBN(INITIAL_RATE));
  const testAccount1 = accounts[0];
  const testAccount2 = accounts[1];
  const testAccount3 = accounts[2];

  let tokenInstance;
  let testInstance;

  before(async () => {
    tokenInstance = await PXY.deployed();
    testInstance = await Crowdsale.deployed();

    await tokenInstance.transfer(
      testInstance.address,
      web3.utils.toBN(INITIAL_LIMIT),
      {
        from: testAccount1
      }
    );
  });

  it("whitelist admin should add an account to whitelist", async () => {
    await testInstance.addWhitelisted(testAccount2, {from: testAccount1});

    let listed = await testInstance.isWhitelisted.call(testAccount2);

    assert.equal(listed, true, "User not whitelisted");
  });

  it("user cannot add others to white list", async () => {
    await truffleAssert.reverts(
      testInstance.addWhitelisted(testAccount3, {from: testAccount2}),
      "caller does not have the WhitelistAdmin role"
    );
  });

  it("should receive correct amount of tokens per ether", async () => {
    let starting_token_balance = await tokenInstance.balanceOf(testAccount2);

    let toReceive = testAmount * INITIAL_RATE;

    await testInstance.purchaseTokens({from: testAccount2, value: testAmount});

    let ending_token_balance = await tokenInstance.balanceOf(testAccount2);

    let difference = ending_token_balance - starting_token_balance;

    assert.equal(toReceive, difference, "Tokens not claimed");
  });

  it("should not receive any token due to purchase limit", async () => {
    await truffleAssert.reverts(
      testInstance.purchaseTokens({from: testAccount2, value: testAmount}),
      "Purchase limit exceeded"
    );
  });

  it("signer should receive eth from contract", async () => {
    let contractBalance = await web3.eth.getBalance(testInstance.address);

    let result = await testInstance.withdrawEth(testAccount1, contractBalance, {
      from: testAccount1
    });

    truffleAssert.eventEmitted(result, "EthWithdrawn", ev => {
      return (
        ev[0] === testAccount1 &&
        ev[1].toString() === contractBalance.toString()
      );
    });
  });

  it("should retrieve remaining tokens from contract", async () => {
    let starting_token_balance = web3.utils.toBN(
      await tokenInstance.balanceOf(testAccount1)
    );
    let contractTokenBalance = web3.utils.toBN(
      await tokenInstance.balanceOf(testInstance.address)
    );

    await testInstance.withdrawToken(
      testAccount1,
      contractTokenBalance,
      tokenInstance.address,
      {from: testAccount1}
    );

    let ending_token_balance = web3.utils.toBN(
      await tokenInstance.balanceOf(testAccount1)
    );

    let difference = ending_token_balance.sub(starting_token_balance);

    assert.equal(
      contractTokenBalance.toString(),
      difference.toString(),
      "Retrieve unsuccessful"
    );
  });
});
