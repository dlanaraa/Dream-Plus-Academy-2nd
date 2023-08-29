## Task 01. 아래 Calculator.sol 컨트랙트를 컴파일한 뒤 Bytecode / Opcodes / ABI 제출
        
``` Javascript
// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Calculator {
    function add(uint256 x1, uint256 y1) external pure returns (uint256 z1) {
        return x1 + y1;
    }
    function sub(uint256 x2, uint256 y2) external pure returns (uint256 z2) {
        return x2 - y2;
    }
}
```
        
- 컴파일러 버전 맞춰주고 컴파일 했더니 탐색기에 새로운 폴더(bin)가 생김
    
    ![Untitled](https://file.notion.so/f/s/c4c72ded-9885-4fd3-8bf6-23b01bdfe224/Untitled.png?id=e5ebf245-5eff-4623-879a-aea123aae171&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=AepbuoZzt9lrK9WwgTksMp8EH8TSqNnD4BIny01_ZsM&downloadName=Untitled.png)
    
<details>
<summary> Bytecode → Calculator.bin </summary>
    <aside>
    👩🏻‍💻 Bytecode

    608060405234801561001057600080fd5b50610111806100206000396000f3fe6080604052348015600f57600080fd5b506004361060325760003560e01c8063771602f7146037578063b67d77c5146058575b600080fd5b604660423660046084565b6067565b60405190815260200160405180910390f35b604660633660046084565b607a565b60006071828460bb565b90505b92915050565b60006071828460cb565b60008060408385031215609657600080fd5b50508035926020909101359150565b634e487b7160e01b600052601160045260246000fd5b80820180821115607457607460a5565b81810381811115607457607460a556fea2646970667358221220896dd6100782593accd1dc2911af46fdd4112c9235f76d527cd7edb0cad2401b64736f6c63430008100033
    </aside>

</details>

<details>
<summary> Opcode → 앞서 구한 Bytecode를 이용하여 Disassembler로 구해줌</summary>
    <aside>
    👩🏻‍💻 Opcode
    
    [0] DUP1<br>
    [2] PUSH1 0x40<br>
    [3] MSTORE<br>
    [4] CALLVALUE<br>
    [5] DUP1<br>
    [6] ISZERO<br>
    [9] PUSH2 0x0010<br>
    [10] JUMPI<br>
    [12] PUSH1 0x00<br>
    [13] DUP1<br>
    [14] REVERT<br>
    [15] JUMPDEST<br>
    [16] POP<br>
    [19] PUSH2 0x0111<br>
    [20] DUP1<br>
    [23] PUSH2 0x0020<br>
    [25] PUSH1 0x00<br>
    [26] CODECOPY<br>
    [28] PUSH1 0x00<br>
    [29] RETURN<br>
    [30] 'fe'(Unknown Opcode)<br>
    [32] PUSH1 0x80<br>
    [34] PUSH1 0x40<br>
    [35] MSTORE<br>
    [36] CALLVALUE<br>
    [37] DUP1<br>
    [38] ISZERO<br>
    [40] PUSH1 0x0f<br>
    [41] JUMPI<br>
    [43] PUSH1 0x00<br>
    [44] DUP1<br>
    [45] REVERT<br>
    [46] JUMPDEST<br>
    [47] POP<br>
    [49] PUSH1 0x04<br>
    [50] CALLDATASIZE<br>
    [51] LT<br>
    [53] PUSH1 0x32<br>
    [54] JUMPI<br>
    [56] PUSH1 0x00<br>
    [57] CALLDATALOAD<br>
    [59] PUSH1 0xe0<br>
    [60] SHR<br>
    [61] DUP1<br>
    [66] PUSH4 0x771602f7<br>
    [67] EQ<br>
    [69] PUSH1 0x37<br>
    [70] JUMPI<br>
    [71] DUP1<br>
    [76] PUSH4 0xb67d77c5<br>
    [77] EQ<br>
    [79] PUSH1 0x58<br>
    [80] JUMPI<br>
    [81] JUMPDEST<br>
    [83] PUSH1 0x00<br>
    [84] DUP1<br>
    [85] REVERT<br>
    [86] JUMPDEST<br>
    [88] PUSH1 0x46<br>
    [90] PUSH1 0x42<br>
    [91] CALLDATASIZE<br>
    [93] PUSH1 0x04<br>
    [95] PUSH1 0x84<br>
    [96] JUMP<br>
    [97] JUMPDEST<br>
    [99] PUSH1 0x67<br>
    [100] JUMP<br>
    [101] JUMPDEST<br>
    [103] PUSH1 0x40<br>
    [104] MLOAD<br>
    [105] SWAP1<br>
    [106] DUP2<br>
    [107] MSTORE<br>
    [109] PUSH1 0x20<br>
    [110] ADD<br>
    [112] PUSH1 0x40<br>
    [113] MLOAD<br>
    [114] DUP1<br>
    [115] SWAP2<br>
    [116] SUB<br>
    [117] SWAP1<br>
    [118] RETURN<br>
    [119] JUMPDEST<br>
    [121] PUSH1 0x46<br>
    [123] PUSH1 0x63<br>
    [124] CALLDATASIZE<br>
    [126] PUSH1 0x04<br>
    [128] PUSH1 0x84<br>
    [129] JUMP<br>
    [130] JUMPDEST<br>
    [132] PUSH1 0x7a<br>
    [133] JUMP<br>
    [134] JUMPDEST<br>
    [136] PUSH1 0x00<br>
    [138] PUSH1 0x71<br>
    [139] DUP3<br>
    [140] DUP5<br>
    [142] PUSH1 0xbb<br>
    [143] JUMP<br>
    [144] JUMPDEST<br>
    [145] SWAP1<br>
    [146] POP<br>
    [147] JUMPDEST<br>
    [148] SWAP3<br>
    [149] SWAP2<br>
    [150] POP<br>
    [151] POP<br>
    [152] JUMP<br>
    [153] JUMPDEST<br>
    [155] PUSH1 0x00<br>
    [157] PUSH1 0x71<br>
    [158] DUP3<br>
    [159] DUP5<br>
    [161] PUSH1 0xcb<br>
    [162] JUMP<br>
    [163] JUMPDEST<br>
    [165] PUSH1 0x00<br>
    [166] DUP1<br>
    [168] PUSH1 0x40<br>
    [169] DUP4<br>
    [170] DUP6<br>
    [171] SUB<br>
    [172] SLT<br>
    [173] ISZERO<br>
    [175] PUSH1 0x96<br>
    [176] JUMPI<br>
    [178] PUSH1 0x00<br>
    [179] DUP1<br>
    [180] REVERT<br>
    [181] JUMPDEST<br>
    [182] POP<br>
    [183] POP<br>
    [184] DUP1<br>
    [185] CALLDATALOAD<br>
    [186] SWAP3<br>
    [188] PUSH1 0x20<br>
    [189] SWAP1<br>
    [190] SWAP2<br>
    [191] ADD<br>
    [192] CALLDATALOAD<br>
    [193] SWAP2<br>
    [194] POP<br>
    [195] JUMP<br>
    [196] JUMPDEST<br>
    [201] PUSH4 0x4e487b71<br>
    [203] PUSH1 0xe0<br>
    [204] SHL<br>
    [206] PUSH1 0x00<br>
    [207] MSTORE<br>
    [209] PUSH1 0x11<br>
    [211] PUSH1 0x04<br>
    [212] MSTORE<br>
    [214] PUSH1 0x24<br>
    [216] PUSH1 0x00<br>
    [217] REVERT<br>
    [218] JUMPDEST<br>
    [219] DUP1<br>
    [220] DUP3<br>
    [221] ADD<br>
    [222] DUP1<br>
    [223] DUP3<br>
    [224] GT<br>
    [225] ISZERO<br>
    [227] PUSH1 0x74<br>
    [228] JUMPI<br>
    [230] PUSH1 0x74<br>
    [232] PUSH1 0xa5<br>
    [233] JUMP<br>
    [234] JUMPDEST<br>
    [235] DUP2<br>
    [236] DUP2<br>
    [237] SUB<br>
    [238] DUP2<br>
    [239] DUP2<br>
    [240] GT<br>
    [241] ISZERO<br>
    [243] PUSH1 0x74<br>
    [244] JUMPI<br>
    [246] PUSH1 0x74<br>
    [248] PUSH1 0xa5<br>
    [249] JUMP<br>
    [250] 'fe'(Unknown Opcode)<br>
    [251] LOG2<br>
    [257] PUSH5 0x6970667358<br>
    [258] '22'(Unknown Opcode)<br>
    [259] SLT<br>
    [260] SHA3<br>
    [261] DUP10<br>
    [276] PUSH14 0xd6100782593accd1dc2911af46fd<br>
    [277] 'd4'(Unknown Opcode)<br>
    [278] GT<br>
    [279] '2c'(Unknown Opcode)<br>
    [280] SWAP3<br>
    [281] CALLDATALOAD<br>
    [282] 'f7'(Unknown Opcode)<br>
    [297] PUSH14 0x527cd7edb0cad2401b64736f6c63<br>
    [298] NUMBER<br>
    [299] STOP<br>
    [300] ADDMOD<br>
    [301] LT<br>
    [302] STOP<br>
    [303] CALLER<br>
</aside>
    
etherscan opcode-tool : [etherscan opcode-tool](https://etherscan.io/opcode-tool)
</details>

<details>
<summary> ABI → Calculator.abi</summary>
    <aside>
    👩🏻‍💻 ABI

    [{"inputs":[{"internalType":"uint256","name":"x1","type":"uint256"},{"internalType":"uint256","name":"y1","type":"uint256"}],"name":"add","outputs":[{"internalType":"uint256","name":"z1","type":"uint256"}],"stateMutability":"pure","type":"function"},{"inputs":[{"internalType":"uint256","name":"x2","type":"uint256"},{"internalType":"uint256","name":"y2","type":"uint256"}],"name":"sub","outputs":[{"internalType":"uint256","name":"z2","type":"uint256"}],"stateMutability":"pure","type":"function"}]
</aside>    
</details>
<br>

## Task 02. 함수 선언 정보를 입력 받고, Solidity function signature를 반환하는 코드 및 실행 결과 스크린샷을 함께 제출
        
```python
from Crypto.Hash import keccak

# 값 입력 받기
print("[Input]")
msg = input()[:-1]

# "("를 기준으로 함수 이름과 파라미터 부분을 구분해줌
func = msg.split('(')[0]
# 파라미터 부분도 ,를 이용해서 첫 번째 파라미터, 두 번째 파라미터 .... n번째 파라미터를 각각 구분해줌
argv = msg.split('(')[1].split(',')
# 파라미터 타입을 저장할 배열 선언
type = []

# 파라미터 타입과 파라미터 이름이 함께 입력 받은 경우와 파라미터 타입만 입력 받은 경우를 구분해줌
# 함께 입력 받은 경우 -> add(uint256 a, uint256 b)
if (len(argv[0].split(' ')) == 2):
    for i in range(0, len(argv)):
        # 파라미터 값을 또 공백을 기준으로 분리하면 항상 0번째 인덱스에는 파라미터 타입이 오니까 이 값을 공백 제거하고 type에 넣어줌
        type.append(argv[i].strip().split(' ')[0])

# 파라미터 타입만 입력 받은 경우 -> add(uint, uint)
if (len(argv[0].split(' ')) == 1):
    for i in range(0, len(argv)):
        # 파라미터 값을 공백 제거하고 type에 넣어줌
        type.append(argv[i].strip())

# 다 쪼개진 애들을 합쳐주는 작업 -> func(type, type, ..., type)형태로 만들기
res = func + "("
for i in range(0, len(type)):
    # uint와 int는 각각 uint256, int256를 의미하므로 값을 uint256, int256으로 변경해주는 작업 수행
    if (type[i] == "uint"):
        type[i] = "uint256"
    if (type[i] == "int"):
        type[i] = "int256"
    res += type[i] + ","
# 마지막에 붙은 "," 제거
res = res[:-1]
res += ")"

#완성된 문자열을 keccak으로 암호화
k = keccak.new(digest_bits=256)
k.update(res.encode('utf-8'))

# keccak으로 암호화된 문자를 앞에 4바이트만 잘라오고, 앞에 prefix 붙여주기
print("[Output]")
print("0x"+k.hexdigest()[:8])
```

### result
    
![Untitled](https://file.notion.so/f/s/67115c99-74eb-439c-b187-d165d9edd712/Untitled.png?id=02535cb2-8ed6-48c9-9365-55b32a410131&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=hwTrJtBIeSt3Z_jAAWluzS-cxmq2g3kBJNkOOhf9OV4&downloadName=Untitled.png)

<br>

## Task 03. 아래 ExerciseTask 컨트랙트의 각 함수 호출시, 인자가 타입별로 어떻게 변환되어 calldata로 전달 되는지 알아보고 아래 [제출 양식] 에 따라 제출
        
``` solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract ExerciseTask {
    function func1(bool argv) external pure {}
    function func2(uint256 argv) external pure {}
    function func3(bytes memory argv) external pure {}
}
```

### func1(bool argv)
    
    
| 입력값 | Serialized value |
| --- | --- |
| True | 0x0000000000000000000000000000000000000000000000000000000000000001 |
| False | 0x0000000000000000000000000000000000000000000000000000000000000000 |
- Serialized value 구조
    - True → 1 → 0x1 → 0x0000000000000000000000000000000000000000000000000000000000000001
    - False → 0 → 0x0 → 0x0000000000000000000000000000000000000000000000000000000000000000
- 길이 : 32bytes
- 다른 타입들과 다른 점
    - Static Type → Fixed length parameter
    - 파라미터를 16진수 형태로 변환 → 32bytes 크기에 맞춰 0으로 패딩해줌(왼쪽에!)

### func2(uint256 argv)
| 입력값 | Serialized value |
| --- | --- |
| 0 | 0x0000000000000000000000000000000000000000000000000000000000000000 |
| 115792089237316195423570985008687907853269984665640564039457584007913129639935 | 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff |
| 29515630589904128245223976570842015727304113738300535931626442982409229123905 | 0x4141414141414141414141414141414141414141414141414141414141414141 |
- Serialized value 구조
    - 0 → 0x0000000000000000000000000000000000000000000000000000000000000000
    - 115792089237316195423570985008687907853269984665640564039457584007913129639935 → 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    - 29515630589904128245223976570842015727304113738300535931626442982409229123905 → 0x4141414141414141414141414141414141414141414141414141414141414141
- 길이 : 32bytes
- 다른 타입들과 다른 점
    - Static Type → Fixed length parameter
    - Static Type이지만 func1(bool argv)와 달리 값이 1이더라도 0으로 패딩해야 256비트(32바이트)가 되기 때문에 32바이트 패딩 과정이 필요 없음

### func3(bytes memory argv)
    
| 입력값 | Serialized value |
| --- | --- |
| 0x00 | 0x000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000 |
| 0x1234 | 0x000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000021234000000000000000000000000000000000000000000000000000000000000 |
| 0xBBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA | 0x00000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000021bbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000 |
- Serialized value 구조
    - 0x00
        - 0x0000000000000000000000000000000000000000000000000000000000000020 : offset
        - 0x0000000000000000000000000000000000000000000000000000000000000001 : “0x00”의 길이 → 1byte
        - 0x0000000000000000000000000000000000000000000000000000000000000000 : “0x00”를 인코딩한 값
    - 0x1234
        - 0x0000000000000000000000000000000000000000000000000000000000000020 : offset
        - 0x0000000000000000000000000000000000000000000000000000000000000002 : “0x1234”의 길이 → 2bytes
        - 0x1234000000000000000000000000000000000000000000000000000000000000 : “0x1234”를 인코딩한 값
    - 0xBBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        - 0x0000000000000000000000000000000000000000000000000000000000000020 : offset → 32bytes
        - 0x0000000000000000000000000000000000000000000000000000000000000021 : “0xBBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA”의 길이 → 33bytes
        - 0xbbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000 : “0xBBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA”를 인코딩한 값
- 길이
    - 고정되어 있지 않음
    - offset(32bytes) + length(32bytes) + encoded argument(dynamic)
        - 0x00, 0x1234 → 32 + 32 + 32 = 96bytes
        - 0xBBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA → 32 + 32 + 64 = 128bytes
- 다른 타입들과 다른 점
    - Dynamic Type → Dynamic parameter
    - 파라미터의 길이가 고정되어 있는 것이 아니기 때문에 고정 길이의 오프셋을 이용하여 먼저 공간을 만들어주고 실제 위치에 대한 오프셋을 기록한 뒤 인코딩해줌
    - 인코딩할 때는 32bytes 크기를 맞춰주면서 인코딩하게 되는데, 값의 왼쪽에 패딩을 해줬던 bool과는 달리 값의 오른쪽에 패딩을 해주게 됨
    - 세번째 예시의 경우 인자값 자체가 32bytes보다 큰 값이기 때문에(33bytes) 64bytes에 맞춰서 패딩

Reference : [Parameter Encoding and Decoding](https://developers.tron.network/docs/parameter-encoding-and-decoding)

<br>

## Task 04. ERC-721과 관련해 발생하였던 보안 사건/사고를 1개 이상 조사하고, 이를 완화할 수 있는 방법 작성 (Copy & Paste 금지)
- A HypeBears NFT를 대상으로 한 공격 사례
    - ERC721의 _safeMint 함수를 이용한 re-entrancy attack
    - 공격 트랜잭션 : [0xfa97c3476aa8aeac662dae0cc3f0d3da48472ff4e7c55d0e305901ec37a2f704](https://etherscan.io/tx/0xfa97c3476aa8aeac662dae0cc3f0d3da48472ff4e7c55d0e305901ec37a2f704)
- 취약 코드 분석 내용

    ```solidity
    function _safeMint(
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal virtual {
        _mint(to, tokenId);
        require(
            _checkOnERC721Receive(address(0), to, tokenId, _data),
            "ERC721: transfer to non ERC721Receiver implementer"
            );
    }
    ```
    - _safeMint 함수에서는 to가 smart contract일 경우 _checkOnERC721Receive함수를 구현해 줘야 함

    <details>
    <summary> _checkOnERC721Received </summary>
        
    ```solidity
    function _checkOnERC721Received(
            address from,
            address to,
            uint256 tokenId,
            bytes memory data
        ) private returns (bool) {
            if (to.isContract()) {
                try IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, data) returns (bytes4 retval) {
                    return retval == IERC721Receiver.onERC721Received.selector;
                } catch (bytes memory reason) {
                    if (reason.length == 0) {
                        revert("ERC721: transfer to non ERC721Receiver implementer");
                    } else {
                        /// @solidity memory-safe-assembly
                        assembly {
                            revert(add(32, reason), mload(reason))
                        }
                    }
                }
            } else {
                return true;
            }
        }
    ```
        
    - isContract → to가 contract인지 확인
    - try → ERC721 토큰을 transfer할 수 있는지 확인
        - IERC721Receiver(to).onERC721Received함수에서 토큰을 transfer할 수 있으면 IERC721Receiver.onERC721Received.selector를 return해줌
    - _checkOnERC721Received 정리
        - to가 smart contract일 경우 _checkOnERC721Receive를 통해 ERC 토큰을 trasnfer할 수 있는지 확인한다. 이는 ERC721 토큰을 처리할 수 없는 contract에 보냈을 때 contract에서 토큰을 받는 것은 되는데 이걸 다른 곳으로 전송하는게 불가능해 conttract에 nft가 locking 되는 문제를 해결하기 위한 것이다. 즉, ERC721 토큰을 처리할 수 없는 contract에 NFT가 발행되는 것을 방지하기 위해 사용된다.
    </details>

    - 이 때, 공격자는 _safeMint 내부에서 호출되는 _CheckOnERC721Received에서 호출되는 onERC721Received를 이용하여 re-entrancy attack을 수행할 수 있게 됨
        
        ```
        onERC721Received(address operator, address from, uint256 tokenId, bytes data)
        ```
        
        - onERC721Received 함수는 from을 통해 contract에 토큰이 transfer될 때마다 호출됨
    - HypeBears에서는 onERC721Receive 콜백으로 mintNFT를 다시 호출할 수 있음
    - mintNFT → NFT를 mint해주는 함수
        
        ```solidity
        function mintNFT(uint256 _numOfTokens, bytes memory _signature) public payable {
                require(mintActive, 'Not active');
                require(_numOfTokens <= mintLimit, "Can't mint more than limit per tx");
                require(mintPrice.mul(_numOfTokens) <= msg.value, "Insufficient payable value");
                require(totalSupply().add(_numOfTokens).add(partnerMintAmount) <= TOTAL_NFT, "Can't mint more than 10000");
                (bool success, string memory reason) = canMint(msg.sender, _signature);
                require(success, reason);
        
                for(uint i = 0; i < _numOfTokens; i++) {
                    _safeMint(msg.sender, totalSupply() + 1);
                }
                addressMinted[msg.sender] = true;
            }
        ```
        
        <details>
        <summary> canMint함수 </summary>
            
        ```solidity
        function canMint(address _address, bytes memory _signature) public view returns (bool, string memory) {
                if (!whitelist[_address]) {
                    bytes32 hash = keccak256(abi.encodePacked(whitelistSigner, _address));
                    bytes32 messageHash = hash.toEthSignedMessageHash();
        
                    address signer = messageHash.recover(_signature);
        
                    if (signer != whitelistSigner) {
                        return (false, "Invalid signature");
                    }
                }
        
                if (addressMinted[_address]) {
                    return (false, "Already withdrawn");
                }
                return (true, "");
            }
        ```
            
        - whitelist에 등록된 주소가 있으면 keccak256으로 해시값을 만들어주고, 해시값을 인자로 하는  toEthSignedMessage를 호출하여 signature를 이더리움 signature로 전환해줌
        - signature에서 signer address를 recover한 뒤 해당 값이 signer와 일치하는지 확인
        - 해당 addressMinted가 true인지 확인 → mintNFT에서 mint 성공하면 addressMinted를 true로 바꿈
        - NFT를 한 번만 mint할 수 있도록 설정해둔 것 같음
        </details>

- 정리하면, mintNFT에서 canMint로 addressMinted 값이 True인지 False인지 확인하고 그 뒤에 _safeMint를 해주는데, _safeMint 내부에 있는 _checkOnERC721Receive에서 onERC721Received를 호출하고 있고, onERC721Received는 콜백으로 mintNFT를 다시 호출할 수 있으니까 mintNFT  반복해서 호출함으로써 토큰을 계속해서 발행할 수 있게 됨
- 완화 방법 (실제 사용하고 있는 코드 혹은 방법론) → 아직 이해하는 중 ..
    - [ERC721의 _mint 함수 사용](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/8f70c8867e31d2d2f212ecea079b1f1afecb0440/contracts/token/ERC721/ERC721.sol#L280)
        
    - [ReentrancyGuard 사용](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/ReentrancyGuard.sol)
        
- Reference
    
    - [When “SafeMint” Becomes Unsafe: Lessons from the HypeBears Security Incident](https://blocksecteam.medium.com/when-safemint-becomes-unsafe-lessons-from-the-hypebears-security-incident-2965209bda2a)
    
    - [etherscan](https://etherscan.io/address/0x14e0a1f310e2b7e321c91f58847e98b8c802f6ef#code)
    
    - [ERC 721 - OpenZeppelin Docs](https://docs.openzeppelin.com/contracts/3.x/api/token/erc721)
<br>

## Task 05. Compound governance에 전체적인 동작 방식을 학습하고, timelock api 조사
### Compound Governance
- Compound
    - DeFi 프로그램 → DEX
    - 스마트컨트랙트 → 예금, 대출, 거래내역, 이자율 등등 기록
- COMP
    <details>
    <summary> contract source code </summary>

    ```solidity
    /**
    *Submitted for verification at Etherscan.io on 2020-03-04
    */

    pragma solidity ^0.5.16;
    pragma experimental ABIEncoderV2;

    contract Comp {
        /// @notice EIP-20 token name for this token
        string public constant name = "Compound";

        /// @notice EIP-20 token symbol for this token
        string public constant symbol = "COMP";

        /// @notice EIP-20 token decimals for this token
        uint8 public constant decimals = 18;

        /// @notice Total number of tokens in circulation
        uint public constant totalSupply = 10000000e18; // 10 million Comp

        /// @notice Allowance amounts on behalf of others
        mapping (address => mapping (address => uint96)) internal allowances;

        /// @notice Official record of token balances for each account
        mapping (address => uint96) internal balances;

        /// @notice A record of each accounts delegate
        mapping (address => address) public delegates;

        /// @notice A checkpoint for marking number of votes from a given block
        struct Checkpoint {
            uint32 fromBlock;
            uint96 votes;
        }

        /// @notice A record of votes checkpoints for each account, by index
        mapping (address => mapping (uint32 => Checkpoint)) public checkpoints;

        /// @notice The number of checkpoints for each account
        mapping (address => uint32) public numCheckpoints;

        /// @notice The EIP-712 typehash for the contract's domain
        bytes32 public constant DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,uint256 chainId,address verifyingContract)");

        /// @notice The EIP-712 typehash for the delegation struct used by the contract
        bytes32 public constant DELEGATION_TYPEHASH = keccak256("Delegation(address delegatee,uint256 nonce,uint256 expiry)");

        /// @notice A record of states for signing / validating signatures
        mapping (address => uint) public nonces;

        /// @notice An event thats emitted when an account changes its delegate
        event DelegateChanged(address indexed delegator, address indexed fromDelegate, address indexed toDelegate);

        /// @notice An event thats emitted when a delegate account's vote balance changes
        event DelegateVotesChanged(address indexed delegate, uint previousBalance, uint newBalance);

        /// @notice The standard EIP-20 transfer event
        event Transfer(address indexed from, address indexed to, uint256 amount);

        /// @notice The standard EIP-20 approval event
        event Approval(address indexed owner, address indexed spender, uint256 amount);

        /**
        * @notice Construct a new Comp token
        * @param account The initial account to grant all the tokens
        */
        constructor(address account) public {
            balances[account] = uint96(totalSupply);
            emit Transfer(address(0), account, totalSupply);
        }

        /**
        * @notice Get the number of tokens `spender` is approved to spend on behalf of `account`
        * @param account The address of the account holding the funds
        * @param spender The address of the account spending the funds
        * @return The number of tokens approved
        */
        function allowance(address account, address spender) external view returns (uint) {
            return allowances[account][spender];
        }

        /**
        * @notice Approve `spender` to transfer up to `amount` from `src`
        * @dev This will overwrite the approval amount for `spender`
        *  and is subject to issues noted [here](https://eips.ethereum.org/EIPS/eip-20#approve)
        * @param spender The address of the account which may transfer tokens
        * @param rawAmount The number of tokens that are approved (2^256-1 means infinite)
        * @return Whether or not the approval succeeded
        */
        function approve(address spender, uint rawAmount) external returns (bool) {
            uint96 amount;
            if (rawAmount == uint(-1)) {
                amount = uint96(-1);
            } else {
                amount = safe96(rawAmount, "Comp::approve: amount exceeds 96 bits");
            }

            allowances[msg.sender][spender] = amount;

            emit Approval(msg.sender, spender, amount);
            return true;
        }

        /**
        * @notice Get the number of tokens held by the `account`
        * @param account The address of the account to get the balance of
        * @return The number of tokens held
        */
        function balanceOf(address account) external view returns (uint) {
            return balances[account];
        }

        /**
        * @notice Transfer `amount` tokens from `msg.sender` to `dst`
        * @param dst The address of the destination account
        * @param rawAmount The number of tokens to transfer
        * @return Whether or not the transfer succeeded
        */
        function transfer(address dst, uint rawAmount) external returns (bool) {
            uint96 amount = safe96(rawAmount, "Comp::transfer: amount exceeds 96 bits");
            _transferTokens(msg.sender, dst, amount);
            return true;
        }

        /**
        * @notice Transfer `amount` tokens from `src` to `dst`
        * @param src The address of the source account
        * @param dst The address of the destination account
        * @param rawAmount The number of tokens to transfer
        * @return Whether or not the transfer succeeded
        */
        function transferFrom(address src, address dst, uint rawAmount) external returns (bool) {
            address spender = msg.sender;
            uint96 spenderAllowance = allowances[src][spender];
            uint96 amount = safe96(rawAmount, "Comp::approve: amount exceeds 96 bits");

            if (spender != src && spenderAllowance != uint96(-1)) {
                uint96 newAllowance = sub96(spenderAllowance, amount, "Comp::transferFrom: transfer amount exceeds spender allowance");
                allowances[src][spender] = newAllowance;

                emit Approval(src, spender, newAllowance);
            }

            _transferTokens(src, dst, amount);
            return true;
        }

        /**
        * @notice Delegate votes from `msg.sender` to `delegatee`
        * @param delegatee The address to delegate votes to
        */
        function delegate(address delegatee) public {
            return _delegate(msg.sender, delegatee);
        }

        /**
        * @notice Delegates votes from signatory to `delegatee`
        * @param delegatee The address to delegate votes to
        * @param nonce The contract state required to match the signature
        * @param expiry The time at which to expire the signature
        * @param v The recovery byte of the signature
        * @param r Half of the ECDSA signature pair
        * @param s Half of the ECDSA signature pair
        */
        function delegateBySig(address delegatee, uint nonce, uint expiry, uint8 v, bytes32 r, bytes32 s) public {
            bytes32 domainSeparator = keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), getChainId(), address(this)));
            bytes32 structHash = keccak256(abi.encode(DELEGATION_TYPEHASH, delegatee, nonce, expiry));
            bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
            address signatory = ecrecover(digest, v, r, s);
            require(signatory != address(0), "Comp::delegateBySig: invalid signature");
            require(nonce == nonces[signatory]++, "Comp::delegateBySig: invalid nonce");
            require(now <= expiry, "Comp::delegateBySig: signature expired");
            return _delegate(signatory, delegatee);
        }

        /**
        * @notice Gets the current votes balance for `account`
        * @param account The address to get votes balance
        * @return The number of current votes for `account`
        */
        function getCurrentVotes(address account) external view returns (uint96) {
            uint32 nCheckpoints = numCheckpoints[account];
            return nCheckpoints > 0 ? checkpoints[account][nCheckpoints - 1].votes : 0;
        }

        /**
        * @notice Determine the prior number of votes for an account as of a block number
        * @dev Block number must be a finalized block or else this function will revert to prevent misinformation.
        * @param account The address of the account to check
        * @param blockNumber The block number to get the vote balance at
        * @return The number of votes the account had as of the given block
        */
        function getPriorVotes(address account, uint blockNumber) public view returns (uint96) {
            require(blockNumber < block.number, "Comp::getPriorVotes: not yet determined");

            uint32 nCheckpoints = numCheckpoints[account];
            if (nCheckpoints == 0) {
                return 0;
            }

            // First check most recent balance
            if (checkpoints[account][nCheckpoints - 1].fromBlock <= blockNumber) {
                return checkpoints[account][nCheckpoints - 1].votes;
            }

            // Next check implicit zero balance
            if (checkpoints[account][0].fromBlock > blockNumber) {
                return 0;
            }

            uint32 lower = 0;
            uint32 upper = nCheckpoints - 1;
            while (upper > lower) {
                uint32 center = upper - (upper - lower) / 2; // ceil, avoiding overflow
                Checkpoint memory cp = checkpoints[account][center];
                if (cp.fromBlock == blockNumber) {
                    return cp.votes;
                } else if (cp.fromBlock < blockNumber) {
                    lower = center;
                } else {
                    upper = center - 1;
                }
            }
            return checkpoints[account][lower].votes;
        }

        function _delegate(address delegator, address delegatee) internal {
            address currentDelegate = delegates[delegator];
            uint96 delegatorBalance = balances[delegator];
            delegates[delegator] = delegatee;

            emit DelegateChanged(delegator, currentDelegate, delegatee);

            _moveDelegates(currentDelegate, delegatee, delegatorBalance);
        }

        function _transferTokens(address src, address dst, uint96 amount) internal {
            require(src != address(0), "Comp::_transferTokens: cannot transfer from the zero address");
            require(dst != address(0), "Comp::_transferTokens: cannot transfer to the zero address");

            balances[src] = sub96(balances[src], amount, "Comp::_transferTokens: transfer amount exceeds balance");
            balances[dst] = add96(balances[dst], amount, "Comp::_transferTokens: transfer amount overflows");
            emit Transfer(src, dst, amount);

            _moveDelegates(delegates[src], delegates[dst], amount);
        }

        function _moveDelegates(address srcRep, address dstRep, uint96 amount) internal {
            if (srcRep != dstRep && amount > 0) {
                if (srcRep != address(0)) {
                    uint32 srcRepNum = numCheckpoints[srcRep];
                    uint96 srcRepOld = srcRepNum > 0 ? checkpoints[srcRep][srcRepNum - 1].votes : 0;
                    uint96 srcRepNew = sub96(srcRepOld, amount, "Comp::_moveVotes: vote amount underflows");
                    _writeCheckpoint(srcRep, srcRepNum, srcRepOld, srcRepNew);
                }

                if (dstRep != address(0)) {
                    uint32 dstRepNum = numCheckpoints[dstRep];
                    uint96 dstRepOld = dstRepNum > 0 ? checkpoints[dstRep][dstRepNum - 1].votes : 0;
                    uint96 dstRepNew = add96(dstRepOld, amount, "Comp::_moveVotes: vote amount overflows");
                    _writeCheckpoint(dstRep, dstRepNum, dstRepOld, dstRepNew);
                }
            }
        }

        function _writeCheckpoint(address delegatee, uint32 nCheckpoints, uint96 oldVotes, uint96 newVotes) internal {
        uint32 blockNumber = safe32(block.number, "Comp::_writeCheckpoint: block number exceeds 32 bits");

        if (nCheckpoints > 0 && checkpoints[delegatee][nCheckpoints - 1].fromBlock == blockNumber) {
            checkpoints[delegatee][nCheckpoints - 1].votes = newVotes;
        } else {
            checkpoints[delegatee][nCheckpoints] = Checkpoint(blockNumber, newVotes);
            numCheckpoints[delegatee] = nCheckpoints + 1;
        }

        emit DelegateVotesChanged(delegatee, oldVotes, newVotes);
        }

        function safe32(uint n, string memory errorMessage) internal pure returns (uint32) {
            require(n < 2**32, errorMessage);
            return uint32(n);
        }

        function safe96(uint n, string memory errorMessage) internal pure returns (uint96) {
            require(n < 2**96, errorMessage);
            return uint96(n);
        }

        function add96(uint96 a, uint96 b, string memory errorMessage) internal pure returns (uint96) {
            uint96 c = a + b;
            require(c >= a, errorMessage);
            return c;
        }

        function sub96(uint96 a, uint96 b, string memory errorMessage) internal pure returns (uint96) {
            require(b <= a, errorMessage);
            return a - b;
        }

        function getChainId() internal pure returns (uint) {
            uint256 chainId;
            assembly { chainId := chainid() }
            return chainId;
        }
    }
    ```
    </details>

    - 거버넌스 토큰
    - ERC-20
    - 자금을 빌려주거나 빌리는 사람한테 토큰(COMP)으로 보상
        - ex) 대출 : 대출 받는 사람 / 대출금을 제공해준 사람
    - COMP를 가지고 있으면 투표권을 얻을 수 있음 → 의결권
        - 프로토콜에 관련된 모든 결졍/변경 사항을 토론하고 제안, 투표할 수 있음
    - COMP 가지고 있는 비율에 따라서 투표권이 달라짐
        - 토큰 하나당 한 개의 투표권
    - 자신 포함 모든 주소에 투표권 위임 가능
- Governance Module (Governance Bravo) 
    <details>
    <summary> contract source code </summary>

    ```solidity
    /**
    *Submitted for verification at Etherscan.io on 2020-03-04
    */

    pragma solidity ^0.5.16;
    pragma experimental ABIEncoderV2;

    contract GovernorAlpha {
        /// @notice The name of this contract
        string public constant name = "Compound Governor Alpha";

        /// @notice The number of votes in support of a proposal required in order for a quorum to be reached and for a vote to succeed
        function quorumVotes() public pure returns (uint) { return 400000e18; } // 400,000 = 4% of Comp

        /// @notice The number of votes required in order for a voter to become a proposer
        function proposalThreshold() public pure returns (uint) { return 100000e18; } // 100,000 = 1% of Comp

        /// @notice The maximum number of actions that can be included in a proposal
        function proposalMaxOperations() public pure returns (uint) { return 10; } // 10 actions

        /// @notice The delay before voting on a proposal may take place, once proposed
        function votingDelay() public pure returns (uint) { return 1; } // 1 block

        /// @notice The duration of voting on a proposal, in blocks
        function votingPeriod() public pure returns (uint) { return 17280; } // ~3 days in blocks (assuming 15s blocks)

        /// @notice The address of the Compound Protocol Timelock
        TimelockInterface public timelock;

        /// @notice The address of the Compound governance token
        CompInterface public comp;

        /// @notice The address of the Governor Guardian
        address public guardian;

        /// @notice The total number of proposals
        uint public proposalCount;

        struct Proposal {
            /// @notice Unique id for looking up a proposal
            uint id;

            /// @notice Creator of the proposal
            address proposer;

            /// @notice The timestamp that the proposal will be available for execution, set once the vote succeeds
            uint eta;

            /// @notice the ordered list of target addresses for calls to be made
            address[] targets;

            /// @notice The ordered list of values (i.e. msg.value) to be passed to the calls to be made
            uint[] values;

            /// @notice The ordered list of function signatures to be called
            string[] signatures;

            /// @notice The ordered list of calldata to be passed to each call
            bytes[] calldatas;

            /// @notice The block at which voting begins: holders must delegate their votes prior to this block
            uint startBlock;

            /// @notice The block at which voting ends: votes must be cast prior to this block
            uint endBlock;

            /// @notice Current number of votes in favor of this proposal
            uint forVotes;

            /// @notice Current number of votes in opposition to this proposal
            uint againstVotes;

            /// @notice Flag marking whether the proposal has been canceled
            bool canceled;

            /// @notice Flag marking whether the proposal has been executed
            bool executed;

            /// @notice Receipts of ballots for the entire set of voters
            mapping (address => Receipt) receipts;
        }

        /// @notice Ballot receipt record for a voter
        struct Receipt {
            /// @notice Whether or not a vote has been cast
            bool hasVoted;

            /// @notice Whether or not the voter supports the proposal
            bool support;

            /// @notice The number of votes the voter had, which were cast
            uint96 votes;
        }

        /// @notice Possible states that a proposal may be in
        enum ProposalState {
            Pending,
            Active,
            Canceled,
            Defeated,
            Succeeded,
            Queued,
            Expired,
            Executed
        }

        /// @notice The official record of all proposals ever proposed
        mapping (uint => Proposal) public proposals;

        /// @notice The latest proposal for each proposer
        mapping (address => uint) public latestProposalIds;

        /// @notice The EIP-712 typehash for the contract's domain
        bytes32 public constant DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,uint256 chainId,address verifyingContract)");

        /// @notice The EIP-712 typehash for the ballot struct used by the contract
        bytes32 public constant BALLOT_TYPEHASH = keccak256("Ballot(uint256 proposalId,bool support)");

        /// @notice An event emitted when a new proposal is created
        event ProposalCreated(uint id, address proposer, address[] targets, uint[] values, string[] signatures, bytes[] calldatas, uint startBlock, uint endBlock, string description);

        /// @notice An event emitted when a vote has been cast on a proposal
        event VoteCast(address voter, uint proposalId, bool support, uint votes);

        /// @notice An event emitted when a proposal has been canceled
        event ProposalCanceled(uint id);

        /// @notice An event emitted when a proposal has been queued in the Timelock
        event ProposalQueued(uint id, uint eta);

        /// @notice An event emitted when a proposal has been executed in the Timelock
        event ProposalExecuted(uint id);

        constructor(address timelock_, address comp_, address guardian_) public {
            timelock = TimelockInterface(timelock_);
            comp = CompInterface(comp_);
            guardian = guardian_;
        }

        function propose(address[] memory targets, uint[] memory values, string[] memory signatures, bytes[] memory calldatas, string memory description) public returns (uint) {
            require(comp.getPriorVotes(msg.sender, sub256(block.number, 1)) > proposalThreshold(), "GovernorAlpha::propose: proposer votes below proposal threshold");
            require(targets.length == values.length && targets.length == signatures.length && targets.length == calldatas.length, "GovernorAlpha::propose: proposal function information arity mismatch");
            require(targets.length != 0, "GovernorAlpha::propose: must provide actions");
            require(targets.length <= proposalMaxOperations(), "GovernorAlpha::propose: too many actions");

            uint latestProposalId = latestProposalIds[msg.sender];
            if (latestProposalId != 0) {
            ProposalState proposersLatestProposalState = state(latestProposalId);
            require(proposersLatestProposalState != ProposalState.Active, "GovernorAlpha::propose: one live proposal per proposer, found an already active proposal");
            require(proposersLatestProposalState != ProposalState.Pending, "GovernorAlpha::propose: one live proposal per proposer, found an already pending proposal");
            }

            uint startBlock = add256(block.number, votingDelay());
            uint endBlock = add256(startBlock, votingPeriod());

            proposalCount++;
            Proposal memory newProposal = Proposal({
                id: proposalCount,
                proposer: msg.sender,
                eta: 0,
                targets: targets,
                values: values,
                signatures: signatures,
                calldatas: calldatas,
                startBlock: startBlock,
                endBlock: endBlock,
                forVotes: 0,
                againstVotes: 0,
                canceled: false,
                executed: false
            });

            proposals[newProposal.id] = newProposal;
            latestProposalIds[newProposal.proposer] = newProposal.id;

            emit ProposalCreated(newProposal.id, msg.sender, targets, values, signatures, calldatas, startBlock, endBlock, description);
            return newProposal.id;
        }

        function queue(uint proposalId) public {
            require(state(proposalId) == ProposalState.Succeeded, "GovernorAlpha::queue: proposal can only be queued if it is succeeded");
            Proposal storage proposal = proposals[proposalId];
            uint eta = add256(block.timestamp, timelock.delay());
            for (uint i = 0; i < proposal.targets.length; i++) {
                _queueOrRevert(proposal.targets[i], proposal.values[i], proposal.signatures[i], proposal.calldatas[i], eta);
            }
            proposal.eta = eta;
            emit ProposalQueued(proposalId, eta);
        }

        function _queueOrRevert(address target, uint value, string memory signature, bytes memory data, uint eta) internal {
            require(!timelock.queuedTransactions(keccak256(abi.encode(target, value, signature, data, eta))), "GovernorAlpha::_queueOrRevert: proposal action already queued at eta");
            timelock.queueTransaction(target, value, signature, data, eta);
        }

        function execute(uint proposalId) public payable {
            require(state(proposalId) == ProposalState.Queued, "GovernorAlpha::execute: proposal can only be executed if it is queued");
            Proposal storage proposal = proposals[proposalId];
            proposal.executed = true;
            for (uint i = 0; i < proposal.targets.length; i++) {
                timelock.executeTransaction.value(proposal.values[i])(proposal.targets[i], proposal.values[i], proposal.signatures[i], proposal.calldatas[i], proposal.eta);
            }
            emit ProposalExecuted(proposalId);
        }

        function cancel(uint proposalId) public {
            ProposalState state = state(proposalId);
            require(state != ProposalState.Executed, "GovernorAlpha::cancel: cannot cancel executed proposal");

            Proposal storage proposal = proposals[proposalId];
            require(msg.sender == guardian || comp.getPriorVotes(proposal.proposer, sub256(block.number, 1)) < proposalThreshold(), "GovernorAlpha::cancel: proposer above threshold");

            proposal.canceled = true;
            for (uint i = 0; i < proposal.targets.length; i++) {
                timelock.cancelTransaction(proposal.targets[i], proposal.values[i], proposal.signatures[i], proposal.calldatas[i], proposal.eta);
            }

            emit ProposalCanceled(proposalId);
        }

        function getActions(uint proposalId) public view returns (address[] memory targets, uint[] memory values, string[] memory signatures, bytes[] memory calldatas) {
            Proposal storage p = proposals[proposalId];
            return (p.targets, p.values, p.signatures, p.calldatas);
        }

        function getReceipt(uint proposalId, address voter) public view returns (Receipt memory) {
            return proposals[proposalId].receipts[voter];
        }

        function state(uint proposalId) public view returns (ProposalState) {
            require(proposalCount >= proposalId && proposalId > 0, "GovernorAlpha::state: invalid proposal id");
            Proposal storage proposal = proposals[proposalId];
            if (proposal.canceled) {
                return ProposalState.Canceled;
            } else if (block.number <= proposal.startBlock) {
                return ProposalState.Pending;
            } else if (block.number <= proposal.endBlock) {
                return ProposalState.Active;
            } else if (proposal.forVotes <= proposal.againstVotes || proposal.forVotes < quorumVotes()) {
                return ProposalState.Defeated;
            } else if (proposal.eta == 0) {
                return ProposalState.Succeeded;
            } else if (proposal.executed) {
                return ProposalState.Executed;
            } else if (block.timestamp >= add256(proposal.eta, timelock.GRACE_PERIOD())) {
                return ProposalState.Expired;
            } else {
                return ProposalState.Queued;
            }
        }

        function castVote(uint proposalId, bool support) public {
            return _castVote(msg.sender, proposalId, support);
        }

        function castVoteBySig(uint proposalId, bool support, uint8 v, bytes32 r, bytes32 s) public {
            bytes32 domainSeparator = keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), getChainId(), address(this)));
            bytes32 structHash = keccak256(abi.encode(BALLOT_TYPEHASH, proposalId, support));
            bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
            address signatory = ecrecover(digest, v, r, s);
            require(signatory != address(0), "GovernorAlpha::castVoteBySig: invalid signature");
            return _castVote(signatory, proposalId, support);
        }

        function _castVote(address voter, uint proposalId, bool support) internal {
            require(state(proposalId) == ProposalState.Active, "GovernorAlpha::_castVote: voting is closed");
            Proposal storage proposal = proposals[proposalId];
            Receipt storage receipt = proposal.receipts[voter];
            require(receipt.hasVoted == false, "GovernorAlpha::_castVote: voter already voted");
            uint96 votes = comp.getPriorVotes(voter, proposal.startBlock);

            if (support) {
                proposal.forVotes = add256(proposal.forVotes, votes);
            } else {
                proposal.againstVotes = add256(proposal.againstVotes, votes);
            }

            receipt.hasVoted = true;
            receipt.support = support;
            receipt.votes = votes;

            emit VoteCast(voter, proposalId, support, votes);
        }

        function __acceptAdmin() public {
            require(msg.sender == guardian, "GovernorAlpha::__acceptAdmin: sender must be gov guardian");
            timelock.acceptAdmin();
        }

        function __abdicate() public {
            require(msg.sender == guardian, "GovernorAlpha::__abdicate: sender must be gov guardian");
            guardian = address(0);
        }

        function __queueSetTimelockPendingAdmin(address newPendingAdmin, uint eta) public {
            require(msg.sender == guardian, "GovernorAlpha::__queueSetTimelockPendingAdmin: sender must be gov guardian");
            timelock.queueTransaction(address(timelock), 0, "setPendingAdmin(address)", abi.encode(newPendingAdmin), eta);
        }

        function __executeSetTimelockPendingAdmin(address newPendingAdmin, uint eta) public {
            require(msg.sender == guardian, "GovernorAlpha::__executeSetTimelockPendingAdmin: sender must be gov guardian");
            timelock.executeTransaction(address(timelock), 0, "setPendingAdmin(address)", abi.encode(newPendingAdmin), eta);
        }

        function add256(uint256 a, uint256 b) internal pure returns (uint) {
            uint c = a + b;
            require(c >= a, "addition overflow");
            return c;
        }

        function sub256(uint256 a, uint256 b) internal pure returns (uint) {
            require(b <= a, "subtraction underflow");
            return a - b;
        }

        function getChainId() internal pure returns (uint) {
            uint chainId;
            assembly { chainId := chainid() }
            return chainId;
        }
    }

    interface TimelockInterface {
        function delay() external view returns (uint);
        function GRACE_PERIOD() external view returns (uint);
        function acceptAdmin() external;
        function queuedTransactions(bytes32 hash) external view returns (bool);
        function queueTransaction(address target, uint value, string calldata signature, bytes calldata data, uint eta) external returns (bytes32);
        function cancelTransaction(address target, uint value, string calldata signature, bytes calldata data, uint eta) external;
        function executeTransaction(address target, uint value, string calldata signature, bytes calldata data, uint eta) external payable returns (bytes memory);
    }

    interface CompInterface {
        function getPriorVotes(address account, uint blockNumber) external view returns (uint96);
    }
    ```
    </details>

    - Quorum Votes : proposal이 성공하기 위해 필요한 최소 투표 수
    - Proposal Threshold : account가 proposal을 작성하는데 필요한 최소 투표 수 (거버넌스를 통해 변경할 수 있음)
    - Proposal Max Operations : proposal에 포함될 수 있는 최대 action 수
        - actions은 proposal이 성공하거나 실행될 때 호출되는 functions
    - Voting Delay : proposal에 대한 voting이 시작되기 전에 대기할 이더리움 블록의 수 (거버넌스를 통해 변경할 수 있음)
    - Voting Period : 이더리움 블록에서 proposal을 voting하는 기간 (거버넌스를 통해 변경할 수 있음)
    - Propose : proposal 생성
    - Queue : proposal이 성공하면 Queue 함수를 이용해서 timelock waiting 기간으로 이동 (2일)
    - Execute : timelock waititng 기간이 지나면 proposal에 명시한 내용을 target contract에 적용
    - Cancel : timelock에서 기다리고 있는 proposal 취소
    - Get Actions : 선택한 proposal의 action을 가져옴
        - proposal id를 인자로 주면, targets, values, signature, calldatas를 가져옴
    - Get Receipt : indicated된 voter의 proposal ballot recipt를 가져옴
    - state : 해당 proposal의 proposal state를 가져옴
    - cast vote : proposal에 투표
    - cast vote with reason : 투표할 때 이유도 함께 투표
    - cast vote with signature : cast vote랑 목적은 같은데, 투표할 때 offline signatures로 컴파운드 거버넌스 voting에 참여
    
    Reference : [compound-protocol/contracts/Governance at a3214f67b73310d547e00fc578e8355911c9d376 · compound-finance/compound-protocol](https://github.com/compound-finance/compound-protocol/tree/a3214f67b73310d547e00fc578e8355911c9d376/contracts/Governance)
    
- TimeLock 
    <details>
    <summary> contract source code </summary>

    ```solidity
    // SPDX-License-Identifier: BSD-3-Clause
    pragma solidity ^0.8.10;

    import "./SafeMath.sol";

    contract Timelock {
        using SafeMath for uint;

        event NewAdmin(address indexed newAdmin);
        event NewPendingAdmin(address indexed newPendingAdmin);
        event NewDelay(uint indexed newDelay);
        event CancelTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature,  bytes data, uint eta);
        event ExecuteTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature,  bytes data, uint eta);
        event QueueTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature, bytes data, uint eta);

        uint public constant GRACE_PERIOD = 14 days;
        uint public constant MINIMUM_DELAY = 2 days;
        uint public constant MAXIMUM_DELAY = 30 days;

        address public admin;
        address public pendingAdmin;
        uint public delay;

        mapping (bytes32 => bool) public queuedTransactions;

        constructor(address admin_, uint delay_) public {
            require(delay_ >= MINIMUM_DELAY, "Timelock::constructor: Delay must exceed minimum delay.");
            require(delay_ <= MAXIMUM_DELAY, "Timelock::setDelay: Delay must not exceed maximum delay.");

            admin = admin_;
            delay = delay_;
        }

        fallback() external payable { }

        function setDelay(uint delay_) public {
            require(msg.sender == address(this), "Timelock::setDelay: Call must come from Timelock.");
            require(delay_ >= MINIMUM_DELAY, "Timelock::setDelay: Delay must exceed minimum delay.");
            require(delay_ <= MAXIMUM_DELAY, "Timelock::setDelay: Delay must not exceed maximum delay.");
            delay = delay_;

            emit NewDelay(delay);
        }

        function acceptAdmin() public {
            require(msg.sender == pendingAdmin, "Timelock::acceptAdmin: Call must come from pendingAdmin.");
            admin = msg.sender;
            pendingAdmin = address(0);

            emit NewAdmin(admin);
        }

        function setPendingAdmin(address pendingAdmin_) public {
            require(msg.sender == address(this), "Timelock::setPendingAdmin: Call must come from Timelock.");
            pendingAdmin = pendingAdmin_;

            emit NewPendingAdmin(pendingAdmin);
        }

        function queueTransaction(address target, uint value, string memory signature, bytes memory data, uint eta) public returns (bytes32) {
            require(msg.sender == admin, "Timelock::queueTransaction: Call must come from admin.");
            require(eta >= getBlockTimestamp().add(delay), "Timelock::queueTransaction: Estimated execution block must satisfy delay.");

            bytes32 txHash = keccak256(abi.encode(target, value, signature, data, eta));
            queuedTransactions[txHash] = true;

            emit QueueTransaction(txHash, target, value, signature, data, eta);
            return txHash;
        }

        function cancelTransaction(address target, uint value, string memory signature, bytes memory data, uint eta) public {
            require(msg.sender == admin, "Timelock::cancelTransaction: Call must come from admin.");

            bytes32 txHash = keccak256(abi.encode(target, value, signature, data, eta));
            queuedTransactions[txHash] = false;

            emit CancelTransaction(txHash, target, value, signature, data, eta);
        }

        function executeTransaction(address target, uint value, string memory signature, bytes memory data, uint eta) public payable returns (bytes memory) {
            require(msg.sender == admin, "Timelock::executeTransaction: Call must come from admin.");

            bytes32 txHash = keccak256(abi.encode(target, value, signature, data, eta));
            require(queuedTransactions[txHash], "Timelock::executeTransaction: Transaction hasn't been queued.");
            require(getBlockTimestamp() >= eta, "Timelock::executeTransaction: Transaction hasn't surpassed time lock.");
            require(getBlockTimestamp() <= eta.add(GRACE_PERIOD), "Timelock::executeTransaction: Transaction is stale.");

            queuedTransactions[txHash] = false;

            bytes memory callData;

            if (bytes(signature).length == 0) {
                callData = data;
            } else {
                callData = abi.encodePacked(bytes4(keccak256(bytes(signature))), data);
            }

            // solium-disable-next-line security/no-call-value
            (bool success, bytes memory returnData) = target.call{value: value}(callData);
            require(success, "Timelock::executeTransaction: Transaction execution reverted.");

            emit ExecuteTransaction(txHash, target, value, signature, data, eta);

            return returnData;
        }

        function getBlockTimestamp() internal view returns (uint) {
            // solium-disable-next-line security/no-block-members
            return block.timestamp;
        }
    }
    ```
    </details>
    <details>
    <summary> timelock api </summary>
    
    - setDelay → Delay 설정
    
        ```solidity
        //uint public constant MINIMUM_DELAY = 2 days;
        //uint public constant MAXIMUM_DELAY = 30 days;
        
        function setDelay(uint delay_) public {
                require(msg.sender == address(this), "Timelock::setDelay: Call must come from Timelock.");
                require(delay_ >= MINIMUM_DELAY, "Timelock::setDelay: Delay must exceed minimum delay.");
                require(delay_ <= MAXIMUM_DELAY, "Timelock::setDelay: Delay must not exceed maximum delay.");
                delay = delay_;
        
                emit NewDelay(delay);
            }
        ```
        
        - msg.sender가 현재 contract의 주소와 일치해야 됨 → timelock contract가 호출
        - _delay 기간 :  2일~30일 사이
    - acceptAdmin → admin 변경
        
        ```solidity
        function acceptAdmin() public {
                require(msg.sender == pendingAdmin, "Timelock::acceptAdmin: Call must come from pendingAdmin.");
                admin = msg.sender;
                pendingAdmin = address(0);
        
                emit NewAdmin(admin);
            }
        ```
        
        - msg.sender가 pendingAdmin이어야 됨 → pendingAdmin이 호출
        - admin을 msg.sender로 바꿔줌 → admin = pendingAdmin
        - pendingAdmin은 address(0)으로 설정해줌
            - address(0)이면 트랜잭션이 새로운 컨트랙트를 create해줌
    - setPendingAdmin → pendingAdmin 변경
        
        ```solidity
        function setPendingAdmin(address pendingAdmin_) public {
                require(msg.sender == address(this), "Timelock::setPendingAdmin: Call must come from Timelock.");
                pendingAdmin = pendingAdmin_;
        
                emit NewPendingAdmin(pendingAdmin);
            }
        ```
        
        - msg.sender가 현재 contract의 주소와 일치해야 됨 → timelock contract가 호출
        - pendingAdmin을 pendimgAdming_으로 바꿔줌 → pendingAdmin = pendingAdmin_
    - queueTransaction → eta만큼 delay한 뒤 실행시킨 트랜잭션을 넣어줌
        
        ```solidity
        function queueTransaction(address target, uint value, string memory signature, bytes memory data, uint eta) public returns (bytes32) {
                require(msg.sender == admin, "Timelock::queueTransaction: Call must come from admin.");
                require(eta >= getBlockTimestamp().add(delay), "Timelock::queueTransaction: Estimated execution block must satisfy delay.");
        
                bytes32 txHash = keccak256(abi.encode(target, value, signature, data, eta));
                queuedTransactions[txHash] = true;
        
                emit QueueTransaction(txHash, target, value, signature, data, eta);
                return txHash;
            }
        ```
        
        - msg.sender는 admin이어야 됨
        - eta 값이 현재 timestamp+delay 보다 크거나 같은지 확인 → delay 이후 실행되어야 하기 때문에
        - 인자값들을 keccak256으로 암호화 → txHash
        - queuedTransactions에서 txHash값을 True로 바꿔줌
    - cancelTransaction → 실행시킬 트랜잭션을 취소함
        
        ```solidity
        function cancelTransaction(address target, uint value, string memory signature, bytes memory data, uint eta) public {
                require(msg.sender == admin, "Timelock::cancelTransaction: Call must come from admin.");
        
                bytes32 txHash = keccak256(abi.encode(target, value, signature, data, eta));
                queuedTransactions[txHash] = false;
        
                emit CancelTransaction(txHash, target, value, signature, data, eta);
            }
        ```
        
        - 인자
            - target : 실행시키고 싶은 target 주소
            - value : 얼만큼 전송할지
            - signature : function signature
            - data : 트랜잭션에 포함할 msg 값
            - eta : 얼만큼 Delay 된 후에 실행시킬지
        - msg.sender는 admin이어야 됨
        - 인자값들을 keccak256으로 암호화 → txHash
        - queuedTransactions에서 txHash값을 False로 바꿔줌
    - executeTransaction → 트랜잭션 실행
        
        ```solidity
        // uint public constant GRACE_PERIOD = 14 days;
        
        function executeTransaction(address target, uint value, string memory signature, bytes memory data, uint eta) public payable returns (bytes memory) {
                require(msg.sender == admin, "Timelock::executeTransaction: Call must come from admin.");
        
                bytes32 txHash = keccak256(abi.encode(target, value, signature, data, eta));
                require(queuedTransactions[txHash], "Timelock::executeTransaction: Transaction hasn't been queued.");
                require(getBlockTimestamp() >= eta, "Timelock::executeTransaction: Transaction hasn't surpassed time lock.");
                require(getBlockTimestamp() <= eta.add(GRACE_PERIOD), "Timelock::executeTransaction: Transaction is stale.");
        
                queuedTransactions[txHash] = false;
        
                bytes memory callData;
        
                if (bytes(signature).length == 0) {
                    callData = data;
                } else {
                    callData = abi.encodePacked(bytes4(keccak256(bytes(signature))), data);
                }
        
                // solium-disable-next-line security/no-call-value
                (bool success, bytes memory returnData) = target.call{value: value}(callData);
                require(success, "Timelock::executeTransaction: Transaction execution reverted.");
        
                emit ExecuteTransaction(txHash, target, value, signature, data, eta);
        
                return returnData;
            }
        ```
        
        - 인자
            - target : 실행시키고 싶은 target 주소
            - value : 얼만큼 전송할지
            - signature : function signature
            - data : 트랜잭션에 포함할 msg 값
            - eta : 얼만큼 Delay 된 후에 실행시킬지
        - msg.sender는 admin이어야 됨
        - 인자값들을 keccak256으로 암호화 → txHash
        - queuedTransactions에 해당 값이 있는지 없는지 확인
        - eta 값이 현재 timestamp+delay 보다 크거나 같은지 확인 → delay 이후 실행되어야 하기 때문에
        - eta+14일보다 현재 블록의 timestamp가 작거나 같은지 확인 → 트랜잭션이 오래됐는지 확인?
        - 앞서 구한 txHash는 queuedTransaction에서 False로 바꿔줌
        - 함수호출할 때 사용할 인자값 저장
            - signature 길이가 0이면, callData에 data 저장
            - signature 길이가 0이 아니면, signature를 keccak256으로 암호화한 값이랑 data를 packed encode해주고 callData에 저장
        - call함수로 target 트랜잭션을 실행시켜줌
    - getBlockTimestamp → 현재 블록의 timestamp 값을 return해줌
        
        ```solidity
        function getBlockTimestamp() internal view returns (uint) {
                // solium-disable-next-line security/no-block-members
                return block.timestamp;
            }
        ```
</details>
            
- 전체적인 동작 방식
    
    ![Untitled](https://file.notion.so/f/s/a1c1a359-16d1-4b12-b3d4-11113882e443/Untitled.png?id=df06087d-b0ee-4946-8cec-47299945da6f&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=zHs_CWxQJt07tyKe8QE8Ptq7StLsSoUxbNkJrBfx6xY&downloadName=Untitled.png)
    
    1. Create Proposal
        - proposal 생성
    2. Review(2 days)
        - 생성된 proposal을 2일동안 리뷰 기간을 가짐
    3. Voting(3 days)
        - 투표 결과가 Quorum Votes 수를 만족하면 통과
        - cancel되면 다시 review 상태로 돌아감
    4. execute ‘Queue’
        - 투표가 통과됐다고 다 Queue로 이동하는 건 아니고 누군가 queue 함수를 실행해줘야 됨
    5. Time lock(2 days)
        - (4)에서 통과된 proposal에 대해 queue함수로 실행시켜주면 Queue로 이동해서 2일동안 대기
        - timelock
    6. execute ‘execute’
        - (4)와 마찬가지로 대기 기간이 끝난 proposal을 실행하기 위해서는 execute를 실행시켜줘야 함
        - 즉, queue 상태에 있는 proposal을 누군가 execute 해줘야 해당 proposal에 대한 효력이 발휘됨
- Reference
  - [Compound governance docs](https://docs.compound.finance/v2/governance/)
  - [Contract source code](https://github.com/compound-finance/compound-protocol/blob/a3214f67b73310d547e00fc578e8355911c9d376/contracts/Timelock.sol)
