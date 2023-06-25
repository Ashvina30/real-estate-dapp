// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Registry {

    struct Transaction {
        uint256 propertyId;
        address from;
        address to;
        uint256 value;
        uint timestamp;
    }

    Transaction[] public transactions;

    function addTransaction(uint256 _propertyId, address _from, address _to, uint256 _value) public {
        Transaction memory newTransaction = Transaction({
            propertyId: _propertyId,
            from: _from,
            to: _to,
            value: _value,
            timestamp: block.timestamp
        });

        transactions.push(newTransaction);
    }

    function getTransactions() public view returns (Transaction[] memory) {
        return transactions;
    }
}