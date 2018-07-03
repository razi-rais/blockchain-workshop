var MultiSigContract = artifacts.require("./MultiSigWallet.sol");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(MultiSigContract);
};
