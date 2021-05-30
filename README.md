<h1 align=center><code>WETH10 Flash Loan Example</code></h1>

```
Borrow unlimited amount of WETH10 with zero fees!
```

This project showcases an example of a smart contract capable of using
flashloans, i.e. implementing `ERC3156FlashBorrower`, and corresponding
deployment code in python.

The project is build using [eth-brownie](https://eth-brownie.readthedocs.io/en/stable/index.html).


## Usage

After installing brownie as described [here](https://eth-brownie.readthedocs.io/en/stable/install.html), `git clone` the repository and
run `$ brownie run scripts/run.py`.

For a more interactive approach start the brownie console and run the script
from there:
```
$ brownie console
$ run("run")
```

### Note about Brownie networks and Infura

In this project we want to fork the Ethereum mainnet at the current state.
Therefore we add following line to the `brownie-config.yml` configuration file:
```
networks:
    default: mainnet-fork
```
For more information see the corresponding [brownie docs](https://eth-brownie.readthedocs.io/en/stable/network-management.html#setting-the-default-network).

If you do not have an Ethereum node at hand it's propably best to use Infura
and specify a `Project ID`. Brownie reads the `Project ID` from the environment
variable `$WEB3_INFURA_PROJECT_ID`. For more information see corresponding
[brownie docs](https://eth-brownie.readthedocs.io/en/stable/network-management.html#using-infura).


## Background

### WETH10

WETH10 is the updated version of the famous WETH9 contract (mostly known as
just WETH). The update includes gas optimizations and flash loan capabilities
by implementing ERC3156.

### ERC3156

This ERC provides standard interfaces and processes for single-asset flash loans.
For more information see [EIP3156](https://eips.ethereum.org/EIPS/eip-3156).


## Result

Our `FlashBorrower` emits a `Balance(uint256 balance)` event two times.
The first time in the `flashBorrow` function, i.e. before the flash loan, and
the second time in the `onFlashLoan` function, i.e. while the contract has
access to the loaned amount.

If everything works fine, the `scripts/run.py` script prints the two emitted
balances to the console. The output should be:
```
Balance of FlashBorrower before and while flash loan:
0E-18 WETH
5192296858534827.628530496329220095 WETH
```
