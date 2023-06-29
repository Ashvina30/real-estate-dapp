// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract Individual {
    uint32 user_id = 0;

    struct User {
        address userAddress;
        string first_name;
        string last_name;
        string username;
        string email;
        bytes32 password;
        string user_ID;
    }

    mapping (uint32 => User) public users;
    mapping (string => uint32) public usersByUsername;
    mapping (address => uint32) public addressByUserID;
    mapping (string => bool) public isUsernameExists;

    event LogUserRegistered(uint32 userId, string username);

    function registerUser(string memory _firstname, string memory _lastname, string memory _username,
                          string memory _email, string memory _password) public {
        require(!isUsernameExists[_username], "Username already exists");

        uint32 userId = user_id++;
        users[userId].userAddress = msg.sender;
        users[userId].first_name = _firstname;
        users[userId].last_name = _lastname;
        users[userId].username = _username;
        users[userId].email = _email;
        users[userId].password = hashPassword(_password);
        users[userId].user_ID = string(abi.encodePacked(userId));

        isUsernameExists[_username] = true;
        usersByUsername[_username] = userId;
        addressByUserID[msg.sender] = userId;

        emit LogUserRegistered(userId, users[userId].username);
    }

    function getUser(uint32 _user_id) public view returns (string memory, address, string memory){
        return (
            users[_user_id].username,
            users[_user_id].userAddress,
            users[_user_id].email
        );
    }

    function hashPassword(string memory _password) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(_password));
    }

    function getUserId(string memory _username) public view returns (uint32) {
        return usersByUsername[_username];
    }

    function authenticate(string memory _username, string memory _password) public view returns (bool) {
        if (!isUsernameExists[_username]) {
            return false;
        }
        bytes32 hashedPassword = hashPassword(_password);
        return users[usersByUsername[_username]].password == hashedPassword;
    }

    function getAllUsers() public view returns (User[] memory) {
        User[] memory result = new User[](user_id);
        for (uint32 i = 0; i < user_id; i++) {
            result[i] = users[i];
        }
        return result;
    }
}
