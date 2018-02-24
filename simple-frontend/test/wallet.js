import pry from 'pryjs';

var wallet = artifacts.require("./MyWallet.sol");



contract("MyWallet", function(accounts) {
  // it('should be possible to put money inside', function () {
  //   var contractInstance;
  //   wallet.deployed().then(function(instance) {
  //     contractInstance = instance;
  //     return contractInstance.sendTransaction(
  //        {
  //          value: web3.toWei(10),
  //          address: contractInstance.address,
  //          from: accounts[0]
  //        }).then(function(tx) {
  //       //   assert.equal(web3.eth.getBalance(contractInstance.address).toNumber(), web3.toWei(10,'ether'),"The balance is not the same" );
  //        });
  //   })
  // });

  it('should send money when a proposal is confirmed', function () {
    var contractInstance;
     wallet.deployed().then(function(instance) {
      contractInstance = instance;
      var event = contractInstance.proposalReceived({},{fromBlock:0, toBlock:'latest'});
      event.watch(function(error, result) {
        if (!error) {
          console.log(result);
        }
        eval(pry.it);
      });

      return  contractInstance.spendMoneyOn.sendTransaction(accounts[1],web3.toWei(5),"buy something good",
      {
        to: contractInstance.address,
        from: accounts[1]
      }).then(function(tx) {
        // contract balance must be 0
        assert.equal(web3.eth.getBalance(contractInstance.address).toNumber(),0);
        console.log(tx);
      });
     console.log('at the end of the function');
    });
    });

});
