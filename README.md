# WETH10 Flash Loan

```
Borrow unlimited amount of WETH10 with zero fees! (For an infinitesimal small
amount of time)
```

This project showcases an example of a smart contract capable of using
flashloans, i.e. implementing `ERC3156FlashBorrower`, and corresponding
deployment code in python.

The project is build using [eth-brownnie](https://github.com).

## Usage

After installing brownie as described [here](), `git clone` the repository and
run `$ brownie run scripts/run.py`.

For a more interactive approach start the brownie console and run the script
from there:
```
$ brownie console
$ run("run")
```

## Background

### WETH10

What is WETH10?

### ERC3156
What is ERC3156?

### Brownie networks

In this project we want to fork the Ethereum mainnet at the current state.
Therefore we add following line to the `brownie-config.yml` configuration file:
```
networks:
    default: mainnet-fork
```
For more information see the [brownie docs]().

## Result

Our `FlashBorrower` emits a `Balance(uint256 balance)` event two times.
The first time in the `flashBorrow` function, i.e. before the flash loan, and
the second tim in the `onFlashLoan` function, i.e. while the contract has
access to the loaned amount.

If everything worked, the `scripts/run.py` script prints the two emitted
balances to the console. The output should be:
```
Balance of FlashBorrower before and while flash loan:
0E-18 WETH
5192296858534827.628530496329220095 WETH
```
