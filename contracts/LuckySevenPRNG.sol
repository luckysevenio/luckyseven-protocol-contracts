//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

/**
 * @title LuckySeven
 * @dev LuckySeven is a contract to generate random number with low cost
 */
contract LuckySevenPRNG {
    /**
     * @dev Generates a pseudo random number on chain with super low gas cost (850 gas)
     * @param b 1. numerator of the PRNG
     * @param n 2. power of the 10 on the divisor of the PRNG
     * @param mu 3. value for the oscillator to introduce entropy
     * @param p 4. expands the number as 10^p
     * @param i 5. chooses the starting position to start cutting the number
     * @param j 6. to choose the length of the random number (digits from i position to left)
     */

    function prng(
        uint256 b,
        uint256 n,
        uint256 mu,
        uint256 p,
        uint256 i,
        uint256 j
    ) public pure returns (uint256 O) {
        assembly {
            let L := exp(10, p) // 10^p
            let U := mul(L, b) // 10^p * b
            let C := exp(10, n) // 10^n
            let K := sub(C, mu) // 10^n - mu
            let Y := div(U, K) // (10^p * b)/(10^n - mu)
            let S := exp(10, add(i, j)) // 10^(i+j)
            let E := exp(10, i) // 10^i
            let V := mod(Y, S) // Y % 10^(i+j)
            let N := mod(Y, E) // Y % 10^i
            let I := sub(V, N) // (Y % 10^(i+j)) / (Y % 10^i)
            O := div(I, E)
        }
    }
}
