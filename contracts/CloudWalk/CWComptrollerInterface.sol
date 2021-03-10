pragma solidity ^0.5.16;

contract CWComptrollerInterface {

    bool public constant isCWComptroller = true;

    function collateralBankAddress(address cToken) public view returns (address payable);

    function isTrustedBorrowMint(address cToken, address minter, uint mintAmount) external view returns (bool);

    function isTrustedBorrowRedeem(address cToken, address payable redeemer, uint redeemAmount) external view returns (bool);

    function calculateTrustedMintAmount(address cToken, address borrower, uint borrowAmount) external view returns (uint, uint, uint);

    function calculateTrustedRedeemAmount(address cToken, address repayer, uint repayAmount) external view returns (uint, uint, uint);
}