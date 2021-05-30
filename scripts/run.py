from brownie import *


def main():
    """
    Deploy a FlashBorrower contract and initiate a flash loan against the
    WETH10 contract.
    """
    weth = interface.IWETH10("0xf4BB2e28688e89fCcE3c0580D37d36A7672E8A9F")

    # Some user with WETH10
    user = accounts.at("0x179abb9ecAe3352fC83678511Da5810902e338E5", force=True)
    accounts[0].transfer(user, "100 ether")

    # Deploy flash contract
    FlashBorrower.deploy(weth.address, {'from': user})
    flasher = FlashBorrower[0]

    flash_loan(weth, flasher, user)


def flash_loan(weth, flasher, user):
    max_loan = weth.maxFlashLoan(weth.address)

    fee = weth.flashFee(weth.address, max_loan)
    assert fee == 0  # WETH10 flash loan has zero fees

    # Initiate flash loan
    flasher.flashBorrow(weth.address, max_loan, {'from': user})

    # Check the `Balance` events in the last tx
    print("Balance of FlashBorrower before and while flash loan:")
    for event in history[-1].events["Balance"]:
        # Print balance in ether format
        balance = event["balance"].to("ether")
        print("{} WETH".format(balance))

