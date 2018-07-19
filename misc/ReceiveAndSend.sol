contract ReceiveAndSend {

	 
	function fallabck() payable {
    }
    
    function getBalance() view returns (uint){
       return address(this).balance;
    }
    
    function transfer(){
        msg.sender.send(this.balance);
    } 

}
