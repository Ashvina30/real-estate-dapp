// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./Marketplace.sol";
import "./Registry.sol";
contract Property {

    struct PropertyDetails {
        string propertyType;
        string photos;
        address currentOwner;
        uint price;
        address propertyAddress;
        uint[] transactionHistory;
    }

    struct OwnerDetails {
        string name;
        string email;
        string phoneNumber;
    }


struct UserDetails {
        string name;
        string email;
        string phoneNumber;
        string password;
        address[] propertiesOwned;
        uint[] listingsMade;
        uint[] transactions;
        uint wallet;
        address[] savedProperties;
        uint idNumber;
    }

    struct Transaction {
    uint transactionId;
    string description;
    uint amount;
    address sender;
    address receiver;
    uint timestamp;
}

  struct Offer {
    uint offerId;
    uint propertyId;
    address bidder;
    uint amount;
    uint timestamp;
    bool accepted;
}

    mapping(address => OwnerDetails) public owners;
    mapping(uint => PropertyDetails) public properties;
    mapping(uint256 => string) public category1Properties;
    mapping(uint256 => string) public category2Properties;
    mapping(uint256 => string) public category3Properties;
    mapping(uint256 => string) public category4Properties;
    mapping(uint256 => string) public category5Properties;
    mapping(uint256 => string) public category6Properties;
    mapping(uint256 => string) public category7Properties;
    mapping(uint256 => string) public category8Properties;
    mapping(uint256 => string) public category9Properties;
    mapping(uint256 => string) public category10Properties;


    // event PropertyTransferred(uint indexed propertyId, address indexed from, address indexed to);
    // event TransactionRecorded(uint indexed propertyId, address indexed owner, uint price);
    event PropertyTypeChanged(uint indexed propertyId, string propertyType);
    event PropertyRemovedFromMarketplace(uint indexed propertyId);
    event PropertyListedForSale(uint indexed propertyId);



    Marketplace private marketplace;
    Registry private registry;
    Property public propertyContract;
    address public registryContract;

    // constructor(address _propertyContract, address _registryContract) {
    //     propertyContract = Property(_propertyContract);
    //     registryContract = _registryContract;
    // }

    function ownerOf(uint256 _propertyId) public view returns (address) {
    return properties[_propertyId].currentOwner;
    }


    constructor(address _marketplaceAddress, address _registryAddress, address _propertyContract, address _registryContract) {
        marketplace = Marketplace(_marketplaceAddress); 
        registry = Registry(_registryAddress);
        propertyContract = Property(_propertyContract);
        registryContract = _registryContract;
    }


        function transferProperty(address _to, uint _propertyId) public {
        require(propertyContract.ownerOf(_propertyId) == msg.sender, "You do not own this property.");
        propertyContract.transferFrom(msg.sender, _to, _propertyId);
        recordTransactionToRegistry(msg.sender, _to, _propertyId);
        users[msg.sender].propertiesOwned.push(_propertyId);
        for (uint i = 0; i < users[msg.sender].propertiesOwned.length; i++) {
            if (users[msg.sender].propertiesOwned[i] == _propertyId) {
                delete users[msg.sender].propertiesOwned[i];
            }
        }
    }



    function addTransactionToHistory(uint _propertyId, address _owner, uint _price) internal {
    properties[_propertyId].transactionHistory.push(block.timestamp);
    properties[_propertyId].transactionHistory.push(_price);
    properties[_propertyId].transactionHistory.push(uint256(uint160(_owner)));
    emit TransactionRecorded(_propertyId, _owner, _price);
}

    // function getCurrentOwner(uint _propertyId) public view returns (address) {
    //     return properties[_propertyId].currentOwner;
    // }

   
    function getHistory(uint _propertyId) public view returns (uint[] memory) {
        return properties[_propertyId].transactionHistory;
    }

    function changePropertyType(uint _propertyId, string memory _propertyType) public {
        properties[_propertyId].propertyType = _propertyType;
        emit PropertyTypeChanged(_propertyId, _propertyType);
    }


// // Function to remove property from marketplace
// function removeFromMarketplace(uint256 propertyId) public {
//     require(properties[propertyId].isOnMarketplace, "Property is not on marketplace.");
//     require(properties[propertyId].owner == msg.sender, "Only property owner can remove property from marketplace.");

//     properties[propertyId].isOnMarketplace = false;
//     marketplace.remove(propertyId);
//     emit PropertyRemovedFromMarketplace(propertyId);
// }



// // Function to view offers
// function viewOffers() public view returns (Offer[] memory) {
//     return users[msg.sender].offers;
// }



// Function to add to listingsMade
function addToListingsMade(uint listingId) public {
    users[msg.sender].listingsMade.push(listingId);
}



// Function to generate propertyID
function generatePropertyId() public view returns (uint256) {
    return properties.length;
}




// Function to calculate and display tax
function calculateAndDisplayTax(uint256 propertyId) public view returns (uint256) {
    // Calculation logic for tax
    // ...
    // Return tax amount
}



// Function to add transaction to history
function addTransactionToHistory(address _from, address _to, uint256 _tokenId) public {
    // Add transaction to history
    // ...
}



// Function to get current owner of property
function getCurrentOwner(uint256 propertyId) public view returns (address) {
    return properties[propertyId].owner;
}



// Function to get number of transactions
function getNumberOfTransactions(address userAddress) public view returns (uint256) {
    return users[userAddress].transactions.length;
}



// Function to get history of property (history of owners, prices, date and time, current owner)
function getPropertyHistory(uint256 propertyId) public view returns (Transaction[] memory) {
    return properties[propertyId].transactionHistory;
}



// Function to change property type
function changePropertyType(uint256 propertyId, uint256 newType) public {
    properties[propertyId].propertyType = newType;
}



// // Function to add listing
// function addListing(uint256 _propertyId) public {
//     require(propertyContract.ownerOf(_propertyId) == msg.sender, "You do not own this property.");
//     uint256 listingId = propertyContract.addListing(_propertyId);
//     users[msg.sender].listingsMade.push(listingId);
// }



// // Function to get listing details
// function getListingDetails(uint256 _listingId) public view returns (uint256, uint256, uint256, uint256, uint256) {
//     return propertyContract.getListingDetails(_listingId);
// }



// // Function to record transaction to registry
// function recordTransactionToRegistry(address _from, address _to, uint256 _tokenId) private {
//     Registry registry = Registry(registryContract);
//     registry.addTransaction(_from, _to, _tokenId);
// }



// Function to list property for sale
function listPropertyForSale(uint256 propertyId, uint256 price) public {
    properties[propertyId].forSale = true;
    properties[propertyId].price = price;
    properties[propertyId].isOnMarketplace = true;
    marketplace.add(propertyId);
    emit PropertyListedForSale(propertyId);
}



// // Function to view properties owned
// function viewPropertiesOwned() public view returns (address[] memory) {
//     return users[msg.sender].propertiesOwned;
// }



// // Function to view properties listed
// function viewPropertiesListed() public view returns (uint256[] memory) {
//     return users[msg.sender].listingsMade;
// }



// // Function to view profile
// function viewProfile() public view returns (string memory, string memory, string memory, uint256, uint256) {
//     return (users[msg.sender].name, users[msg.sender].email, users[msg.sender].phoneNumber, users[msg.sender].wallet, users[msg.sender].idNumber);
// }



// // Function to save property
// function saveProperty(uint256 _propertyId) public {
//     users[msg.sender].savedProperties.push(_propertyId);
// }



// // Function to transfer property
// function transferProperty(uint256 propertyId, address payable newOwner) public {
//     require(properties[propertyId].owner == msg.sender, "Only property owner can transfer property.");
//     require(newOwner != address(0), "Invalid new owner address.");

//     // Add transaction to property history
//     properties[propertyId].transactionHistory.push(Transaction(
//         properties[propertyId].owner,
//         newOwner,
//         properties[propertyId].price,
//         block.timestamp
//     ));

//     // Update owner details
//     properties[propertyId].previousOwner = properties[propertyId].owner;
//     properties[propertyId].owner = newOwner;

//     // Update user details
//     users[newOwner].propertiesOwned.push(propertyId);
//     uint256 index = users[msg.sender].propertiesOwned.indexOf(propertyId);
//     users[msg.sender].propertiesOwned.removeAtIndex(index);

//     emit PropertyTransferred(propertyId, msg.sender, newOwner);
// }

// // Function to accept offer
// function acceptOffer(uint256 _listingId, address _buyer) public {
//     require(propertyContract.ownerOf(propertyContract.propertyFromListing(_listingId)) == msg.sender, "You do not own this property.");
//     propertyContract.acceptOffer(_listingId, _buyer);
// }

// // Function to make offer
// function makeOffer(uint256 _listingId, uint256 _offer) public {
//     propertyContract.makeOffer(_listingId, msg.sender, _offer);
// }

// // Function to purchase
// function purchase(uint256 _propertyId) public payable {
//     require(properties[_propertyId].forSale, "Property is not for sale");
//     require(properties[_propertyId].price == msg.value, "Invalid amount sent");

//     // Update property ownership
//     PropertyDetails storage property = properties[_propertyId];
//     address previousOwner = property.owner;
//     property.owner = msg.sender;
//     property.forSale = false;

//     // Update user's properties and transactions
//     users[msg.sender].propertiesOwned.push(_propertyId);
//     users[previousOwner].propertiesOwned.remove(_propertyId);
//     users[msg.sender].addTransaction(_propertyId, previousOwner, msg.value);

//     // Transfer funds to previous owner
//     payable(previousOwner).transfer(msg.value);

//     // Record transaction in registry
//     Registry.recordTransaction(_propertyId, previousOwner, msg.sender, msg.value);
// }


// // Function to view wallet amount
// function viewWalletAmount() public view returns (uint256) {
//     return users[msg.sender].wallet;
// }


// // Function to view transactions
// function viewTransactions() public view returns (Transaction[] memory) {
//     return users[msg.sender].transactions;
// }


// // Function to view offers
// function viewOffers() public view returns (Offer[] memory) {
//     return users[msg.sender].offers;
// }


// // Function to modify listing
// function modifyListing(uint256 _propertyId, uint256 _price) public {
//     require(properties[_propertyId].currentOwner == msg.sender, "You are not the current owner of this property");
//     properties[_propertyId].price = _price;
// }





// Function to make transfer and record to property history and registry
function makeTransferAndRecord(uint256 propertyId, address payable newOwner, uint256 amount) public {
    require(properties[propertyId].owner == msg.sender, "You are not the current owner of this property.");
    
    // Add transaction to property history
    properties[propertyId].transactionHistory.push(Transaction(
        properties[propertyId].owner,
        newOwner,
        amount,
        block.timestamp
    ));

    // Update owner details
    properties[propertyId].previousOwner = properties[propertyId].owner;
    properties[propertyId].owner = newOwner;

    // Update user details
    users[newOwner].propertiesOwned.push(propertyId);
    uint256 index = users[msg.sender].propertiesOwned.indexOf(propertyId);
    users[msg.sender].propertiesOwned.removeAtIndex(index);

    // Record transaction in registry
    Registry.recordTransaction(propertyId, msg.sender, newOwner, amount);
}

// Function to add transaction to user transactions
function addTransaction(uint256 _propertyId, address _previousOwner, uint256 _amount) internal {
    users[msg.sender].transactions.push(Transaction(_propertyId, _previousOwner, _amount, block.timestamp));
}

// Function to view property from category 1
function viewPropertyFromCategory1(uint256 _propertyId) public view returns (string memory) {
    return category1Properties[_propertyId];
}

// Function to view property from category 2
function viewPropertyFromCategory2(uint256 _propertyId) public view returns (string memory) {
    return category2Properties[_propertyId];
}

// Function to view property from category 3
function viewPropertyFromCategory3(uint256 _propertyId) public view returns (string memory) {
    return category3Properties[_propertyId];
}

// Function to view property from category 4
function viewPropertyFromCategory4(uint256 _propertyId) public view returns (string memory) {
    return category4Properties[_propertyId];
}

// Function to view property from category 5
function viewPropertyFromCategory5(uint256 _propertyId) public view returns (string memory) {
    return category5Properties[_propertyId];
}

// Function to view property from category 6
function viewPropertyFromCategory6(uint256 _propertyId) public view returns (string memory) {
    return category6Properties[_propertyId];
}

// Function to view property from category 7
function viewPropertyFromCategory7(uint256 _propertyId) public view returns (string memory) {
    return category7Properties[_propertyId];
}

// Function to view property from category 8
function viewPropertyFromCategory8(uint256 _propertyId) public view returns (string memory) {
    return category8Properties[_propertyId];
}

// Function to view property from category 9
function viewPropertyFromCategory9(uint256 _propertyId) public view returns (string memory) {
    return category9Properties[_propertyId];
}

// Function to view property from category 10
function viewPropertyFromCategory10(uint256 _propertyId) public view returns (string memory) {
    return category10Properties[_propertyId];
}

// Function to make payment
function makePayment(address payable _recipient, uint256 _amount) public payable {
    require(users[msg.sender].wallet >= _amount, "Insufficient funds in wallet.");
    users[msg.sender].wallet -= _amount;
    _recipient.transfer(_amount);
}

// Function to calculate tax
function calculateTax(uint256 _price) public pure returns (uint256) {
    // Perform tax calculation logic here
    // ...
}


// Function to view user transaction history
function viewUserTransactionHistory() public view returns (Transaction[] memory) {
    return users[msg.sender].transactions;
}




    event PropertyTransferred(uint propertyId, address indexed previousOwner, address indexed newOwner);
    event TransactionRecorded(uint256 transactionId, address userAddress, uint256 propertyId);


    
    PropertyDetails[] public propertyArray; // changed name and type
    mapping(address => UserDetails) public users;







    // function to add listing
    function addListing(uint _propertyId) public {
        require(propertyContract.ownerOf(_propertyId) == msg.sender, "You do not own this property.");
        uint listingId = propertyContract.addListing(_propertyId);
        users[msg.sender].listingsMade.push(listingId);
    }

    // function display listing
    function getListingDetails(uint _listingId) public view returns (uint, uint, uint, uint, uint) {
        return propertyContract.getListingDetails(_listingId);
    }

    // function record transaction to history
    function recordTransactionToRegistry(address _from, address _to, uint _tokenId) private {
        Registry registry = Registry(registryContract);
        registry.addTransaction(_from, _to, _tokenId);
    }
    
   
   // function to view properties owned
    function viewPropertiesOwned() public view returns (address[] memory) {
        return users[msg.sender].propertiesOwned;
    }
  
    // function to view listed properties
    function viewPropertiesListed() public view returns (uint[] memory) {
        return users[msg.sender].listingsMade;
    }


    // function to view profile details
    function viewProfile() public view returns (string memory, string memory, string memory, uint, uint) {
        return (users[msg.sender].name, users[msg.sender].email, users[msg.sender].phoneNumber, users[msg.sender].wallet, users[msg.sender].idNumber);
    }
    
    // function to save property
    function saveProperty(uint _propertyId) public {
        users[msg.sender].savedProperties.push(_propertyId);
    }


    //function to accept offer
    function acceptOffer(uint _listingId, address _buyer) public {
        require(propertyContract.ownerOf(propertyContract.propertyFromListing(_listingId)) == msg.sender, "You do not own this property.");
        propertyContract.acceptOffer(_listingId, _buyer);
    }


    //function to decline offer


    //function to make offer
    function makeOffer(uint _listingId, uint _offer) public {
        propertyContract.makeOffer(_listingId, msg.sender, _offer);
    }
    bool forSale = true;
    function purchase(uint256 _propertyId) public payable {
    require(properties[_propertyId].forSale, "Property is not for sale");
    require(properties[_propertyId].price == msg.value, "Invalid amount sent");

    // Update property ownership
    PropertyDetails storage property = properties[_propertyId];
    address previousOwner = property.owner;
    property.owner = msg.sender;
    property.forSale = false;

    // Update user's properties and transactions
    users[msg.sender].propertiesOwned.push(_propertyId);
    users[previousOwner].propertiesOwned.remove(_propertyId);
    users[msg.sender].addTransaction(_propertyId, previousOwner, msg.value);

    // Transfer funds to previous owner
    payable(previousOwner).transfer(msg.value);

    // Record transaction in registry
    Registry.recordTransaction(_propertyId, previousOwner, msg.sender, msg.value);
}


// function to view wallet amount
function viewWalletAmount() public view returns (uint256) {
    return users[msg.sender].wallet;
}

// function to view user transactions
function viewTransactions() public view returns (Transaction[] memory) {
    return users[msg.sender].transactions;
}

//function to view offers
function viewOffers() public view returns (Offer[] memory) {
    return users[msg.sender].offers;
}

//function to modify listing
function modifyListing(uint256 _propertyId, uint256 _price) public {
    require(properties[_propertyId].currentOwner == msg.sender, "You are not the current owner of this property");
    properties[_propertyId].price = _price;
}


// Function to make transfer made be recorded to property history and then to registry
function transferProperty(uint256 propertyId, address payable newOwner) public {
    require(properties[propertyId].owner == msg.sender, "Only property owner can transfer property.");
    require(newOwner != address(0), "Invalid new owner address.");


    
    // Add transaction to property history
    properties[propertyId].transactionHistory.push(Transaction(
        properties[propertyId].owner,
        newOwner,
        properties[propertyId].price,
        block.timestamp
    ));
    


    // Update owner details
    properties[propertyId].previousOwner = properties[propertyId].owner;
    properties[propertyId].owner = newOwner;
    


    // Update user details
    users[newOwner].propertiesOwned.push(propertyId);
    uint256 index = users[msg.sender].propertiesOwned.indexOf(propertyId);
    users[msg.sender].propertiesOwned.removeAtIndex(index);
    
    emit PropertyTransferred(propertyId, msg.sender, newOwner);
}

function removeFromMarketplace(uint256 propertyId) public {
    require(properties[propertyId].isOnMarketplace, "Property is not on marketplace.");
    require(properties[propertyId].owner == msg.sender, "Only property owner can remove property from marketplace.");
    
    properties[propertyId].isOnMarketplace = false;
    marketplace.remove(propertyId);
    emit PropertyRemovedFromMarketplace(propertyId);
}

// Add transaction to user transactions
function addTransactionToUser(address userAddress, uint256 propertyId) internal {
    uint256 transactionId = users[userAddress].transactions.length;
    users[userAddress].transactions.push(Transaction(
        properties[propertyId].previousOwner,
        properties[propertyId].owner,
        properties[propertyId].price,
        block.timestamp
    ));
    
    emit TransactionRecorded(transactionId, userAddress, propertyId);
}
}


// Function to view property from property type 1
//function viewPropertyType1(uint256 index) public view returns (uint256[] memory) {
    //return propertyType1[index];
//}