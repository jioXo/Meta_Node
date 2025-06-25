// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArrays {
    // 合并两个有序数组
    function mergeSortedArrays(uint256[] memory nums1, uint256[] memory nums2)
        public
        pure
        returns (uint256[] memory)
    {
        uint256 m = nums1.length;
        uint256 n = nums2.length;
        uint256[] memory merged = new uint256[](m + n);
        
        uint256 i = 0; // nums1的指针
        uint256 j = 0; // nums2的指针
        uint256 k = 0; // merged的指针
        
        // 比较两个数组的元素，按升序添加到merged中
        while (i < m && j < n) {
            if (nums1[i] <= nums2[j]) {
                merged[k] = nums1[i];
                i++;
            } else {
                merged[k] = nums2[j];
                j++;
            }
            k++;
        }
        
        // 添加nums1的剩余元素
        while (i < m) {
            merged[k] = nums1[i];
            i++;
            k++;
        }
        
        // 添加nums2的剩余元素
        while (j < n) {
            merged[k] = nums2[j];
            j++;
            k++;
        }
        
        return merged;
    }
}