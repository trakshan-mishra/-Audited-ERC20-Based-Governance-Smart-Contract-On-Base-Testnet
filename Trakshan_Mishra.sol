// SPDX-License-Identifier: MIT
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