// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Week 4 - Day 2 : Class Work

// Write a StudentPortal smart contract where only the owner can register students into the smart contract.

// Only the owner can update and delete students records.

// Write other functions that will return students records

// Student records includes, but not limited to:
// Name, email, date of birth, lga, country, state

contract StudentPortal {

    address  owner;
   
    //constructor only runs once 
    constructor(){
        owner = msg.sender;
    }
    
    struct Student {
        uint256 index;
        string name;
        string email;
        string date;
        string lga;
        string country;
        string state;
    }

    Student[]  students;

     modifier onlyOwner(){
        
        require(msg.sender ==owner,"sorry,you don't have admin rights");
        _;
        
    }

    function registerStudent(
    string memory _name,
    string memory _email, 
    string memory _date,
    string memory _lga,
    string memory _country,
    string memory _state
    ) external  onlyOwner{

        Student memory sd;

        sd.name =_name;
        sd.email =_email;
        sd.date = _date;
        sd.lga =_lga;
        sd.country = _country;
        sd.state = _state;

        students.push(sd);
        

    }

    function updateStudent(
    uint256 _index,
    string memory _name,
    string memory _lga,
    string memory _country,
    string memory _state
    ) external onlyOwner{

        require(_index < students.length,"cannot find student here");

        Student storage sd = students[_index];

        sd.name =_name;
        sd.lga =_lga;
        sd.country = _country;
        sd.state = _state;

    }

    function getStudents() external view  returns (Student[] memory) {
        return students;
    }


    function getStudent(uint256 _index) external view returns(Student memory){
        require(_index < students.length,"cannot find student");
        return students[_index];

    }

    function deleteStudentRecord(uint256 _index) external onlyOwner{
            require(_index < students.length,"cannot find student here");
            delete students[_index];
    }

}