pragma solidity 0.5.13;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";

contract PXY is ERC20, ERC20Detailed {
  constructor() public ERC20Detailed("Pixy Token", "PXY", 18) {
    _mint(msg.sender, 107000000 * 1e18);
  }
}
