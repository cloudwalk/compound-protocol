// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

abstract contract CTokenInterface  {
    function isCToken() public virtual view returns(bool);
    function totalTrustedSupply() public virtual view returns(uint);
    function exchangeRateStored() public virtual view returns (uint);
    function balanceOf(address owner) external virtual view returns (uint);
    function underlying() public virtual view returns (address);

    function accrueInterest() public virtual returns (uint);
    function exchangeRateCurrent() public virtual returns (uint);
    function balanceOfUnderlying(address owner) external virtual returns (uint);
}
