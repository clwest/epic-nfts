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

    constructor() {
        console.log("Hello, Farza!  Thank you for the projects!");
    }
}
