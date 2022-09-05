// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
import "./IStarknetCore.sol";

contract L2Messaging {
    uint256 constant EVALUATOR_ADDRESS = 2526149038677515265213650328426051013974292914551952046681512871525993794969;

    uint256 constant SELECTOR = 2;

    IStarknetCore immutable starknetcore;

    constructor(IStarknetCore _starknetcoreAddress) {
        require(address(_starknetcoreAddress) != address(0), "Address is a zero address");
        starknetcore = _starknetcoreAddress;
    }

    function sendMessage() external returns(bool) {
        uint256[] memory payload = new uint256[](1);
        payload[0] = uint256(uint160(msg.sender));
        starknetcore.sendMessageToL2(EVALUATOR_ADDRESS, SELECTOR, payload);
        return true;
    }
}