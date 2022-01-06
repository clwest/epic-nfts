// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Importing helper functions from Base64
import {Base64} from "./libraries/Base64.sol";

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

    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // Seed the random generator
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // Seed the random generator
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // Seed the random generator
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    // create the random fuction to clear out errors
    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // A function to let the users get their NFTs
    function makeAnEpicNFT() public {
        // get the Current tokenId, starts from 0
        uint256 newItemId = _tokenIds.current();

        // Call functions to get random words from each arrays
        string memory first = pickRandomFirstWord(newItemId); // First word
        string memory second = pickRandomSecondWord(newItemId); // Second word
        string memory third = pickRandomThirdWord(newItemId); // Third word

        // Concatenate the words together and then close the <text> tag and <svg> tags

        string memory finalSvg = string(
            abi.encodePacked(baseSvg, first, second, third, "</text></svg>")
        );

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        console.log("\n===========================");
        console.log(finalTokenUri);
        console.log("==========Your NFT is ready=================");

        // Actually mint the token to the sender with msg.sender
        _safeMint(msg.sender, newItemId);

        // Set the NFT URI
        _setTokenURI(newItemId, "incoming");

        // Increment the current tokenId when the next NFT is minted
        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted", newItemId, msg.sender);
    }
}
