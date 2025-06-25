// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
### 1.  ✅ 创建一个名为Voting的合约，包含以下功能：
- 一个mapping来存储候选人的得票数
- 一个vote函数，允许用户投票给某个候选人
- 一个getVotes函数，返回某个候选人的得票数
- 一个resetVotes函数，重置所有候选人的得票数
*/
contract voting {
    mapping(address => uint256) ticketS;
    //记录所有参与投票的地址
    address[] public participants;
    mapping(address => bool) public isParticipant; // 标记是否已参与，避免重复添加

    /**
    允许用户投票给某个候选人
    */
    function vote(address _voter, uint256 _amount) external {
        if (!isParticipant[_voter]) {
            participants.push(_voter);
            isParticipant[_voter] = true;
        }
        ticketS[_voter] += _amount;
    }

    /**
    返回某个候选人的得票数
    */
    function getVotes(address _voter) public view returns (uint256) {
        return ticketS[_voter];
    }

    // 将所有人的票数置为0
    function resetAllTickets(uint256 _startIndex, uint256 _batchSize) external {
        uint256 endIndex = _startIndex + _batchSize;
        if (endIndex > participants.length) {
            endIndex = participants.length;
        }

        for (uint256 i = _startIndex; i < endIndex; i++) {
            address voter = participants[i];
            ticketS[voter] = 0;
        }
    }
}
