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
        _setTokenURI(
            newItemId,
            "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj4KICAgIDxzdHlsZT4uYmFzZSB7IGZpbGw6IHdoaXRlOyBmb250LWZhbWlseTogc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgfTwvc3R5bGU"
        );
        console.log(
            "A NFT with the ID %s has been minter",
            newItemId,
            msg.sender
        );

        // Increment the current tokenId when the next NFT is minted
        _tokenIds.increment();
    }
}
