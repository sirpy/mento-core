// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;


import { Test } from "forge-std-v08/Test.sol";
import { console } from "forge-std-v08/console.sol";

import { IRegistry } from "contracts/v0.8/interfaces/IRegistry.sol";
import { IStableToken } from "contracts/v0.8/interfaces/IStableToken.sol";
import { ILegacyProxy } from "contracts/v0.8/interfaces/ILegacyProxy.sol";
import { cUSD } from "contracts/v0.8/tokens/cUSD.sol";

contract TokenUpgradeTest is Test {
  address public constant REGISTRY_ADDRESS = 0x000000000000000000000000000000000000ce10;
  IRegistry public registry = IRegistry(REGISTRY_ADDRESS);

  function test_upgrade() public {
    uint256 forkId = vm.createFork("celo_mainnet");
    vm.selectFork(forkId);

    address stableToken = registry.getAddressForString("StableToken");
    ILegacyProxy stableTokenProxy = ILegacyProxy(stableToken);
    console.log(ILegacyProxy(stableToken)._getImplementation());
    console.log(ILegacyProxy(stableToken)._getOwner());
    vm.startPrank(ILegacyProxy(stableToken)._getOwner());
    address cUSDImpl = address(new cUSD());
    stableTokenProxy._setImplementation(cUSDImpl);
    cUSD(stableToken).initializeV2();

    cUSD cusd = cUSD(stableToken);

    address governance = registry.getAddressForString("Governance");
    cusd.balanceOf(governance);

    changePrank(governance);
    cusd.transfer(address(this), 1 ether);

    cusd.balanceOf(address(this));
  }
}
