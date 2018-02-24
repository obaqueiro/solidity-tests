pragma solidity ^0.4.0;

contract Owned {
  address owner;

  modifier only_owner() {
    if (msg.sender == owner) {
      _;
    }
  }

  function Owned() public {
    owner = msg.sender;
  }
}
