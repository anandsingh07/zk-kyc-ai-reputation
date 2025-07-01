require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/NPDIFQZwAYGEs62pu65Wq",
      accounts: ["bac02fb51a3c68c80092dbae2d25463e3471368877e9ebc68e2de838f165e88c"],
    },
  },
};
