// User joins a web interface
// User sees a list of active tournaments
// User joins a tournament
// User waits in the lobby
// Once the tournament lobby reaches a specified NUMBER_OF_USERS, the tournament STARTs
// Once the tournament ENDs, the system calculates the scores and plots theleaderboard

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract GameTournament {
    // Tournament state
    enum State {
        WAITING,
        STARTED,
        ENDED
    }
    State public state;
    uint public NUMBER_OF_USERS;
    address[] public users;
    mapping (address => uint) public userScores;
    address[] public leaderboard;
    address[] public rankings;

    constructor()  {
        state = State.WAITING;
        NUMBER_OF_USERS = 10;
    }


    // Initialize
    function initialize() public {
        state = State.WAITING;
    }

    // Join tournament
    function joinTournament(address user) public {
        require(state == State.WAITING, "Tournament not yet started");
        users.push(user);
        if (users.length == NUMBER_OF_USERS) {
            startTournament();
        }
    }

    // Tournament Starts
    function startTournament() public {
        state = State.STARTED;
    }

    // Tournment Ends
    function endTournament() public {
        state = State.ENDED;
        createLeaderboard();
    }

    // Creating the leaderboard and calculating the scores 
    function createLeaderboard() public {
        // Sorting the users by score
        for (uint i = 0; i < users.length; i++) {
            for (uint j = i + 1; j < users.length; j++) {
                if (userScores[users[i]] < userScores[users[j]]) {
                    address temp = users[i];
                    users[i] = users[j];
                    users[j] = temp;
                }
            }
        }
        for (uint i = 0; i < users.length; i++) {
            leaderboard.push(users[i]);
        }
    }
}
