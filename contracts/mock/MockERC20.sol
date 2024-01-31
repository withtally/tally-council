// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

/**
 * @title MockERC20
 * @dev A mock token contract that extends ERC20, Ownable, ERC20Permit, and ERC20Votes.
 * This will be using in testing.
 */
contract MockERC20 is ERC20, Ownable, ERC20Permit, ERC20Votes {
    /**
     * @dev Initializes the MockERC20 contract.
     * @param initialOwner The initial owner of the contract.
     */
    constructor(address initialOwner)
        ERC20("MockERC20", "MTK")
        Ownable(initialOwner)
        ERC20Permit("MockERC20")
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
     * @dev Overrides the _update function from ERC20Votes to update the voting power of the specified addresses.
     * @param from The address from which tokens are transferred.
     * @param to The address to which tokens are transferred.
     * @param value The amount of tokens transferred.
     */
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Votes)
    {
        super._update(from, to, value);
    }

    /**
     * @dev Overrides the nonces function from ERC20Permit to get the nonce of the specified owner.
     * @param owner The address of the owner.
     * @return The nonce of the owner.
     */
    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}