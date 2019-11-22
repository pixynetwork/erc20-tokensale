const PXY = artifacts.require("PXY");
const Crowdsale = artifacts.require("Crowdsale");

const INITIAL_RATE = process.env.INITIAL_RATE;
const INITIAL_LIMIT = process.env.INITIAL_LIMIT;

module.exports = function(deployer) {
  deployer.deploy(PXY).then(function(){
    return deployer.deploy(Crowdsale,INITIAL_RATE, INITIAL_LIMIT, PXY.address)
  })
};