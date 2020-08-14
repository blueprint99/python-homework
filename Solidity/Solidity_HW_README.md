# "Solidity Contract HW!"

All the contracts descrived below are deployed in the the Kovan test network.

## Contracts

### AssociateProfitSplitter

* Contract Description: This contract will accept Ether into the contract and divide the Ether evenly among the associate level employees. This will allow the Human Resources department to pay employees quickly and efficiently.
		
* Contract Address:0xd8dea9e9857812beccab53700dc7651a08fbf37d

![](/AssociateProfitSplitter.JPG "AssociateProfitSplitter")

When the contract is deployed for this contract the constructor function that accepts three addresses:

address payable _one
address payable _two
address payable _three

Each address is associated with the employees that the will receive an equal portion of Ether.


Post deployment:
	
	* Deposit function: The contract can be used to deposit Ether into the employees addresses using the deposit function which will divide the amount deposited by 3.
	Since solidity does not handle float/decimals the contract transfers any remainer back to the `msg.sender` by calculationg this funcition: owner.transfer(msg.value - amount * 3)

	* Balance function: should be used to test that there is never a balance of Ether remaining in the contract. The return should always give you 0.

	* To preveint any Ether from being locked into this contract, as there is no withdraw funcition,  a fallback function is used to call the deposit function, ensuring the depoist logic executes if Ether is transfered into the contract.

### TieredProfitSplitter

* Contract Description: This contract will distribute different percentages of incoming Ether to employees at different tiers/levels. For example, the CEO gets paid 60%, CTO 25%, and Bob gets 15%.

* Contract Address: 0x5b66716e9e8a87db3be0e1af9ff5cff0d2046b08

![](/TieredProfitSplitter.JPG "TieredProfitSplitter")
	
When the contract is deployed for this contract the constructor function that accepts three addresses:

address payable _one
address payable _two
address payable _three

Each address is associated with the employees that the will receive an equal portion of Ether.


Post deployment:

	* Deposit function: The contract can be used to deposit Ether into the employees addresses using the deposit function which will distribute the Ether depending on the percentage assigned to each address, in this case 40% employee_one, 35% employee_two, 25% employee_three
	To calculate how much Ether is distributed the function will keep a running count everytime it distributes Ether to an address. 
	Since solidity does not handle float/decimals the contract transfers any remainer back to the 'employee_one` by calculationg the amount received minus the sum of the amount distributed.

	* Balance function: should be used to test that there is never a balance of Ether remaining in the contract. The return should always give you 0.

	* To preveint any Ether from being locked into this contract, as there is no withdraw funcition,  a fallback function is used to call the deposit function, ensuring the depoist logic executes if Ether is transfered into the contract.

### DeferredEquityPlan

	* Contract Description: This contract models traditional company stock plans. This contract will automatically manage 1000 shares with an annual distribution of 250 over 4 years for a single employee.

	* Contract Address: 0x9d87f7e2f47fb78ae0c7931c74bc197a9aa7fab4

![](/profitsplitter_1st_transaction.JPG, "profitsplitter_1st_transaction")

When the contract is deployed for this contract the constructor function that accepts one address, which will be the address where the shares will be deposited.

Post deployment:

	* Distribute function: Allows human resources to distribute the shares as long as sertain parameters are met, set by the "require" command.

		** require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract."): Sets so that on Human resorces or the employee can call this function
        	** require(active == true, "Contract not active."): Checks if employee is an active employee if not it stops the function.
        	** require(unlock_time <= fakenow, "The time to distribute shares has not arrived yet"): Distribution of shares can only be done at specific interbals, this checks that the period of distribution has been met.
        	** require(distributed_shares < total_shares, "The number of distributed shares excide the number of total shares the employee is set for"): checks so that only allowed number of shares are distributed.
		
	Shares can be distributed over a period of four years. If more than four years have passed and the distribute function is ran the funtion will not distribute more than 1000 shares by setting a max.

	* Deactivate function: This function can nly be ran by Human resources or the employee. If ran it will change the active status of the employee to false disabeling that employee to receive future distributions.

	* Fastforward function: in order to test the validity of this contract we can use this function to manipulate the contract's timeclock. This function when ran adds 100 days to the contract, once 365 days have passed we should be able to successfully test the deposit function.

	* Since this contract does not handle Ether a fallback function is used which messages "Do not send Ether to this contract!" if Ether is sent to the contract.


