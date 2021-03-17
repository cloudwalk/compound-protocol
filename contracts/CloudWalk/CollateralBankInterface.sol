pragma solidity ^0.5.16;

contract CollateralBankInterface {
    function trustedBorrowers(address account) public view returns (bool exists, uint allowance);
}