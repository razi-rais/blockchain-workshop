var MultiSigContract = artifacts.require("./MultiSigWallet.sol");

module.exports = function(deployer) {
  // deployment steps
 
  //NOTE: Make sure to update the accounts below based on your Ethereum envrioment. 
  var accounts = ["0x","0x", "0x"];
 
  //Number of owner signatures required before transaction can be executed.
  var requiredSignCount = 2;

  deployer.deploy(MultiSigContract,accounts, requiredSignCount);

};

