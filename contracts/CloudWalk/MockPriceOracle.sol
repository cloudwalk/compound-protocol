pragma solidity ^0.5.16;

contract MockPriceOracle {                
    function getUnderlyingPrice(address cToken) public view returns (uint) {        
        return 1e18;        
    }
}