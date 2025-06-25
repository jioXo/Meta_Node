// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
✅ 反转字符串 (Reverse String)
题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
*/
contract ReverseStr {
  // 反转字符串函数
    function reverseString(string memory _str) public pure returns (string memory) {
        bytes memory strBytes = bytes(_str);
        uint256 length = strBytes.length;
        
        // 创建新的bytes数组存储反转结果
        bytes memory reversedBytes = new bytes(length);
        
        // 反转字节顺序
        for (uint256 i = 0; i < length; i++) {
            reversedBytes[i] = strBytes[length - 1 - i];
        }
        
        // 转换回字符串返回
        return string(reversedBytes);
    }
}
