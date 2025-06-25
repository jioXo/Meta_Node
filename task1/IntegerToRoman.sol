pragma solidity ^0.8.0;

contract IntegerToRoman {
    // 整数转罗马数字
    function intToRoman(uint256 num) public pure returns (string memory) {
        require(num > 0 && num < 4000, "Number must be between 1 and 3999");
        
        // 初始化uint16动态数组
        uint16[] memory temp = new uint16[](13);
        temp[0] = 1000;
        temp[1] = 900;
        temp[2] = 500;
        temp[3] = 400;
        temp[4] = 100;
        temp[5] = 90;
        temp[6] = 50;
        temp[7] = 40;
        temp[8] = 10;
        temp[9] = 9;
        temp[10] = 5;
        temp[11] = 4;
        temp[12] = 1;
        
        // 转换为uint256[]
        uint256[] memory values = new uint256[](temp.length);
        for (uint256 i = 0; i < temp.length; i++) {
            values[i] = temp[i];
        }
        
        // 初始化string动态数组
        string[] memory symbols = new string[](13);
        symbols[0] = "M";
        symbols[1] = "CM";
        symbols[2] = "D";
        symbols[3] = "CD";
        symbols[4] = "C";
        symbols[5] = "XC";
        symbols[6] = "L";
        symbols[7] = "XL";
        symbols[8] = "X";
        symbols[9] = "IX";
        symbols[10] = "V";
        symbols[11] = "IV";
        symbols[12] = "I";
        
        bytes memory result = new bytes(16); // 最大3999需要15个字符
        uint256 ptr = 0;
        
        for (uint256 i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                bytes memory symbol = bytes(symbols[i]);
                for (uint256 j = 0; j < symbol.length; j++) {
                    result[ptr] = symbol[j];
                    ptr++;
                }
                num -= values[i];
            }
        }
        
        // 截取实际使用的长度
        bytes memory finalResult = new bytes(ptr);
        for (uint256 i = 0; i < ptr; i++) {
            finalResult[i] = result[i];
        }
        
        return string(finalResult);
    }
}