// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Inherit the contract from OpenZeppelin's ERC721URIStorage
contract MyEpicNFT is ERC721URIStorage {
    // Define the counters
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("DonkeyNFT", "DONKEY") {
        console.log("Hello, Farza!  Thank you for the projects!");
    }

    // A function to let the users get their NFTs
    function makeAnEpicNFT() public {
        // get the Current tokenId, starts from 0
        uint256 newItemId = _tokenIds.current();

        // Actually mint the token to the sender with msg.sender
        _safeMint(msg.sender, newItemId);

        // Set the NFT URI
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/9O9C");
        console.log(
            "A NFT with the ID %s has been minter",
            newItemId,
            msg.sender
        );

        // Increment the current tokenId when the next NFT is minted
        _tokenIds.increment();
    }
}
