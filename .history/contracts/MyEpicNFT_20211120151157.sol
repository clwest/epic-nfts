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

    // SVG code that will be stored in the URI
    // create a baseSVG variable that all nfts can use.
    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // List of random words heared during the day of a Child's life
    string[] firstWords = [
        "Maggie",
        "Steve",
        "Blippi",
        "Peppa",
        "Pinkfong",
        "Chase",
        "Rubble",
        "Zuma",
        "Marshal",
        "Sky",
        "Rocky",
        "Cocomelon",
        "Snoopy",
        "Brooks"
    ];
    string[] secondWords = [
        "Hotdog",
        "Pizza",
        "Cheese",
        "Taco",
        "Burrito",
        "Steak",
        "That",
        "Pancake",
        "Cookies",
        "Brownies",
        "Chocolate",
        "Chicken",
        "Broccoli",
        "Shake"
    ];
    string[] thirdWords = [
        "iPad",
        "Slide",
        "Jump",
        "Bounce",
        "Run",
        "Chase",
        "Hide",
        "Poop",
        "Accident",
        "Sorry",
        "Pee",
        "Dance",
        "Pretend",
        "Throw"
    ];

    constructor() ERC721("Munchkin Words", "MUNCH") {
        console.log("Hello, Farza!  Thank you for the projects!");
    }

    // Functions to randomly pick the first word from each of the arrays

    function pickRandomFirstWord() public view returns (string memory) {
        // Seed the random generator
        uint256 rand = random(
            string(abi.encodePakced("FIRST_WORD", Strings.toString(_tokenIds)))
        );
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
