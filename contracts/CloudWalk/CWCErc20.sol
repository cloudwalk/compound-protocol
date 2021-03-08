pragma solidity ^0.5.16;

import "../CErc20.sol";
import "./CWCErc20Interface.sol";

/**
 * @title CloudWalk's CErc20 Contract
 * @notice CTokens which wrap an EIP-20 underlying
 * @author CloudWalk
 */
contract CWCErc20 is CErc20, CWCErc20Interface {
    /**
     * @notice Initialize the new money market
     * @param underlying_ The address of the underlying asset
     * @param comptroller_ The address of the Comptroller
     * @param interestRateModel_ The address of the interest rate model
     * @param initialExchangeRateMantissa_ The initial exchange rate, scaled by 1e18
     * @param name_ ERC-20 name of this token
     * @param symbol_ ERC-20 symbol of this token
     * @param decimals_ ERC-20 decimal precision of this token
     */
    function initialize(address underlying_,
                        ComptrollerInterface comptroller_,
                        InterestRateModel interestRateModel_,
                        uint initialExchangeRateMantissa_,
                        string memory name_,
                        string memory symbol_,
                        uint8 decimals_) public {
        super.initialize(
            underlying_,
            comptroller_,
            interestRateModel_,
            initialExchangeRateMantissa_,
            name_,
            symbol_,
            decimals_);
    }

    /*** User Interface ***/

    /**
      * @notice Trusted sender borrows assets from the protocol to their own address
      * @param borrowAmount The amount of the underlying asset to borrow
      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
      */
    function trustedBorrow(uint borrowAmount) external returns (uint) {
        (uint err,) = trustedBorrowInternal(borrowAmount);
        return err;        
    }

    /**
     * @notice Trusted sender repays their own borrow
     * @param repayAmount The amount to repay
     * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
     */
    function trustedRepayBorrow(uint repayAmount) external returns (uint) {
        (uint err,) = trustedRepayBorrowInternal(repayAmount);
        return err;
    }    
}
