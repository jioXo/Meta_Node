pragma solidity ^0.8.0;

contract RomanToInteger {
    // 罗马数字转整数
    function romanToInt(string memory s) public pure returns (uint256) {
        bytes memory roman = bytes(s);
        uint256 result = 0;
        
        for (uint256 i = 0; i < roman.length; i++) {
            uint256 current = charToValue(roman[i]);
            
            // 检查是否有下一个字符
            if (i + 1 < roman.length) {
                uint256 next = charToValue(roman[i + 1]);
                
                // 如果当前字符的值小于下一个字符的值，则为特殊组合
                if (current < next) {
                    result += next - current;
                    i++; // 跳过下一个字符，因为已经处理过了
                    continue;
                }
            }
            
            // 普通情况，直接累加当前字符的值
            result += current;
        }
        
        return result;
    }
    
    // 辅助函数：将单个罗马字符转换为数值
    function charToValue(bytes1 c) private pure returns (uint256) {
        if (c == bytes1('I')) return 1;
        if (c == bytes1('V')) return 5;
        if (c == bytes1('X')) return 10;
        if (c == bytes1('L')) return 50;
        if (c == bytes1('C')) return 100;
        if (c == bytes1('D')) return 500;
        if (c == bytes1('M')) return 1000;
        
        revert("Invalid Roman numeral character");
    }
}