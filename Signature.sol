// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 通过智能合约，验证签名

/*
message to sign 消息签名
1. hash(message) 将消息hash，会有两步hash
2. sign(hash(message), private key) | offchain -> signature 把第一次的消息hash和私钥进行签名。此操作在链下完成，也就是在你自己的本地完成
3. ecrecover(hash(message), signature) == signer 恢复签名，ecrecover会返回签名人地址。如果这个地址等于你想要签名人的地址，就代表消息是正确的
*/

// 验证签名的合约
// 对一个消息进行签名的全部的过程
// 以及对hash(message)和signature的一个恢复过程
// 最后验证恢复的签名地址，和你想要的人地址，是否相同
contract VerifySign {
    // 验证函数
    // 第一个参数：_signer就是你想要的人的地址
    // 第二个参数：_message你要签名以及hash的消息
    // 第三个参数： sign(hash(message), private key) | offchain 签名结果，为不定长的bytes类型
    // 返回参数bool
    function verify(
        address _signer,
        string memory _message,
        bytes memory _sig
    ) external pure returns (bool) {
        // 第一步消息hash
        bytes32 messageHash = getMessageHash(_message);

        // 第二步消息hash
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        // ecrecover(signature, signature) == signer
        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function getMessageHash(string memory _message)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash)
        public
        pure
        returns (bytes32)
    {
        return
            keccak256(
                abi.encodePacked(
                    // 以太坊消息签名的专用前缀字符串
                    // \x19：一个特殊的字节值，用来标识这是以太坊签名的消息。
                    // Ethereum Signed Message:：一个固定的字符串，表明这是一个以太坊签名的消息。
                    // \n32：表示接下来的消息哈希长度是 32 字节。
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig)
        public
        pure
        returns (address)
    {
        // _sig：它是消息签名的结果。具体来说是ECDSA算法得来的签名
        // 而_sig是由r, s, v三部分组成
        // _split这个函数的作用，就是来获取r, s, v
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);

        // ecrecover函数：从签名中，用来恢复签署者的地址，就需要用到r, s, v
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig)
        internal
        pure
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        // _sig.lenght以字节为单位返回长度
        // bytes32 + bytes32 + uint8 = 65
        require(_sig.length == 65, "Invalid signature length");

        // 內联汇编
        assembly {
            // add(_sig, 32) 将指针移动要_sig的第33个字节位置
            // 为什么从第33个字节开始读取。solidity中,bytes类型数据，前32个字节存储的是_sig的长度
            // mload(add(_sig, 32)) 从该位置读取32个字节
            r := mload(add(_sig, 32))

            // 记得从第65个字节开始读取
            s := mload(add(_sig, 64))

            // 读取32个字节中的第一个字节
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}

// ethereum.enable()

// ethereum.request({method: "personal_sign", params: [account, hash]})

// message = "secret message"
