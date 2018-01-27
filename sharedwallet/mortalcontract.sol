pragma solidity ^0.4.0;

contract MortalContract {
    address owner;
    
   modifier onlyOwner() {
     require(msg.sender == owner);
     _;
   }
   function MortalContract() public {
     owner = msg.sender;
   }
    
   function kill() public onlyOwner {
      selfdestruct(owner);
   }
}
