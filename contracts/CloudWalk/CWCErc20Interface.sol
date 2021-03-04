pragma solidity ^0.5.16;

contract CWCErc20Interface {  

  /*** User Interface ***/
  
  function trustedBorrow(uint borrowAmount) external returns (uint);  
  function trustedRepayBorrow(uint repayAmount) external returns (uint);
}