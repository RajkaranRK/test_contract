pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;

contract LotteryFactory{
    
    struct Player{
        string name;
        uint bal;
        uint lottery_number;
    }
    uint[] public lotteries;
    mapping (address=>Player)  players;
    address[] player_accounts;
    uint private MAX_LOTTERY_COUNT;
    address private owner;
    
    function LotteryFactory() public{
        owner = msg.sender;
    }
    
    
   //setup the user 
    function enter(string name, uint lottery_id) public payable{
        require(msg.value >= 0.01 ether);
        if(players[msg.sender].bal == 0){
            players[msg.sender].bal += msg.value;
            players[msg.sender].name = name;
            players[msg.sender].lottery_number = lotteries[lottery_id];
            player_accounts.push(msg.sender);
        }else{
            throw;
        }
    }

    function getLotteryNumbers() public view returns(uint[]){
        return lotteries;
    }
    
    
    //see the user result
    function seeProfile() public view returns(string,uint,uint){
        return(
            players[msg.sender].name,
            players[msg.sender].bal,
            players[msg.sender].lottery_number
            );
    }
    
    
    function getPlayers()public view returns(address[] memory,string[] memory){
        string[] memory player_name;
        for(uint i=0;i<player_accounts.length;i++){
            player_name[i] = players[player_accounts[i]].name;
        }
        return (player_accounts,player_name);
    }
    
  
    
    function pickLotteryNumber() private view restricted {
        
    }
    
    
    function sendFunds(address  winner) private view restricted{
    
        winner.transfer(players[winner].bal * 2);
    }
    
    
    function createLotteries(string lottery_count,string lottery_code) public  restricted{
        if(MAX_LOTTERY_COUNT == 0){
            //uint lc = stringToUint(lottery_count);
            generateLotteryNumber(0,10,lottery_code);
        }
        else{
            generateLotteryNumber(MAX_LOTTERY_COUNT,10,lottery_code);
        }
    }

    //  function stringToUint(string s) private returns(uint){
    //     bytes b = bytes(s);
    //     uint result = 0;
    //     for (uint i = 0; i < b.length; i++) { // c = b[i] was not needed
    //         if (b[i] >= 48 && b[i] <= 57) {
    //             result = result * 10 + (uint(b[i]) - 48); // bytes and int are not compatible with the operator -.
    //         }
    //     }
    //     return result;
    // }

   
    
    
    function generateLotteryNumber(uint _from, uint lottery_count,string lottery_code) private restricted{
        for(uint i=_from;i<lottery_count;i++){
            lotteries.push(uint(keccak256(now,lottery_code)));
        }
        MAX_LOTTERY_COUNT = lottery_count;
    }
    
  
    modifier restricted(){
        require(msg.sender == owner);
        _;
    }
}