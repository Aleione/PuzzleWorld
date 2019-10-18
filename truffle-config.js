// Uncommenting the defaults below 
  // provides for an easier quick-start with Ganache.
  // You can also follow this format for other networks;
  // see <http://truffleframework.com/docs/advanced/configuration>
  // for more details on how to specify configuration options!
 // /*
 var HDWalletProvider = require("truffle-hdwallet-provider");
var infura_apikey = "42fbf25f20a74f2892b0afc94f46e8f7";
var mnemonic = "bunker large garbage today opinion enable express edge scare label slot design";




module.exports = { 
  
  mocha: {
    enableTimeouts: false,
  },
  
  plugins: [ "truffle-security" ],
  
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
	  gas:1000000,
	  gasPrice: 20000000000,
    },
	ropsten: {
		host: "127.0.0.1",
		port: 8545,
		network_id: 3,
		gas:1000000,
	},
	ropsten_infura: {
      provider: new HDWalletProvider(mnemonic, "https://ropsten.infura.io/"+infura_apikey),
      network_id: 3,
	  gas:400000,
	  gasPrice: 30000000000,
	   },
    /*ganache: {
      host: "127.0.0.1",
      port: 7545,
      network_id: 619,
	  gas:1000000,
	  gasPrice: 20000000000,
    }*/
  },
  
  compilers: {
    solc: {
      settings: {
        optimizer: {
          enabled: true
        }
      }
    }
  }
  
  //*/
};
