// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {
    // 二分查找实现
    function search(uint256[] memory nums, uint256 target)
        public
        pure
        returns (int256)
    {
        int256 left = 0;
        int256 right = int256(nums.length) - 1;
        
        while (left <= right) {
            // 防止整数溢出的中间值计算
            int256 mid = left + (right - left) / 2;
            
            if (nums[uint256(mid)] == target) {
                return mid; // 找到目标值，返回索引
            } else if (nums[uint256(mid)] < target) {
                left = mid + 1; // 目标在右半部分
            } else {
                right = mid - 1; // 目标在左半部分
            }
        }
        
        return -1; // 未找到目标值
    }
}