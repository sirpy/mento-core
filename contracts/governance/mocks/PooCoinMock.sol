// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.18;

import { ERC20 } from "openzeppelin-contracts-next/contracts/token/ERC20/ERC20.sol";

contract PooCoinMock is ERC20 {
  address public owner;

  constructor(address _owner) ERC20("Poo Coin", "Poo") {
    owner = _owner;
  }

  /**
   * @dev Allows the Owner to mint.
   */
  function mint(address target, uint256 amount) external {
    require(msg.sender == owner, "Poo Coin: only owner can mint");

    _mint(target, amount);
  }
}
