# Tokens
Hands-on lab on creating, deploying and working with Ethereum EIP20 (a.k.a ERC20) Token.

## Deploy MYToken
To begin with, you will deploy all the required contracts including ```MYToken``` ERC20 contract and ```MyExchange``` contract. You will be using Remix for all the tasks in the exercise, but you can also use truffle or any other tool that works with Ethereum.

* Open the [Remix IDE](https://remix.ethereum.org) and create a new file and name it ```AllinOne.sol```. 

* Copy the content of [AllinOne.sol](https://github.com/razi-rais/blockchain-workshop/blob/master/tokens/AllInOne.sol) file and paste it into contract file you have created in the previous step. 

* Select ```MYToken``` from the dropdown that list all the contracts available for deployment, then press ```Deploy```  

<img src="https://github.com/razi-rais/blockchain-workshop/blob/master/images/tokens-1.png">

  
    Note: ```AllinOne.sol``` file contains all the required contracts that MyToken depends upon. The ```MyToken``` contract leverage [OpenZepppelin](https://github.com/OpenZeppelin/openzeppelin-solidity/tree/v1.2.0/contracts/token) token contracts heavily, which are all flatten into a single file for convinence. Also, Remix ```import``` feature is not consistent while working with contracts located on git.
  
  






