// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

import { StableToken } from "./StableToken.sol";

contract cUSD is MentoERC20 {
  constructor() StableToken("Celo Dollar", "cUSD", 18) {
    // solhint-disable-previous-line no-empty-blocks
  }
}
