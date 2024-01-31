// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Permit.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Votes.sol";

/**
 * @title MockERC721
 * @dev A mock token contract that extends ERC721, Ownable, ERC721Permit, and ERC721Votes.
 * This will be using in testing.
 */
contract MockERC721 is ERC721, Ownable, ERC721Permit, ERC721Votes {
    /**
     * @dev Initializes the MockERC721 contract.
     * @param initialOwner The initial owner of the contract.
     */
    constructor(address initialOwner)
        ERC721("MockERC721", "MTK")
        Ownable(initialOwner)
        ERC721Permit("MockERC721")
    {}

    /**
     * @dev Mints new tokens and assigns them to the specified address.
     * Only the contract owner can call this function.
     * @param to The address to which the tokens will be minted.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Overrides the _update function from ERC721Votes to update the voting power of the specified addresses.
     * @param from The address from which tokens are transferred.
     * @param to The address to which tokens are transferred.
     * @param value The amount of tokens transferred.
     */
    function _update(address from, address to, uint256 value)
        internal
        override(ERC721, ERC721Votes)
    {
        super._update(from, to, value);
    }

    /**
     * @dev Overrides the nonces function from ERC721Permit to get the nonce of the specified owner.
     * @param owner The address of the owner.
     * @return The nonce of the owner.
     */
    function nonces(address owner)
        public
        view
        override(ERC721Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}