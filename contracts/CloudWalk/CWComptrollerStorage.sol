pragma solidity ^0.5.16;

import "../CToken.sol";
import "../ComptrollerStorage.sol";

contract CWComptrollerV2Storage is ComptrollerV1Storage {
    /// @notice Trusted account borrow allowance
    struct TrustedAccount {
        uint allowance;
        bool exists;
    }

    struct Market {
        /// @notice Whether or not this market is listed
        bool isListed;

        /**
         * @notice Multiplier representing the most one can borrow against their collateral in this market.
         *  For instance, 0.9 to allow borrowing 90% of collateral value.
         *  Must be between 0 and 1, and stored as a mantissa.
         */
        uint collateralFactorMantissa;

        /// @notice Whether or not this market allow untrusted borrowers
        bool allowUntrustedBorrowers;

        /// @notice Whether or not this market allow untrusted suppliers
        bool allowUntrustedSuppliers;

        /// @notice Address of collateral bank for trusted borrows
        address collateralBankAddress;

        /// @notice Per-market mapping of "accounts in this asset"
        mapping(address => bool) accountMembership;

        /// @notice Per-market mapping of "trusted" borrower
        mapping(address => TrustedAccount) trustedBorrowers;

        /// @notice Per-market mapping of "trusted" supplier
        mapping(address => TrustedAccount) trustedSuppliers;
    }

    /**
     * @notice Official mapping of cTokens -> Market metadata
     * @dev Used e.g. to determine if a market is supported
     */
    mapping(address => Market) public markets;

    /**
     * @notice The Pause Guardian can pause certain actions as a safety mechanism.
     *  Actions which allow users to remove their own assets cannot be paused.
     *  Liquidation / seizing / transfer can only be paused globally, not by market.
     */
    address public pauseGuardian;
    bool public _mintGuardianPaused;
    bool public _borrowGuardianPaused;
    bool public transferGuardianPaused;
    bool public seizeGuardianPaused;
    mapping(address => bool) public mintGuardianPaused;
    mapping(address => bool) public borrowGuardianPaused;
}

contract CWComptrollerV3Storage is CWComptrollerV2Storage {
    /// @notice A list of all markets
    CToken[] public allMarkets;
}

contract CWComptrollerV4Storage is CWComptrollerV3Storage {
    // @notice The borrowCapGuardian can set borrowCaps to any number for any market. Lowering the borrow cap could disable borrowing on the given market.
    address public borrowCapGuardian;

    // @notice Borrow caps enforced by borrowAllowed for each cToken address. Defaults to zero which corresponds to unlimited borrowing.
    mapping(address => uint) public borrowCaps;
}