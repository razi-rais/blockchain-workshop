# Tokens
Hands-on lab on creating, deploying and working with Ethereum EIP20 (a.k.a ERC20) Token.

## Deploy MYToken
To begin with, you will deploy all the required contracts including ```MYToken``` ERC20 contract and ```MyExchange``` contract. You will be using Remix for all the tasks in the exercise, but you can also use truffle or any other tool that works with Ethereum.

* Open the [Remix IDE](https://remix.ethereum.org) and create a new file and name it ```AllinOne.sol```. 

* Copy the content of [AllinOne.sol](https://github.com/razi-rais/blockchain-workshop/blob/master/tokens/AllInOne.sol) file and paste it into contract file you have created in the previous step. 

* Select ```MYToken``` from the dropdown that list all the contracts available for deployment, then press ```Deploy```  

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/tokens-1.png">

  
  Note: ```AllinOne.sol``` file contains all the required contracts that MyToken depends upon. The ```MyToken``` contract       leverage [OpenZepppelin](https://github.com/OpenZeppelin/openzeppelin-solidity/tree/v1.2.0/contracts/token) token contracts   heavily, which are all flatten into a single file for convinence. Also, Remix ```import``` feature is not consistent while     working with contracts located on git.
  
Please note the account that you have used to deploy ```MYToken``` contract. This account is also the owner of this contract. To get the owner address, expand the Remix transaction and ```from``` field contains the account addresss e.g. ```0xca35b7d915458ef540ade6068dfe2f44e8fa733c```
  
## Transfer Tokens Directly to Externally Owned Account (EOA) 
To transfer the tokens to a EOA (accounts that are not contract), you will need to use ```transfer``` method inside ```MYToken``` contract. Make sure you are owner of the contract before proceeding. 

Lets transfer 500 tokens from ```MYToken``` to ```0xdd870fa1b7c4700f2bd7f44238821c26f7392148``` (one of the accounts available with JavaScript VM in Remix). 

Locate ```transfer``` method and expand it. Enter destination address (EOA) ```0xdd870fa1b7c4700f2bd7f44238821c26f7392148``` (choose different address if needed) and value of 500 (which is the amount of token that will be transfered). Finally press ```transact``` to execute the transfer.

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/tokens-2.png">

You can verify that tokens have been transfered successfully, by entering ```0xdd870fa1b7c4700f2bd7f44238821c26f7392148``` as an input address to ```balanceOf``` method. Press the ```balanceOf``` button and it should output 500 (ignore the other details in the output)

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/tokens-3.png">

Great, you just transfer tokens to EOA but how about delegating the tasks of transfering token to a a seperate contract? That way you don't have to tranfer tokens your self. Also, you can impose rules like ```1 MyToken costs 1 Ether``` or may be some other rate that you are comfortable with. 

You can do this by creating a simple exchange contract for transferring tokens. Basically, a contract that will be assigned a  certain quota (or allowance) of tokens, that it can tansfer from owner's balance to destination address (EOA or can be another contract). 

## Deploy MyExchange Contract
Lets deploy the ```MyExchange```contract. Select ```MyExchange``` from the list of contracts. You will need to provide two input parameters:

* _MYToken: ```MYToken``` contract address. Within Remix, you can copy the ```MYToken``` address by selecting the copy option next to the ```MYToken at 0xdc0...46222 (memory)``` heading. For example in this case its ```0xdc04977a2078c8ffdf086d618d1f961b6c546222``` (your address may be different)

* _MYTOwner: This is the owner address of ```MYToken```. You can noted it the earlier step i-e ```0xca35b7d915458ef540ade6068dfe2f44e8fa733c```

* _rate: Enter the value ```1```. You can experiment with other values but keep in mind that this is the rate which determine how may tokens will be transfer against 1 ether. So rate of 1 means, 1 MyToken for 1 Ether.

After you enter all the values, press ```transact```
<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/tokens-5.png">

You should see the ```MyExchange``` contract appear in the Remix. Note the address of ```MyExchange``` contract (```0xa5a2075994ca25397b8dab82e4834c1b09051d57```) as you will need it in the next step. You can also press ```MyToken``` and ```MyOwner``` buttons to see respective addresses in the output.
<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/tokens-6.png">

## Delegate Contract to Transfer Tokens
You are now ready to approve ```MyExchange``` to transfer tokens on behalf of an owner ```0xca35b7d915458ef540ade6068dfe2f44e8fa733c``` account. 

Locate ```approve``` method of ```MyToken```, and enter the values for:

* _spender: ```MyExchange``` contract address, e.g ```0xa5a2075994ca25397b8dab82e4834c1b09051d57```

* _value: ```7500```. Total amount of tokens that ```MyExchange``` can transfer from the owner's account to another account. Behind the scene ```MyExchange``` call ```transferFrom``` method inside ```MyToken```.

Finally, press ```transact``` button.
<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/tokens-7.png">

## Transfer Tokens via MyExchange Contract to Externally Owned Account (EOA) 
Let's say an address (EOA) e.g ```0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db``` wanted to buy 5 ```MyToken``` tokens. In the earlier [section](https://github.com/razi-rais/blockchain-workshop/edit/master/tokens/ReadME.md#20) you saw an approch that allows owner to directly transfer tokens to an address. However, lets use another approch. This time ```0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db``` address will send ```5 Ether``` to the ```MyExchange``` contract and in return will get ```5 MyToken``` tokens.

  Note: The reason why 5 ether results in transfering of 5 tokens, is due to the rate we set at the time of creating    ```MyExchange``` contract. 
  
  Following is the step by step process to get the tokens:
  
  * Select the account that like to receive the tokens. In this case its ```0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db```. 
  
  * Enter ```5``` in the value and make sure denomination dropdown is set to ```ether```
  
  <img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/tokens-8.png">

  * 
  
