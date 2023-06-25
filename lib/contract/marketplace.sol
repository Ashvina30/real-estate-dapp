// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    mapping(uint256 => bool) private listedProperties;

    // Events
    event PropertyListed(uint256 propertyId);
    event PropertyRemoved(uint256 propertyId);

    // Function to list a property
    function listProperty(uint256 propertyId) public {
        require(!listedProperties[propertyId], "Property is already listed.");
        listedProperties[propertyId] = true;
        emit PropertyListed(propertyId);
    }

    // Function to remove a property
    function removeProperty(uint256 propertyId) public {
        require(listedProperties[propertyId], "Property is not listed.");
        listedProperties[propertyId] = false;
        emit PropertyRemoved(propertyId);
    }

    // Function to check if a property is listed
    function isPropertyListed(uint256 propertyId) public view returns(bool) {
        return listedProperties[propertyId];
    }
}