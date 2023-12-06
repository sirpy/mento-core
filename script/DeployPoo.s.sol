pragma solidity 0.8.18;

import { console } from "forge-std-next/console.sol";
import { Script } from "forge-std-next/Script.sol";

import { AirgrabMock } from "../contracts/governance/mocks/AirgrabMock.sol";

contract DeployPoo is Script {
  function run() public {
    uint256 pkey = vm.envUint("PRIVATE_KEY");

    console.log(pkey);
    vm.startBroadcast(pkey);
    {
      AirgrabMock airgrabMock = new AirgrabMock();
      console.log("Successfull deployment \r\n");
      console.log("Deployed at: %s", address(airgrabMock));
    }
  }
}
