// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts-upgradeable/math/SafeMathUpgradeable.sol";

/**
 * @title Exponential module for storing fixed-precision decimals
 */
contract Exponential {
    uint constant expScale = 1e18;
    uint constant mantissaOne = expScale;

    using SafeMathUpgradeable for uint256;

    struct Exp {
        uint mantissa;
    }

    /**
     * @dev Creates an exponential from numerator and denominator values.
     */
    function getExp(uint num, uint denom) pure internal returns (Exp memory) {
        uint scaledNumerator = num.mul(expScale);
        uint rational = scaledNumerator.div(denom);
        return Exp({mantissa: rational});
    }

    /**
     * @dev Multiply an Exp by a scalar, then truncate to return an unsigned integer.
     */
    function mulScalarTruncate(Exp memory a, uint scalar) pure internal returns (uint) {
        Exp memory product = mul_(a, scalar);
        return truncate(product);
    }

    /**
     * @dev Divide a scalar by an Exp, returning a new Exp.
     */
    function divScalarByExp(uint scalar, Exp memory divisor) pure internal returns (Exp memory) {
        /*
          We are doing this as:
          getExp(scalar.mul(expScale), divisor.mantissa)

          How it works:
          Exp = a / b;
          Scalar = s;
          `s / (a / b)` = `b * s / a` and since for an Exp `a = mantissa, b = expScale`
        */
        uint numerator = expScale.mul(scalar);
        return getExp(numerator, divisor.mantissa);
    }

    /**
     * @dev Divide a scalar by an Exp, then truncate to return an unsigned integer.
     */
    function divScalarByExpTruncate(uint scalar, Exp memory divisor) pure internal returns (uint) {
        Exp memory fraction = divScalarByExp(scalar, divisor);
        return truncate(fraction);
    }


    /**
     * @dev Truncates the given exp to a whole number value.
     *      For example, truncate(Exp{mantissa: 15 * expScale}) = 15
     */
    function truncate(Exp memory exp) pure internal returns (uint) {
        // Note: We are not using careful math here as we're performing a division that cannot fail
        return exp.mantissa / expScale;
    }

    /**
     * @dev Checks if left Exp <= right Exp.
     */
    function lessThanOrEqualExp(Exp memory left, Exp memory right) pure internal returns (bool) {
        return left.mantissa <= right.mantissa;
    }

    /**
     * @dev Checks if left Exp > right Exp.
     */
    function greaterThanExp(Exp memory left, Exp memory right) pure internal returns (bool) {
        return left.mantissa > right.mantissa;
    }

    /**
     * @dev Checks if first Exp is less than second Exp.
     */
    function lessThanExp(Exp memory left, Exp memory right) pure internal returns (bool) {
        return left.mantissa < right.mantissa;
    }

    /**
     * @dev returns true if Exp is exactly zero
     */
    function isZeroExp(Exp memory value) pure internal returns (bool) {
        return value.mantissa == 0;
    }

    function add_(Exp memory a, Exp memory b) pure internal returns (Exp memory) {
        return Exp({mantissa: a.mantissa.add(b.mantissa)});
    }

    function sub_(Exp memory a, Exp memory b) pure internal returns (Exp memory) {
        return Exp({mantissa: a.mantissa.sub(b.mantissa)});
    }

    function mul_(Exp memory a, Exp memory b) pure internal returns (Exp memory) {
        return Exp({mantissa: a.mantissa.mul(b.mantissa) / expScale});
    }

    function mul_(Exp memory a, uint b) pure internal returns (Exp memory) {
        return Exp({mantissa: a.mantissa.mul(b)});
    }

    function mul_(uint a, Exp memory b) pure internal returns (uint) {
        return a.mul(b.mantissa) / expScale;
    }

    function div_(Exp memory a, Exp memory b) pure internal returns (Exp memory) {
        return Exp({mantissa: a.mantissa.mul(expScale).div(b.mantissa)});
    }

    function div_(Exp memory a, uint b) pure internal returns (Exp memory) {
        return Exp({mantissa: a.mantissa.div(b)});
    }

    function div_(uint a, Exp memory b) pure internal returns (uint) {
        return a.mul(expScale).div(b.mantissa);
    }
}