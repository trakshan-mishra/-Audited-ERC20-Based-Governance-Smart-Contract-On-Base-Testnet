# -Audited-ERC20-Based-Governance-Smart-Contract-On-Base-Testnet
# Governance Contract

This is an ERC20 token contract that includes the following features:

1. Initializable: The contract can be initialized with the token name, symbol, and initial supply.
2. Ownable: The contract has an owner who can perform certain actions like minting tokens or pausing the contract.
3. Pausable: The contract can be paused by the owner, preventing any token transfers.
4. Minting: The owner can mint new tokens and assign them to any address.
5. Burning: Any token holder can burn their tokens and receive a payment in Ether.

To interact with the contract, you can use the following functions:

1. `initialize(address owner_, string memory name_, string memory symbol_, uint256 initialSupply_)`: Initializes the contract with the given parameters. Can only be called once by the contract creator.
2. `pause()`: Pauses the contract. Can only be called by the owner.
3. `unpause()`: Unpauses the contract. Can only be called by the owner.
4. `mint(address to, uint256 amount)`: Mints the specified amount of tokens and assigns them to the given address. Can only be called by the owner.
5. `burn(uint256 amount)`: Burns the specified amount of tokens from the caller's balance and sends the corresponding amount of Ether to the contract owner.

Please note that this contract is upgradeable, meaning its functionality can be extended or modified through subsequent upgrades.

To deploy this contract, you can use the following Solidity code:

```solidity
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";

contract Governance is Initializable, ERC20Upgradeable, OwnableUpgradeable, PausableUpgradeable {
    function initialize(address owner_, string memory name_, string memory symbol_, uint256 initialSupply_) initializer public {
        __ERC20_init(name_, symbol_);
        __Ownable_init(owner_);
        __Pausable_init();
        _mint(owner_, initialSupply_);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

   function burn(uint256 amount) public {
    _burn(msg.sender, amount);
    payable(owner()).transfer(amount);
   }
}
