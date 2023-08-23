// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract gamerAuth {
    
    address public moderator;

 
    mapping (uint => bool) IdStatus;
    mapping (address => uint) userIds;
    uint nextId;

    function enableId(uint _Id) public onlyModerator {

        assert(_Id != 0);

        IdStatus[_Id] = true;
    }

    function disableId(uint _Id) public {

        require(msg.sender == moderator, "only the moderator is allowed to perform this action");

        IdStatus[_Id] = false;
    }


    function checkId() view public returns (uint id, bool status) {
        id = userIds[msg.sender];
        status = IdStatus[id];
    }

    function giveId(address _user) public onlyModerator {
        require(userIds[_user] == 0, "This user already has an Id");
            userIds[_user] = nextId;
            IdStatus[nextId] = true;
            nextId++;
    }



    modifier onlyModerator {

        if (msg.sender != moderator) {
            revert('you are not the moderator');
        }
        _;
    }



    constructor() {
        moderator = msg.sender; 
        nextId = 1;
    }




}
