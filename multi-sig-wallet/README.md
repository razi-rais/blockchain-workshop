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
Expand the ```submitTransaction``` method and fill in the details. Destination and value fields corresponds to destination address and ether value respectively. Data field is not used in this case but you can't leave it blank so its value is set to ```0x00```. This is a value in hex and you will see the role of data later in the excercise. 
* destination: 0x583031d1113ad414f02576bd6afabfb302140225
* value: 1
* data: 0x00
<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/multisig-submitTransaction.png">

Finally, press the ```transact``` button. In the Remix console, expand the transaction and look at the details. Notice that their is a ```transactionId``` associated with to this particular transaction. Note ```transactionId``` as it is the unqiue number that will be used to confirm this particular transaction in the next step. Also note down the from address ```0xca35b7d915458ef540ade6068dfe2f44e8fa733c``` and the contract address (its address available in the to field ```0x692a70d2e424a56d2c6c27aa97d1a86395877b3a```).  

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/multisig-transaction.png">


 ## Confirm Transaction
In order for the above transaction (sending 1 ether from contract ```0x692a70d2e424a56d2c6c27aa97d1a86395877b3a``` to ```0x583031d1113ad414f02576bd6afabfb302140225```) to get executed, two owners must confirm it. In real world, this essentially means until required number of signatures are gathered transfer will be delayed. 

To check the number of conformations on this transaction, press ```getConfirmations``` button. Notice, the a single account is listed in the output ```0: address[]: _confirmations 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c```. This means that we have 1 confirmation. If you are wondering when/how this conformation took place? remember that the account  ```0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c``` is one of the owner's account, and it is also the account which submitted the transaction. Because its among the designated owners, automatic confirmation took place (You can however change the contract code if you don't want this to happen) when transaction was submitted. If you look at the ```logs``` section (image above), notice the event ```Confirmation``` was fired at the same time when transaction was submitted. 

We still need one more confirmation from another onwer, before ether can be send to the destination address. In Remix, select one of the owner accounts, make sure it is different from the account that already confirmed the transaction. 

Expand the ```confirmTransaction``` method and enter the ```transactionId```. Finally, press ```transact```. 

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/multisig-confirmTransaction.png">

Expand the transaction in Remix and take a look at logs section. Notice the presense of an event ```Execution```, which essentially means that all confimrations needed for the transfer to take place have been completed. At this point, the destination account ```0x583031d1113ad414f02576bd6afabfb302140225``` should have ```1 ether``` deposited from the wallet address (contract) ```0x692a70d2e424a56d2c6c27aa97d1a86395877b3a```.

You can check the balance of the wallet by pressing ```getCurrentBalance``` button. Remix should show 9 as the balance amount ```0: uint256: 9```.

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/multisig-confirmtTransLog.png">

## Removing Owner
At some point existing owner(s) may need to be replaced. This is a common task, and supported through ```removeOwner``` method which takes existing owner address to be deleted. However, if we allow one of the owners to remove other owner(s) this may lead to undesireable situations. 

For example, a rouge owner will able to remove other owner(s) and then able to perform transfers. To avoid this, we need confirmations from other owners that removal is acceptable. In the context of our contract, owner first send a request to remove another owner through the call to ```submitTransaction``` method. The ```data``` parameter of ```submitTransaction``` method is used to make contract call ```removeOwner``` with desired parameter value. If you try to call ```removeOwner``` directly, the call will fail (this is due to the [```onlyWallet```](https://github.com/razi-rais/blockchain-workshop/blob/master/multi-sig-wallet/contracts/MultiSigWallet.sol#L138) requirement that is put in place on ```removeOwner``` method, which only allows this method to be called by contract itself).

Let's see how we can remove ```0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db``` as an owner.

### Prepare input 
First, we need to prepare the valid input that can be passed to ```data``` parameter of ```removeOwner``` method.

* Take ```removeOwner(address)``` method signature as a string and calculate its Keccak256 hash. Then take first 4 bytes of that hash. The first 4 bytes of the hash of ```removeOwner(address)``` are ```0x7065cb48```. You can use ```web3.sha3("removeOwner(address)")``` to get the hash but its already provided to save time.
