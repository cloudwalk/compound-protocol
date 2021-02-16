pragma solidity ^0.5.16;

import "../CToken.sol";
import "../ComptrollerStorage.sol";

contract ComptrollerV3StorageUpd is ComptrollerV2Storage {    
    /// @notice A list of all markets
    CToken[] public allMarkets;    
}

contract ComptrollerV4StorageUpd is ComptrollerV3StorageUpd {
    // @notice The borrowCapGuardian can set borrowCaps to any number for any market. Lowering the borrow cap could disable borrowing on the given market.
    address public borrowCapGuardian;

    // @notice Borrow caps enforced by borrowAllowed for each cToken address. Defaults to zero which corresponds to unlimited borrowing.
    mapping(address => uint) public borrowCaps;
}

contract CWComptrollerV1Storage is ComptrollerV4StorageUpd {

}
