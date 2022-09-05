// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./IStarknetCore.sol";

contract L1Consumption {
    uint256 immutable EVALUATOR_ADDRESS;

    IStarknetCore immutable starknetcore;

    constructor(IStarknetCore _starknetcore, uint256 evaluatorAddress) {
        require(address(_starknetcore) != address(0), "Address is a zero address");
        starknetcore = _starknetcore;
        EVALUATOR_ADDRESS = evaluatorAddress;
    } 

    function consumeMessage() external {
        uint256[] memory payload = new uint256[](1);
        payload[0] = uint256(uint160(msg.sender));

        starknetcore.consumeMessageFromL2(EVALUATOR_ADDRESS, payload);
    }
}