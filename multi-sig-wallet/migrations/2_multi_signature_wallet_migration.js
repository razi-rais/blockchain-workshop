var MultiSigContract = artifacts.require("MultiSigWallet");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(MultiSigContract);
};
