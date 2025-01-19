   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.0;

   contract Voting {
       mapping(address => bool) public voters;
       mapping(string => uint256) public votesReceived;
       string[] public candidateList;

       constructor(string[] memory candidateNames) {
           candidateList = candidateNames;
       }

       function vote(string memory candidate) public {
           require(!voters[msg.sender], "You have already voted.");
           require(validCandidate(candidate), "Invalid candidate.");

           voters[msg.sender] = true;
           votesReceived[candidate] += 1;
       }

       function totalVotesFor(string memory candidate) public view returns 
(uint256) {
           require(validCandidate(candidate), "Invalid candidate.");
           return votesReceived[candidate];
       }

       function validCandidate(string memory candidate) internal view 
returns (bool) {
           for (uint256 i = 0; i < candidateList.length; i++) {
               if (keccak256(abi.encodePacked(candidateList[i])) == 
keccak256(abi.encodePacked(candidate))) {
                   return true;
               }
           }
           return false;
       }
   }
