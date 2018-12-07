const Web3 = require('web3');
const HDWalletProvider = require('truffle-hdwallet-provider');
const mocha = require('mocha');
const asserts = require('assert');
const {interface,bytecode} = require('../compile');

var account_addreess;
var lottery;
var lotteriesNumber;
var web3 = new Web3(new Web3(new Web3.providers.HttpProvider("http://localhost:8545")));

beforeEach(async()=>{
    account_addreess = await web3.eth.getAccounts();

    lottery = await new web3.eth.Contract(JSON.parse(interface))
   .deploy({data:bytecode})
   .send({from:account_addreess[0],gas:'1000000'})
});



describe('Lottery Contract ',()=>{
    
    
    it('Should give have account address and deploy contract address',async()=>{
        console.log(lottery.options.address);
        asserts.ok(account_addreess);
    });

    it('Should create lotteries number',async()=>{
       await lottery.methods.createLotteries("10",'hello').send({
            from:account_addreess[0],
            gas:'1000000'
        });
    });


    it('Should get lotteries number',async()=>{
        // lotteriesNumber = await lottery.methods.getLotteryNumbers().send({from:account_addreess[0],gas:'1000000'});
        // asserts.ok(lotteriesNumber);
        // console.log(lotteriesNumber);
        lotteriesNumber =  await lottery.methods.lotteries(2).call();
        console.log(lotteriesNumber);
    });

    // it('Should allow enter 3 peolpe to enter into the Lottery Contract',async()=>{

    //     await lottery.methods.enter("Raj1",0).send({
    //         from:account_addreess[0],
    //         value:web3.utils.toWei('0.1','ether')
    //     });

    //     await lottery.methods.enter("Raj2",1).send({
    //         from:account_addreess[1],
    //         value:web3.utils.toWei('0.1','ether')
    //     });

    //     await lottery.methods.enter("Raj3",2).send({
    //         from:account_addreess[2],
    //         value:web3.utils.toWei('0.1','ether')
    //     });
    // });
    
});




