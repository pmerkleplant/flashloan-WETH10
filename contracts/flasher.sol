// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <=0.8.0;

import "../interfaces/IERC20.sol";
import "../interfaces/IERC3156FlashBorrower.sol";
import "../interfaces/IERC3156FlashLender.sol";

/**
 * FlashBorrower implements the ERC3156FlashBorrower interface.
 *
 * To initiate a flash loan the user has to call the `flashBorrow` function.
 * The lender, e.g. the protocol providing the flash loan, uses the
 * `onFlashLoan` function as a callback.
 *
 * Inside of the `onFlashLoan` function the contract has access to the loan.
 *
 * After execution of the `onFlashLoan` the contract must possess at least the
 * loaned amount for the flash loan to succeed.
 *
 * This contract is copied from EIP3156 example implementation.
 */
contract FlashBorrower is IERC3156FlashBorrower {
    IERC3156FlashLender lender;

    event Balance(uint256 balance);

    constructor (
        IERC3156FlashLender lender_
    ) {
        lender = lender_;
    }

    /// @dev ERC-3156 Flash loan callback
    function onFlashLoan(
        address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data
    ) external override returns(bytes32) {
        require(
            msg.sender == address(lender),
            "FlashBorrower: Untrusted lender"
        );
        require(
            initiator == address(this),
            "FlashBorrower: Untrusted loan initiator"
        );

        // Emit balance
        emit Balance(IERC20(token).balanceOf(address(this)));

        return keccak256("ERC3156FlashBorrower.onFlashLoan");
    }

    /// @dev Initiate a flash loan
    function flashBorrow(
        address token,
        uint256 amount
    ) public {
        IERC20(token).approve(address(lender), amount);

        // Emit balance
        emit Balance(IERC20(token).balanceOf(address(this)));

        lender.flashLoan(this, token, amount, bytes("FlashLoan!"));
    }
}
