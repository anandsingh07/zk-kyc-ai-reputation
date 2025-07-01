require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/NPDIFQZwAYGEs62pu65Wq",
      accounts: [""],
    },
  },
};
