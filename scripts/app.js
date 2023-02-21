require('dotenv').config() ;

const Web3 = require('web3');

const infuraKey = process.env.INFURA_KEY;

const web3 = new Web3(new Web3.providers.HttpProvider( `https://goerlie.infura.io/v3/${infuraKey}`));

const helloWorld = new web3.eth.Contract([
  {
    "constant": true,
    "inputs": [],
    "name": "output",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "payable": false,
    "stateMutability": "pure",
    "type": "function"
  }
], '0x23c091E6Ba8D505c0907c443F37E6d2c44f4584A');

helloWorld.methods.output().call({from: '0xEA908E359FfF0C19AC07D1FA8349E5DC544FF1E3'}, function(error, result) {
    console.log(result);
});