# PuzzleWorld
Logical gaming dapp with dispute resolution:

A puzzle maker submits a puzzle and a timeout for solving it, users submit offers for solving it and funds are collected in an escrow contract. A commit-reveal scheme allows to provide a solution without show it to other users. If the solution is correct funds and rewards are sent to the user, if the solution is not provided or it is wrong they are sent to puzzle maker.
Moreover, there is the possibility for the user to initialize a dispute if he believes that solution provided by puzzle maker is wrong. The dispute will be managed by Kleros decentralized dispute resolution protocol (ERC792) that will rule the winner of the dispute and funds will be sent according to this judgment.

--------------------------------------------------------------------------------------------------------------------------------

TRUFFLE INSTALLATION:

Install Node.js (download at https://github.com/nodesource/distributions/blob/master/README.md for linux dist and https://nodejs.org/it/download/ for Windows or MacOs)

npm install -g truffle (install Truffle framework globally on your machine)

TRUFFLE DEPENDENCIES:

openzeppelin library:

npm install @openzeppelin/contracts

truffle module that integrate link with Infura:

npm install truffle-hdwallet-provider

js library for mocha test:

npm install truffle-assertions
