import 'https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/token/ERC20/ERC20.sol';

contract RoyalityToken is StandardToken {
    string public constant name = 'RoyalityToken';
    string public constant symbol = 'RYT';
    uint8 public constant decimals = 2;
    uint constant _initial_supply = 2000000000;

    function RoyalityToken() public {
        totalSupply_ = _initial_supply;
        balances[msg.sender] = _initial_supply;
        Transfer(address(0), msg.sender, _initial_supply);
    }
}


contract Miles{

    mapping (address => uint) totalMiles;
    address public owner = msg.sender;
    address contractAddr;
    
    function Miles(){
        owner = msg.sender;  
    }
    
    function  SetMiles(address _address, uint miles)   
    {
        require( owner == msg.sender );
        totalMiles[_address] = miles;
    }
    
    function GetMiles(address _address) view returns (uint) {
        return totalMiles[_address];
    }
    
     function  SetAgent(address _address)   
    {
        require( owner == msg.sender );
        contractAddr = _address;
    }
    
     function  DeductMiles(address _address, uint miles)   
    {
        require( contractAddr == msg.sender );
        totalMiles[_address] = totalMiles[_address] - miles;
    }
    
    
}

contract RoyalityPointsExchange {

	StandardToken public RoyalityToken;
	address public TokenOwner;
	uint rate;
	Miles public miles;
	event WithdrawSuccessful(address from, address destination, uint amount);
    event WithdrawFailed(address from, address destination, uint amount);
    event TotalMiles(address source, uint amount);
    
	// RoyalityPointsExchange constructor, provide the address of RoyalityToken contract and
	// the owner address we will be approved to transferFrom
	function RoyalityPointsExchange(address _RoyalityToken, address _owner, uint _rate, address _miles) public {

		// Initialize the RoyalityToken from the address provided
		RoyalityToken = StandardToken(_RoyalityToken);
		TokenOwner = _owner;
		rate = _rate;
		miles = Miles(_miles);
	}

	function withdraw() public payable {

        //Our exchange rate is: avilable miles multiply by the rate (set inside the constructor).
         uint milesCount = miles.GetMiles(msg.sender);
         emit TotalMiles(msg.sender,milesCount);
         uint withdraw_amount = milesCount * rate; 
        
		//Use the transferFrom function of RoyalityToken
		bool success = RoyalityToken.transferFrom(TokenOwner, msg.sender, withdraw_amount);
    //Note: Make sure you deduct the miles in case of successful transfer, otherwise miles may be reused again. This is not included as part of this contract.
		if (success) 
		{ 
		    miles.DeductMiles(msg.sender, milesCount);
		    emit WithdrawSuccessful(TokenOwner,msg.sender, withdraw_amount);
		    
		}
		else 
		{ 
		    emit WithdrawFailed(TokenOwner,msg.sender, withdraw_amount);
		}
		
		
    }

}
