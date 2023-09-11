// references https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=builtin
// references cont. https://www.youtube.com/watch?v=EhPeHeoKF88


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//booking a hotel room and paying for it

contract HotelRoom {
    //Ether payments
    //Modifiers
    //Visibility
    //Events
    //Enums

    enum Statuses { Vacant, Occupied }
    Statuses public currentStatus;

    event Occupy(address _occupant, uint _value);

    //state variable
    //address of the hotel room owner
    //payable, lets them recieve currency for room
    address payable public owner;

    //want the owner value to be dynamic
    constructor(){
        //tells us who is deploying this function
        owner = payable(msg.sender);
        //tells us the status of the room
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
         //check status
        require(currentStatus == Statuses.Vacant, "currently occupied!");
        _;
    }

    modifier costs(uint _amount){
      //check price
        require(msg.value >= _amount, "Not enough ether...");
        _;
    }

    function book() public payable onlyWhileVacant costs(2 ether) {
     //change status upon booking for the room
        currentStatus = Statuses.Occupied;

        //sends currency to the recipiant
        //currency comes from the person calling the book function
    
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true);
       

        emit Occupy(msg.sender, msg.value);
    }
}
