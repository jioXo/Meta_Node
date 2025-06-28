// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
### ✅ 作业2：在测试网上发行一个图文并茂的 NFT
任务目标
1. 使用 Solidity 编写一个符合 ERC721 标准的 NFT 合约。
2. 将图文数据上传到 IPFS，生成元数据链接。
3. 将合约部署到以太坊测试网（如 Goerli 或 Sepolia）。
4. 铸造 NFT 并在测试网环境中查看。
任务步骤
1. 编写 NFT 合约
  - 使用 OpenZeppelin 的 ERC721 库编写一个 NFT 合约。
  - 合约应包含以下功能：
  - 构造函数：设置 NFT 的名称和符号。
  - mintNFT 函数：允许用户铸造 NFT，并关联元数据链接（tokenURI）。
  - 在 Remix IDE 中编译合约。
2. 准备图文数据
  - 准备一张图片，并将其上传到 IPFS（可以使用 Pinata 或其他工具）。
  - 创建一个 JSON 文件，描述 NFT 的属性（如名称、描述、图片链接等）。
  - 将 JSON 文件上传到 IPFS，获取元数据链接。
  - JSON文件参考 https://docs.opensea.io/docs/metadata-standards
3. 部署合约到测试网
  - 在 Remix IDE 中连接 MetaMask，并确保 MetaMask 连接到 Goerli 或 Sepolia 测试网。
  - 部署 NFT 合约到测试网，并记录合约地址。
4. 铸造 NFT
  - 使用 mintNFT 函数铸造 NFT：
  - 在 recipient 字段中输入你的钱包地址。
  - 在 tokenURI 字段中输入元数据的 IPFS 链接。
  - 在 MetaMask 中确认交易。
5. 查看 NFT
  - 打开 OpenSea 测试网 或 Etherscan 测试网。
  - 连接你的钱包，查看你铸造的 NFT。
*/
contract NFTtoken is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    //构造函数：设置 NFT 的名称和符号。
    constructor(string memory name, string memory symbol)
        ERC721(name, symbol) // 显式传递参数给父合约,这个和Java不一样的是在父函数构造放在函数体外面
        Ownable(msg.sender)
    {}

/**
允许用户铸造 NFT，并关联元数据链接（tokenURI）
钱包地址：0xc7B9f558ad5AA41cfcE42812F51fa3858BDb42Eb
tokenURI:"ipfs://QmSZQXPDD7eCeeW92bDaqme6d77Ci6JAyCyNfcXrJqPdPu" ;
pinata_json:ipfs:bafkreib6egofz6e5m4mgkizdqvwrmk7ncilftlrbhti4o6e5rynfcz66sy
*/
    function mintNFT(address _recipient, string memory _tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        //_tokenIds +1
        _tokenIds.increment();
        //返回id
        uint256 newItemId = _tokenIds.current();
        //_recipient：这是接收新代币的账户地址。
        //newItemId：对于 ERC721 或者 ERC1155 类型的代币，这个参数代表新创建代币的唯一标识符。
        _mint(_recipient, newItemId);
        _setTokenURI(newItemId, _tokenURI); // 设置元数据链接
        return newItemId;
    }

    // 必须重写tokenURI函数，因为ERC721URIStorage覆盖了它
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
