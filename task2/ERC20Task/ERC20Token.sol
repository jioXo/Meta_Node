// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
import "./IERC20.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
/**
作业 1：ERC20 代币
任务：参考 openzeppelin-contracts/contracts/token/ERC20/IERC20.sol实现一个简单的 ERC20 代币合约。要求：
合约包含以下标准 ERC20 功能：
balanceOf：查询账户余额。
transfer：转账。
approve 和 transferFrom：授权和代扣转账。
使用 event 记录转账和授权操作。
提供 mint 函数，允许合约所有者增发代币。

0x0498B7c793D7432Cd9dB27fb02fc9cfdBAfA1Fd3
我的账户：0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
0xc7B9f558ad5AA41cfcE42812F51fa3858BDb42Eb

*/
contract  ERC20Token is IERC20{
    using Strings for uint256;
    uint256 private _totalSupply; // 声明_totalSupply变量
     address private _owner; // 合约所有者地址
      constructor() {
        _owner = msg.sender; // 部署者成为初始所有者
    }
    // 存储每个账户的余额
    mapping(address => uint256) private _balances;

    // 存储授权额度：owner -> spender -> 允许的金额
    mapping(address => mapping(address => uint256)) private _allowances;
  // 增发代币（仅所有者可调用）
    function mint(address to, uint256 amount) external onlyOwner {
        // 增加总供应量
        _totalSupply += amount;
        
        // 增加目标地址的余额
        _balances[to] += amount;
        
        // 触发铸造事件（可选，但推荐）
        emit Transfer(address(0), to, amount);
    }
    
    // 修饰器：限制仅所有者调用
    modifier onlyOwner() {
        require(msg.sender == _owner, "Only owner can mint");
        _;
    }
    /**
     * @dev 返回账户`account`所持有的代币数.
     balanceOf：查询账户余额。
     */
    function balanceOf(address account) external  view returns (uint256){
        return _balances[account];
    }
  /**
     * @dev 返回代币总供给.
     */
    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }

      /**
     * @dev 转账 `amount` 单位代币，从调用者账户到另一账户 `to`.
     *
     * 如果成功，返回 `true`.
     *
     * 释放 {Transfer} 事件.
     */
    function transfer(address to, uint256 amount) external returns (bool){
        address sender=msg.sender;

        //检查发送方余额是否够
        require(_balances[sender]>=amount,"fair reason:");

        //更新余额
        _balances[sender]-=amount;
        _balances[to]+=amount;

        //触发事件
        emit Transfer(sender, to, amount);
        return true;
    }

     /**
     * @dev 返回`owner`账户授权给`spender`账户的额度，默认为0。
     *
     * 当{approve} 或 {transferFrom} 被调用时，`allowance`会改变.
     */
    function allowance(address owner, address spender) external view returns (uint256){
        return _allowances[owner][spender];
    }

     /**
     * @dev 调用者账户给`spender`账户授权 `amount`数量代币。
     *
     * 如果成功，返回 `true`.
     *
     * 释放 {Approval} 事件.
     */
    function approve(address spender, uint256 amount) external returns (bool) {
         _allowances[msg.sender][spender] = amount;

         // 触发授权事件
         emit Approval(msg.sender, spender, amount);

        return true;
    }

     /**
     * @dev 通过授权机制，从`from`账户向`to`账户转账`amount`数量代币。转账的部分会从调用者的`allowance`中扣除。
     *
     * 如果成功，返回 `true`.
     *
     * 释放 {Transfer} 事件.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool){
         address spender = msg.sender;
        //判断授权数量是否足够,检查的是from账户对调用者的授权
        // 检查授权额度
        uint256 currentAllowance = _allowances[from][spender];
        require(currentAllowance >= amount, "ERC20: insufficient allowance");

        // 检查from账户余额
         require(_balances[from] >= amount, "ERC20: transfer amount exceeds balance");
        //向to账户转账,from账户减，to账户加
        _balances[from]-=amount;
        _balances[to]+=amount;

        //授权账户减数量
        _allowances[from][to]-=amount;
       // 触发转账事件
         emit Transfer(from, to, amount);
        return true;
    }
    
}