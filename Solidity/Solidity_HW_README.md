# "Solidity Contract HW!"

All the contracts descrived below are deployed in the the Kovan test network.

## Contracts

### AssociateProfitSplitter.sol

	* Contract Description: This contract will accept Ether into the contract and divide the Ether evenly among the associate level employees. This will allow the Human Resources department to pay employees quickly and efficiently.
	* Kovan Contract Address: https://kovan.etherscan.io/tx/0xce1dcee897aa49a8ec64d75a158242adb9ffa4029555ea785cb0f07d64fcdd1c
	* Contract Address:0xd8dea9e9857812beccab53700dc7651a08fbf37d
	

	* `balance` -- This function returns the contract's current balance. This function should always return `0` since this contract always sends any remainer Ether to the beneficiaries or returns it to the sender.
	
	* `deposit` -- This function will allow ether deposits. It will split the amount deposited by 3 and tranfer it to each emplooyees accounts. Since solidity does not handle float/decimals the contract will transfer any remainer back to the `msg.sender` (through the fallback function). 



### Starter-Code/TieredProfitSplitter.sol

	* Contract Description: This contract will distribute different percentages of incoming Ether to employees at different tiers/levels. For example, the CEO gets paid 60%, CTO 25%, and Bob gets 15%.
	* Kovan Contract Address: https://kovan.etherscan.io/tx/0x00867ae236d9d1683aba89597ad73706deb66f56e9510a614d6cb7b8de633b14
	* Contract Address: 0x5b66716e9e8a87db3be0e1af9ff5cff0d2046b08

	
	* `balance` -- This function returns the contract's current balance. This function should always return `0` since this contract always sends any remainer Ether to the beneficiaries or returns it to the 'msg.sender'.
	
	* `deposit` -- This function will allow ether deposits. It will proportionally split the amount deposited and distribute it based on the persentage assigned to eache address. Since solidity does not handle float/decimals the contract transfer any remainer back to the `msg.sender` (through the fallback function). 
	
### DeferredEquityPlan.sol

	* Contract Description: This contract models traditional company stock plans. This contract will automatically manage 1000 shares with an annual distribution of 250 over 4 years for a single employee.
	* Kovan Contract Address: https://kovan.etherscan.io/tx/0xa3b07d2a30eeec938c5fcb296bb4a3d97aabde547b14616a258b5f82d0733638
	* Contract Address: 0x9d87f7e2f47fb78ae0c7931c74bc197a9aa7fab4


### Level Three: The `DeferredEquityPlan` Contract

In this contract, we will be managing an employee's "deferred equity incentive plan" in which 1000 shares will be distributed over 4 years to the employee. We won't need to work with Ether in this contract, but we will be storing and setting amounts that represent the number of distributed shares the employee owns and enforcing the vetting periods automatically.


  * Create a `uint` called `total_shares` and set this to `1000`.

  * Create another `uint` called `annual_distribution` and set this to `250`. This equates to a 4 year vesting period for the `total_shares`, as `250` will be distributed per year. Since it is expensive to calculate this in Solidity, we can simply set these values manually. You can tweak them as you see fit, as long as you can divide `total_shares` by `annual_distribution` evenly.

* The `uint start_time = now;` line permanently stores the contract's start date. We'll use this to calculate the vested shares later. Below this variable, set the `unlock_time` to equal `now` plus `365 days`. We will increment each distribution period.

* The `uint public distributed_shares` will track how many vested shares the employee has claimed and was distributed. By default, this is `0`.

* In the `distribute` function:

  * Add the following `require` statements:

    * Require that `unlock_time` is less than or equal to `now`.

    * Require that `distributed_shares` is less than the `total_shares` the employee was set for.

    * Ensure to provide error messages in your `require` statements.

  * After the `require` statements, add `365 days` to the `unlock_time`. This will calculate next year's unlock time before distributing this year's shares. We want to perform all of our calculations like this before distributing the shares.

  * Next, set the new value for `distributed_shares` by calculating how many years have passed since `start_time` multiplied by `annual_distributions`. For example:

    * The `distributed_shares` is equal to `(now - start_time)` divided by `365 days`, multiplied by the annual distribution. If `now - start_time` is less than `365 days`, the output will be `0` since the remainder will be discarded. If it is something like `400` days, the output will equal `1`, meaning `distributed_shares` would equal `250`.

    * Make sure to include the parenthesis around `now - start_time` in your calculation to ensure that the order of operations is followed properly.

  * The final `if` statement provided checks that in case the employee does not cash out until 5+ years after the contract start, the contract does not reward more than the `total_shares` agreed upon in the contract.

* Deploy and test your contract locally.

  * For this contract, test the timelock functionality by adding a new variable called `uint fakenow = now;` as the first line of the contract, then replace every other instance of `now` with `fakenow`. Utilize the following `fastforward` function to manipulate `fakenow` during testing.

  * Add this function to "fast forward" time by 100 days when the contract is deployed (requires setting up `fakenow`):

    ```solidity
    function fastforward() public {
        fakenow += 100 days;
    }
    ```

  * Once you are satisfied with your contract's logic, revert the `fakenow` testing logic.

* Congratulate yourself for building such complex smart contracts in your first week of Solidity! You are learning specialized skills that are highly desired in the blockchain industry!

### Deploy the contracts to a live Testnet

Once you feel comfortable with your contracts, point MetaMask to the Kovan or Ropsten network. Ensure you have test Ether on this network!

After switching MetaMask to Kovan, deploy the contracts as before and copy/keep a note of their deployed addresses. The transactions will also be in your MetaMask history, and on the blockchain permanently to explore later.

![Remix Deploy](Images/remix-deploy.png)

## Resources

Building the next financial revolution isn't easy, but we need your help, don't be intimidated by the semicolons!

There are lots of great resources to learn Solidity. Remember, you are helping push the very edge of this space forward,
so don't feel discouraged if you get stuck! In fact, you should be proud that you are taking on such a challenge!

For some succinct and straightforward code snips, check out [Solidity By Example](https://github.com/raineorshine/solidity-by-example)

For a more extensive list of awesome Solidity resources, checkout [Awesome Solidity](https://github.com/bkrem/awesome-solidity)

Another tutorial is available at [EthereumDev.io](https://ethereumdev.io/)

If you enjoy building games, here's an excellent tutorial called [CryptoZombies](https://cryptozombies.io/)

## Submission

Create a `README.md` that explains what testnet the contract is on, the motivation for the contract.

Upload this to a Github repository that explains how the contract works, and provide the testnet address for others to be able to send to.
