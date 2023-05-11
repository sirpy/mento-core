// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

import { IStableToken } from "./ISTableToken.sol";
import { ERC20 } from "solmate/src/tokens/ERC20.sol";
import { IRegistry } from "../interfaces/IRegistry.sol";

contract MentoERC20 is ERC20, IStableToken {
  address broker;
  address validators;

  constructor(
    address _broker,
    address _validators,
    string memory _name,
    string memory _symbol,
    uint8 _decimals
  ) ERC20(_name, _symbol, _decimals) {
    broker = _broker;
    validators = _validators;
  }

  IRegistry public registry;
  

  function mint(address to, uint256 value) external returns (bool) {
    require(msg.sender == broker || msg.sender == validators,
      "Sender not authorized to mint"
    );
    return _mint(to, value);
  }
}
