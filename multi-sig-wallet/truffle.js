module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 9545,  //9545 is truffle develop , 7545 is ganache-cli
      network_id: "*" // Match any network id
    }
  }
};
