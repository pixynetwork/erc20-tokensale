pragma solidity 0.5.13;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "../node_modules/openzeppelin-solidity/contracts/access/roles/SignerRole.sol";
import "../node_modules/openzeppelin-solidity/contracts/access/roles/WhitelistedRole.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

contract Crowdsale is WhitelistedRole, SignerRole {
  using SafeMath for uint256;

  mapping(address => uint256) userPurchased;
  uint256 public purchaseLimit;
  IERC20 public token;

  uint256 public rate;

  constructor(uint256 _initialRate, uint256 _initalLimit, IERC20 _tokenAddress) public
  {
    require(_initialRate > 0, "Rate cannot be zero");
    rate = _initialRate;
    purchaseLimit = _initalLimit;
    token = _tokenAddress;
  }

  /**
    * @dev This function allow a whitelisted user to purchase tokens
    */
  function purchaseTokens() public payable onlyWhitelisted() {
    require(msg.value > 0, "Only non-zero contributions are allowed");

    uint256 toSend = msg.value.mul(rate);

    require(
      userPurchased[msg.sender].add(toSend) <= purchaseLimit,
      "Purchase limit exceeded"
    );

    userPurchased[msg.sender] = userPurchased[msg.sender].add(toSend);

    token.transfer(msg.sender, toSend);

    emit Purchase(msg.sender, msg.value, toSend);

  }

  /**
    * @dev This function allow the update of the purchase limit
    * @param _newLimit How many token per ether
    */
  function setPurchaseLimit(uint256 _newLimit) public onlySigner() {
    purchaseLimit = _newLimit;
    emit LimitUpdated(purchaseLimit);
  }

  /**
    * @dev This function allow the update of the rate on the contract
    * @dev The rate must always be an integer greater than 0
    * @param _newRate How many tokens per ether
    */
  function updateRate(uint256 _newRate) public {
    rate = _newRate;
    emit RateUpdated(rate);
  }

  /**
    * @dev This function allow a valid signer to retrieve eth
    * @param _to Address that will receive the ether
    * @param _amount Amount of ether to retrieve
    */
  function withdrawEth(address payable _to, uint256 _amount) public onlySigner() {
    require(_to != address(0), "Receiver cannot be zero address");
    require(_amount <= address(this).balance, "Not enough funds");
    _to.transfer(_amount);
    emit EthWithdrawn(_to, _amount);
  }

  /**
    * @dev This function allow a valid signer to retrieve tokens
    * @param _to Address that will receive the ether
    * @param _amount Amount of ether to retrieve
    * @param _token Token to retrieve (works for external stucked tokens)
    */
  function withdrawToken(address _to, uint256 _amount, IERC20 _token)
    public
    onlySigner()
  {
    require(_to != address(0), "Receiver cannot be zero address");
    require(_amount <= _token.balanceOf(address(this)), "Not enough funds");
    _token.transfer(_to, _amount);
    emit TokenWithdrawn(_to, _amount, _token);
  }

  event Purchase(address _buyer, uint256 _ethAmount, uint256 _tokenAmount);
  event LimitUpdated(uint256 _limit);
  event RateUpdated(uint256 _rate);
  event EthWithdrawn(address indexed _to, uint256 _amount);
  event TokenWithdrawn(address indexed _to, uint256 _amount, IERC20 _token);
}

Actual treat jeans olive adult warfare exclude fiber battle duck network duck
