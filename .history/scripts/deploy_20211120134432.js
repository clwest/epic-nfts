const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log(`Deployed NFT contract at ${nftContract.address}`);

  // Call the mint function
  let txn = await nftContract.makeAnEpicNFT();
  // Wait for it to be minted
  await txn.wait();
  console.log(`Minted NFT at ${nftContract.address}`);

  // Mint a second one
  txn = await nftContract.makeAnEpicNFT();

  await txn.wait();
  console.log(`Minted NFT 2 at ${nftContract.address}`);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (e) {
    console.error(e);
    process.exit(1);
  }
};

runMain();
