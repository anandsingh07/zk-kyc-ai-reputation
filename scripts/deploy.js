const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("\n🚀 Deploying contracts with account:", deployer.address);

  // ✅ Deploy AgeCheck Verifier
  const AgeCheckVerifier = await ethers.getContractFactory("AgeCheckVerifier");
  const ageVerifier = await AgeCheckVerifier.deploy();
  await ageVerifier.waitForDeployment();
  console.log("✅ AgeCheckVerifier deployed at:", await ageVerifier.getAddress());

  // ✅ Deploy CountryCheck Verifier
  const CountryCheckVerifier = await ethers.getContractFactory("CountryCheckVerifier");
  const countryVerifier = await CountryCheckVerifier.deploy();
  await countryVerifier.waitForDeployment();
  console.log("✅ CountryCheckVerifier deployed at:", await countryVerifier.getAddress());

  // ✅ Deploy RangeProof Verifier
  const RangeProofVerifier = await ethers.getContractFactory("RangeProofVerifier");
  const rangeVerifier = await RangeProofVerifier.deploy();
  await rangeVerifier.waitForDeployment();
  console.log("✅ RangeProofVerifier deployed at:", await rangeVerifier.getAddress());

  // ✅ Deploy KYCManager Contract (pass verifier addresses)
  const KYCManager = await ethers.getContractFactory("KYCManager");
  const kycManager = await KYCManager.deploy(
    await ageVerifier.getAddress(),
    await countryVerifier.getAddress(),
    await rangeVerifier.getAddress()
  );
  await kycManager.waitForDeployment();
  console.log("✅ KYCManager deployed at:", await kycManager.getAddress());

  console.log("\n✅ ✅ ✅ All Contracts Deployed Successfully!\n");
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});
