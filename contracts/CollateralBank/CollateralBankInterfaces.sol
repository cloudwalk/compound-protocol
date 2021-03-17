// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "./CTokenInterfaces.sol";

contract CollateralBankStorage {
    event NewAdmin(address indexed oldAdmin, address indexed newAdmin);
    event NewMarket(address indexed oldMarket, address indexed newMarket);
    event Mint(address indexed account, uint mintTokens, uint mintAmount, address indexed to);
    event Burn(address indexed account, uint burnTokens, uint burnAmount, address indexed to);
    event UpdateSupplier(address indexed account, bool oldExists, uint oldAllowance, bool newExists, uint newAllowance);
    event UpdateBorrower(address indexed account, bool oldExists, uint oldAllowance, bool newExists, uint newAllowance);

    CTokenInterface public cToken;
    IERC20Upgradeable public aToken;

    address public admin;
    bool public allowUntrustedSuppliers;
    bool public allowUntrustedBorrowers;
    uint public untrustedSupplyAllowance;
    uint public untrustedBorrowAllowance;
    uint public initialExchangeRateMantissa;

    struct TrustedAccount {
        bool exists;
        uint allowance;
    }

    mapping (address => TrustedAccount) public trustedSuppliers;
    mapping (address => TrustedAccount) public trustedBorrowers;
}

abstract contract CollateralBankInterface is CollateralBankStorage {
    function accrueInterest() virtual public;
    function mint(address to, uint mintAmount) virtual external;
    function burn(address to, uint burnTokensIn, uint burnAmountIn) virtual external;
    function exchangeRateCurrent() virtual external returns (uint exchangeRate);
    function exchangeRateStored() virtual external view returns (uint exchangeRate);
}