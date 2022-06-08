// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage {
    // solidity types: boolean, uint, int, address, bytes
    // default uint is uint256


    // This is 0 by default
    uint256 favoriteNumber;

    // mapping from string to uint256

    mapping(string => uint256) public nameToFavoriteNumber;

    // People public person = People({favoriteNumber: 24, name: "Paul"});

    // object People

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // array of People

    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber =_favoriteNumber;
    }

    // view pure --> just to read --> not update state
    // calling view functions is free

    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}