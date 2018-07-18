# Multi Signature Wallet
Hands-on lab on creating, deploying and working with Ethereum Multi Signature Wallet.

## Deploy MultiSigWallet Contract

Deploy [MultiSigWallet.sol](/multi-sig-wallet/contracts/MultiSigWallet.sol) either by using Remix (https://remix.ethereum.org) or Truffle. In terms of Ethereum enviroment, you may want to use Remix JavaScript VM or truffle(develop). Please note that [Ganache](https://truffleframework.com/ganache) has a known [bug](https://github.com/trufflesuite/ganache-cli/issues/497) that may impact transactions and revert them when they are send from Remix. 

You need to pass owner accounts to the constructor, along with the number of signatures to execute the transaction (transfer of ether). 

For example, you can select 2 accounts to be the owners and required signature count is 2. You can copy the account address by expanding the account dropdown and use the copy option (available next to the dropdown).    
```["0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db","0xca35b7d915458ef540ade6068dfe2f44e8fa733c","0x14723a09acff6d2a60dcdf7aa4aff308fddc160c"]```

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/multisig-deploy.png">

* Note: If you are using truffle make sure to update the account addresses inside [2_multi_signature_wallet_migration.js](/multi-sig-wallet/migrations/2_multi_signature_wallet_migration.js) file, before running the migrations. Also, with truffle either use truffle(develop) or Geth/Parity client.

## Sending Ether to the Wallet
Lets send some ether to the wallet (contract). Any account can send ether to the contract. Select one of the accounts from the dropdown and put 10 as the value. Finally press the ```(fallback)``` button.   

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/multisig-fallback.png">

You can check the balance of this wallet by pressing ```getCurrentBalance``` button. Remix should show 10 as the balance amount ```0: uint256: 10``` .
 
 
 ## Submit Transaction
With 10 ethers in the wallet, lets try to send 1 ether to some other destination account (EOA) e.g ```0x583031d1113ad414f02576bd6afabfb302140225```. The destination account will receive 1 ether, after required number of confirmations (signatures) from the owners are recieved. At the moment the require number of signature count is 2, so we will need two owners to confirm this transaction. 

First submit the new transaction using one of the owner's account (e.g. ```0xca35b7d915458ef540ade6068dfe2f44e8fa733c```).
Expand the ```submitTransaction``` method and fill in the details:
* destination: 0x583031d1113ad414f02576bd6afabfb302140225
* value: 1
* data: 0x00

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/multisig-submitTransaction.png">


 
