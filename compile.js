const path = require('path');
const fs = require('fs');
const solc = require('solc');
//here path module provide the system 
//compatibility for accessing the file either
// in Windox,linux,unix
const lotteryPath  = path.resolve(__dirname,'contracts','Lottery.sol');
const source = fs.readFileSync(lotteryPath,'utf8');


const input = {
    sources: {
      'Lottery.sol': source
    }
  };
  module.exports = solc.compile(input, 1).contracts['Lottery.sol:LotteryFactory'];
// console.log(solc.compile(source,1).contracts[':Lottery']);