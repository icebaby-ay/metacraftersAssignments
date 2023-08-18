// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract gamerAuth {
    
    address public moderator;

    uint public nextKey;

    mapping(uint => address) private keyOwners;
    mapping(address => uint) private userKeys;
    mapping(uint => bool) private keyStates;

    modifier onlyModerator {
        require(msg.sender == moderator, 'only the moderator is allowed to perform this action');
        _;
    }

    constructor() {
        moderator = msg.sender; // The creator of the contract is set as the moderator
        nextKey = 1; // Initializing the nextKey counter to 1
    }

    function grantKey(address user) public onlyModerator {
        uint key = nextKey;
        keyOwners[key] = user;
        userKeys[user] = key;
        keyStates[key] = true;
        nextKey++;
    }

    function disableKey(uint _key) public onlyModerator {
        assert(_key != 0);
        keyStates[_key] = false;
    }

    function checkKey(address user) public view returns(bool) {
        uint userKey = userKeys[user];
        if (userKey == 0) {
            revert('user does not have a key');
        }else {
            return keyStates[userKey];
        }
    }
}
