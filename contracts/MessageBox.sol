// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import { Ownable } from '@openzeppelin/contracts/access/Ownable.sol';
import { IMessageBox, Message } from './interfaces/IMessageBox.sol';

contract MessageBox is Ownable, IMessageBox {
  mapping(address => Message[]) messages;
  mapping(address => uint256) counts;

	function send(address _to, Message memory _message) external override returns (uint256) {
    require(msg.sender == _message.sender);
    _message.receiver = _to;
    _message.isRead = false;
    _message.isDeleted = false;
    _message.timestamp = block.timestamp;
    Message[] storage queue = messages[_to];
    uint256 index = counts[_to];
    queue[index] = _message;
    counts[_to] = index + 1;
    emit MessageReceived(msg.sender, _to, index);
    return index;
  }

	function count() external view override returns (uint256) {
    return counts[msg.sender];
  }

	function get(uint256 _index) external view override returns (Message memory) {
    return messages[msg.sender][_index];
  }

	function markRead(uint256 _index, bool _isRead) external override returns (Message memory) {
    Message storage message = messages[msg.sender][_index];
    message.isRead = _isRead;
    if (_isRead) {
      emit MessageRead(message.sender, msg.sender, _index);
    }
    return message;
  }

	function markDeleted(uint256 _index, bool _isDeleted) external override returns (Message memory) {
    Message storage message = messages[msg.sender][_index];
    message.isDeleted = _isDeleted;
    return message;
  }
}