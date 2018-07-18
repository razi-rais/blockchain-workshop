# Multi Signature Wallet
Hands-on lab on creating, deploying and working with Ethereum Multi Signature Wallet.

## Deploy MultiSigWallet Contract

Deploy [MultiSigWallet.sol](/multi-sig-wallet/contracts/MultiSigWallet.sol) either by using Remix (https://remix.ethereum.org) or Truffle. In terms of Ethereum enviroment, you may want to use Remix JavaScript VM or truffle(develop). Please note that [Ganache](https://truffleframework.com/ganache) has a known [bug](https://github.com/trufflesuite/ganache-cli/issues/497) that may impact transactions and revert them when they are send from Remix. 

You need to pass owner accounts to the contructor, along with the number of signatures to execute the transaction (transfer of ether). 

* Note: If you are using truffle make sure to update the account addresses inside [2_multi_signature_wallet_migration.js](/multi-sig-wallet/migrations/2_multi_signature_wallet_migration.js) file, before running the migrations. Also, Ganache has a bug that may impact transactions and revert them when send from Remix. 

 
