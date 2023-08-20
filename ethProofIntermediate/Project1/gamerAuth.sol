// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract gamerAuth {
    
    address public moderator;

 
    mapping (uint => bool) IdStates;

    function enableId(uint _Id) public onlyModerator {

        assert(_Id != 0);

        IdStates[_Id] = true;
    }

    function disableId(uint _Id) public onlyModerator {

        require(msg.sender == moderator, "only the moderator is allowed to perform this action");

        IdStates[_Id] = true;
    }


    modifier onlyModerator {

        if (msg.sender != moderator) {
            revert('you are not the moderator');
        }
        _;
    }



    constructor() {
        moderator = msg.sender; 
    }




}