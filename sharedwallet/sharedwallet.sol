pragma solidity ^0.4.0;
import "browser/mortalcontract.sol";

contract SharedWallet is MortalContract {

  mapping(address => Permission) addressMaping;
  event addressAddedToSendersList(address whoAdded, address whoIsAllowed, uint allowedAmount);
  
  struct Permission {
      bool isAllowed;
      uint maxTransferAmount;
  }
  
  function addAddressToSendersList(address permitted, uint maxTransferAmount) public onlyOwner {
      addressMaping[permitted] = Permission(true, maxTransferAmount);
      addressAddedToSendersList(msg.sender, permitted, maxTransferAmount);
  }
  
  function sendFunds(address reciever, uint amountInWei) public {
      if (addressMaping[msg.sender].isAllowed &&
          addressMaping[msg.sender].maxTransferAmount >= amountInWei) {
          reciever.transfer(amountInWei);
      } 
      else {
          revert();
      }
  }
  
  function getCurrentAmount() public view onlyOwner returns (uint) {
    return this.balance;    
  }
  
  function() public payable { 
  }

}
