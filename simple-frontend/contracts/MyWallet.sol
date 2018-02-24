pragma solidity ^0.4.0;

import "./Mortal.sol";

contract MyWallet is Mortal {
  event receivedFunds(address indexed _from, uint256 _amount);
  event proposalReceived(address indexed _from, address indexed _to, string _reason, uint _counter);
  struct Proposal {
    address _from;
    address _to;
    uint256 _value;
    string _reason;
    bool sent;
  }

  uint proposal_counter;
  mapping (uint => Proposal) m_proposals;

  function spendMoneyOn(address _to, uint256 _value, string _reason) public returns (uint256) {
     if(owner == msg.sender) {
       _to.transfer(_value);
       return 0;
     } else {
       proposal_counter++;
       m_proposals[proposal_counter] = Proposal(msg.sender, _to, _value, _reason, false);
       proposalReceived(msg.sender, _to, _reason, proposal_counter);
       return proposal_counter;
     }
  }

 function confirmProposal(uint proposal_id) only_owner public returns (bool) {
    Proposal storage proposal = m_proposals[proposal_id];
   if (proposal._from != address(0) && proposal.sent == false) {
      proposal.sent = true;
      return proposal._to.send(proposal._value);
   }
   return false;
 }
  function() payable public {
    if (msg.value > 0) {
      receivedFunds(msg.sender, msg.value);
    }
  }


}
