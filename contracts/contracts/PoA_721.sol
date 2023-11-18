//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/access/Ownable2Step.sol";

contract AdventureToken is ERC721URIStorage, Ownable, ERC721Pausable {
    uint256 private _nextTokenId;

    constructor() ERC721("AdventureToken", "PoA") Ownable() {}

    function pause() public onlyOwner whenNotPaused {
        _pause();
    }

    function unPause() public onlyOwner whenPaused {
        _unpause();
    }

    function mint(
        address recipient,
        string memory tokenURI
    ) public whenNotPaused returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(recipient, tokenID);
        _setTokenURI(tokenId, tokenURI);

        return tokenId;
    }

    function withdraw() public onlyOwner  {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) =  _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
    
    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}
