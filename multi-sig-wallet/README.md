# Multi Signature Wallet
Hands-on lab on creating, deploying and working with Ethereum Multi Signature Wallet.

## Deploy MultiSigWallet Contract

Deploy [MultiSigWallet.sol](/multi-sig-wallet/contracts/MultiSigWallet.sol) either by using Remix or Truffle.

You need to pass owner accounts to the contructor, along with the number of signatures to execute the transaction (transfer of ether). 

* Note: If you are using truffle make sure to update the account addresses inside [2_multi_signature_wallet_migration.js](/multi-sig-wallet/migrations/2_multi_signature_wallet_migration.js) file, before running the migrations.

 
