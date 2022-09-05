const fs = require("fs");
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const Contract = await ethers.getContractFactory("L1Consumption");
  //Passing Starknet core contract address and Stake L2 address
  const contract = await Contract.deploy(
    "0xde29d060D45901Fb19ED6C6e959EB22d8626708e", // starknet core contract address
    "0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99" // L2 contract address
  );
  console.log("EX3 smart contract address:", contract.address);

  const data = {
    address: contract.address,
    abi: JSON.parse(contract.interface.format("json")),
  };

  if (!fs.existsSync("artifacts/ABI")) fs.mkdirSync("artifacts/ABI");
  fs.writeFileSync("artifacts/ABI/L1Consumption.json", JSON.stringify(data), {
    flag: "w",
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
