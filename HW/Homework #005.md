## Task 01: [pausable token 구현하기](https://github.com/dream-academy-s01/practice_ERC20)

github : https://github.com/dlanaraa/practice_ERC20

![Untitled](https://file.notion.so/f/s/ab6544d4-7615-43be-b888-c4c078bad977/Untitled.png?id=7c94a5cc-8135-4233-aec2-64fe64bdb0b4&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=zMgKNM6zvbqQHNCTIP22nI5q0olE10sXPET0vzCIkuc&downloadName=Untitled.png)

<br>

## Task 02: [permit token 구현하기](https://github.com/dream-academy-s01/practice_ERC20)

github : https://github.com/dlanaraa/practice_ERC20

![Untitled](https://file.notion.so/f/s/af7abae9-f795-4513-ba8a-2c03d7869362/Untitled.png?id=97c5f011-bf98-49e9-b1b0-4ae10c0f2fd8&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=LcZ1eEq0HGJJWrpssWo0bZA86O-WGT5nZOq3rDhgnlk&downloadName=Untitled.png)

## Task 03: [Web3OJ](https://app.web3oj.com/) 문제 풀어오기 

<details> 
<summary> 9. ERC-20 Mint 위임하기 </summary>

![Untitled](https://file.notion.so/f/s/6915e18e-f474-437a-a0f2-2e0b9c7b6a79/Untitled.png?id=9ff41ccd-edaf-41e8-9e60-a6c2bb850e7e&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=p9rBvqh-7npUKDKJ_I8ie14rrlyJpumMaaFAhwesYGQ&downloadName=Untitled.png)

<br>

### 문제 생성자 주소 찾기
    
![Untitled](https://file.notion.so/f/s/faa0015e-c060-4620-b903-41c45e60e8ad/Untitled.png?id=9728ea2d-7ac5-43a7-9d43-41b528658196&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=1XOIB9XNM9pz8fDkJtbUlTfXKBBTMaHlilubqpyDYVU&downloadName=Untitled.png)
    
→ 0xbD8748C47C5C026F7b2ce19Ca5f4bbd726d8F86f
    
<br>

### _mint함수 (contracts/token/ERC20/ERC20.sol)
    
```solidity
function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }
```
<br>

### Attack 컨트랙트
    
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IERC20Mintable {
    function mint(address to, uint256 amount) external;
}

contract ERC20Mintable{
    IERC20Mintable public token;

    function setToken(address _token) public {
        token = IERC20Mintable(_token);
    }
}

contract Attack is ERC20Mintable, ERC20 {
    address owner;

    constructor() ERC20("nara", "aaa"){
        owner = msg.sender;
        _mint(owner, 100000 * 10 ** uint256(decimals()));
    }

    function ChangeOwner(address _addr) public{
        owner = _addr;
    }

    function mint(address to, uint256 amount) public {
        require(owner == msg.sender, "Only Owner");
        _mint(to, amount);
    }
}
```
    
- 처음에 Attack 컨트랙트 배포할 때 _mint로 ERC-20을 생성해줘야 됨
- 문제 생성자를 owner로 바꿔주는 과정 필요 → ChangeOwner
- Attack 컨트랙트 주소를 set 해줌
    
<br>

![](https://file.notion.so/f/s/fb640f00-5fe5-47f1-90e3-25c9dfb466c6/Untitled.png?id=3b729f32-7391-4887-ab1e-2aa2fc6d35cb&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=NNt19ecrBmkeQJfA4CXoTGj3CDoex3TOibXniAVbPx4&downloadName=Untitled.png)

Link : https://app.web3oj.com/app/problem/9

</details>
    

<details>
<summary> 10. ERC-20 소각하기 </summary>

![Untitled](https://file.notion.so/f/s/6263445f-28ff-47dd-a737-2ccbfc0017e5/Untitled.png?id=ca19d5f7-e3d0-421f-8567-d08e663c78ff&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=hYXnoqKuzRrS-oeoe8I7gQ_wUKxMoG5K80D3doNNiqs&downloadName=Untitled.png)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract ERC20BurnableToken is ERC20, ERC20Burnable {
    constructor(address _player) ERC20("BurnableToken", "BTK") {
        _mint(msg.sender, 2000000000 * 10 ** decimals());
        transfer(_player, 20 * 10 ** decimals());
    }
}
```

![Untitled](https://file.notion.so/f/s/8b9c2640-415c-4bff-b53f-bc9b1f90226f/Untitled.png?id=907d9fcf-4b63-429d-b090-74ac289e3b0b&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=ckAZN6o48l-q8fmueGPQ_WgViS2hswCTFbSArpoZ9gE&downloadName=Untitled.png)

- 이미 문제 컨트랙트에서 토큰을 burn해주는 함수가 포함된 =ERC20Burnable을 상속받고 있음
- 문제 인스턴스 주소를 At address를 하면 burn 함수가 보임
- 받은 토큰 20개를 burn해줌 → 제출 안됨
- balanceOf 함수로 지갑 주소에 토큰이 얼마나 있는지 확인해봄
    ![Untitled](https://file.notion.so/f/s/2443367d-8877-4abd-873a-7ba9d9ad883b/Untitled.png?id=fc789a2d-16b3-4bf9-ae23-4692f5a1cbdb&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=vUFKONqqXBmplX5Oa8q6N3rKJTPGbVugvMku9diDlMU&downloadName=Untitled.png)
- 남은 금액 다 burn 해줌

![Untitled](https://file.notion.so/f/s/8123de13-eac4-4b97-bce3-91fee3a58c2e/Untitled.png?id=f87118dc-ca0e-40c5-8a76-e58be2fe6141&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=dYRWZMzZ5wx1MNvR0Eab98r2gY3FlSbJWOrBWdsxyqE&downloadName=Untitled.png)

Link : https://app.web3oj.com/app/problem/10
</details>

<details>
<summary> 11. ERC-20 일시정지 </summary>

![Untitled](https://file.notion.so/f/s/e3ce6472-3b23-4a71-b531-b6b014012660/Untitled.png?id=d338e823-dc62-492b-967c-56302f8aa91b&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=0IqtmPJnZs9R4gVv9GCDY69xa9FMeuAII-jFauRi0uM&downloadName=Untitled.png)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Web3OJTPausable is ERC20, Pausable, AccessControl {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    constructor(address _player) ERC20("Web3 Online Judge Token", "WEB3OJT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, _player);
        _mint(msg.sender, 2000000000 * 10 ** decimals());
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}
```

- 이미 문제 컨트랙트에서 pause 함수가 구현되어 있음
- 인스턴스 주소를 At address 해서 pause하면 될 듯!
    
    ![Untitled](https://file.notion.so/f/s/d3f21c02-bc98-46b7-bc1d-91760f5e0250/Untitled.png?id=0daf67d3-5f91-4e2d-996b-8f8e556a7219&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=Q8Ya5eVihR4iGpSJGKZlSp918_RFEc5CcP4Q8aVAj4Q&downloadName=Untitled.png)
    
- pause 버튼 눌러주기
    
    ![Untitled](https://file.notion.so/f/s/30072161-5155-4882-a702-4d851cd9d8c0/Untitled.png?id=916ea836-3385-4bdc-927c-a417bc1f0511&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=xIJspKqdgBvubE-hONUiVxgP6eoKpayuR6OMHfr66DQ&downloadName=Untitled.png)
    

![Untitled](https://file.notion.so/f/s/5c8f45ac-161a-41be-97fe-00e8e7559ffe/Untitled.png?id=1a2d1727-9114-4b96-bad4-6473a7ba6156&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=9r7zLr2s3lm4IDrTlHX-5_NmIwJbU3cF6QGUc8MRKBQ&downloadName=Untitled.png)

(인스턴스 주소 다시 불러오기 해서 주소가 바뀜 ㅜ)

Link : https://app.web3oj.com/app/problem/11
</details>

<details>
<summary> 12. ERC-20 permit </summary>

![Untitled](https://file.notion.so/f/s/5e52702d-23a6-42b5-9f85-0d34c83adfc7/Untitled.png?id=b914de62-5428-409c-a09b-f56c57e9f0e2&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=99nbWpNOABVDRJtxWxS5Q24Kaf9NK-kjrz6DvZVe77I&downloadName=Untitled.png)

- permit()
    
    ```solidity
    function permit(
            address owner,
            address spender,
            uint256 value,
            uint256 deadline,
            uint8 v,
            bytes32 r,
            bytes32 s
        ) public virtual override {
            require(block.timestamp <= deadline, "ERC20Permit: expired deadline");
    
            bytes32 structHash = keccak256(abi.encode(_PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));
    
            bytes32 hash = _hashTypedDataV4(structHash);
    
            address signer = ECDSA.recover(hash, v, r, s);
            require(signer == owner, "ERC20Permit: invalid signature");
    
            _approve(owner, spender, value);
        }
    ```
    
    - 원래는 transferFrom()를 수행할 때 approve()로 토큰을 사용할 수 있는 권한을 준 다음 transferFrom()으로 토큰을 전송할 수 있음
    - permit()을 사용할 경우 approve() 없이 transferFrom() 수행 가능
    - 동작 원리?
        - A가 자신의 private key로 서명한 메시지를 B한테 보냄 (오프체인)
        - B는 이것을 가지고 operator한테 트랜잭션을 보냄
        - permit()을 통해 해당 메시지를 가지고 구한 주소랑 A의 주소가 일치하는지 확인
        - 일치하는 경우, allowance를 증가시켜줌
    - 즉, A는 트랜잭션을 보낼 필요 없이 B의 allowance를 증가시킴으로써 approve() 없이 B가 transferFrom()을 수행할 수 있도록 만들어줌
    → A의 ETH를 사용하지 않고 한 번의 트랜잭션으로  approve()와 transferFrom()을 수행할 수 있음
- Attack 컨트랙트
    
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.4;
    
    import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
    import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
    
    contract Web3OJTPermitable is ERC20, ERC20Permit {
        constructor()
            ERC20("Web3 Online Judge Token", "WEB3OJT")
            ERC20Permit("Web3 Online Judge Token")
        {
            _mint(msg.sender, 2000000000 * 10 ** decimals());
        }
    }
    ```
    
    - 알아야 하는 값
        - _PERMIT_TYPEHASH → ERC20Permit.sol에 있음
            
            ```solidity
            bytes32 private constant _PERMIT_TYPEHASH = keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
            ```
            
        - owner → 내 지갑 주소
        - spender → 인스턴스 주소
        - value → 2000000000 * 10 ** decimals()
        - _useNonce(owner) → ERC20Permit.sol에 있음
        - deadline → ??
    - v, r, s 값을 알아야 함
        - EIP 메시지 구조 → 여기에 빈칸들 채워주면 될 것 같음
            
            ```solidity
            const owner = "0x4F26BB12173916e4459921d504a02B222eaBC4C6" // 내 지갑 주소
            const spender = "0xdA698c897374BE4CF1B06D1945636D2dC2A8BC4A" //인스턴스 주소
            const value = "20000000000000000000"; // 2000000000 * 10 ** decimals()
            const nonce = "0";
            const deadline = Math.floor(Date.now() / 1000) + 36000;
            
              const DataTypes = JSON.stringify({
                types: {
                  EIP712Domain: [
                    {
                      name: "name",
                      type: "string",
                    },
                    {
                      name: "version",
                      type: "string",
                    },
                    {
                      name: "chainId",
                      type: "uint256",
                    },
                    {
                      name: "verifyingContract",
                      type: "address",
                    },
                  ],
            
                  Permit: [
                    {
                      name: "owner",
                      type: "address",
                    },
                    {
                      name: "spender",
                      type: "address",
                    },
                    {
                      name: "value",
                      type: "uint256",
                    },
                    {
                      name: "nonce",
                      type: "uint256",
                    },
                    {
                      name: "deadline",
                      type: "uint256",
                    },
                  ],
                },
                primaryType: "Permit",
                domain: {
                  name: "Web3 Online Judge Token", // 문제에 나와있음
                  version: "1",
                  chainId: "5", // goerli 체인 아이디가 5였음
                  verifyingContract: "0xdA698c897374BE4CF1B06D1945636D2dC2A8BC4A", //문제에서 mint하고 있었으니까 문제 인스턴스 주소 넣어줬음
                },
                message: {
                  owner: owner,
                  spender: spender,
                  value: value,
                  nonce: nonce,
                  deadline: deadline,
                },
              });
            ```
            
            [ERC-2612: Permit Extension for EIP-20 Signed Approvals](https://eips.ethereum.org/EIPS/eip-2612#specification)
            
    - 개발자 도구에서 풀어봄 ,,
        
        ![Untitled](https://file.notion.so/f/s/38b10521-43bc-43ef-9d98-910c7f8c106c/Untitled.png?id=6fdb5e39-608c-43e9-9be1-48f66837c8ae&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=phh2hEajgSBkapOjI4wSN8JX7gqlMnEx35KMfz28uC8&downloadName=Untitled.png)
        
    - method → “eth_signTypedData_v4”
        
        ![Untitled](https://file.notion.so/f/s/d0f78e7a-a513-4bcb-a9f1-4dd25428d487/Untitled.png?id=88913e66-68e1-4eff-8584-3177f9b3e344&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=3OlGX3ns-uZWoFcDIU6JoaPhMIIPRqcm4wzbalQEtyA&downloadName=Untitled.png)
        
    - sign한 signature
        
        ![Untitled](https://file.notion.so/f/s/a91ed7ba-6e91-46d5-a6b2-a40f5c652c58/Untitled.png?id=23acd7ad-53e1-4687-a0cc-3722936383a4&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=tt-lp2uhe95k8-mtQhzbzlN9ZxAfJdxnkBLxl6B2y3o&downloadName=Untitled.png)
        
        ![Untitled](https://file.notion.so/f/s/586016ee-d002-4c07-9879-aa99f2e7565c/Untitled.png?id=ca19e9fc-1500-4bb4-a772-f164059ff681&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=UJJPXwgHpUL7WU0GAfTqThUmcDMFhomF4jchlVf1VlI&downloadName=Untitled.png)
        
    - r, s, v 추출하는 Attack 컨트랙트
        
        ```solidity
        contract Attack{
        
            function _split(bytes memory sig) public pure returns(bytes32 r, bytes32 s, uint8 v){
                assembly{
                    r := mload(add(sig, 32))
                    s := mload(add(sig, 64))
                    v := byte(0, mload(add(sig, 96)))
                }
            }
        }
        ```
        
        ![Untitled](https://file.notion.so/f/s/30452f9a-71ea-40cb-9728-fac56889b220/Untitled.png?id=d2b0b537-560f-4ff9-bacc-5821ef0f18f0&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=kc5t2wrbUo7-jLkcEiRAHErf5wZl_QuQshzwKiNSDak&downloadName=Untitled.png)
        
        - r : 0x56f7ded7e713d1ce3786b2d1c51428006b94302f60300b6b0bf9953ca17453b0
        - s : 0x3f96934679dd0704b7bfdda1397c2cd83751ab5922540cb9a0b927d3901fba88
        - v : 28
    - 문제 컨트랙트 at address해서 permit 하기
        
        ![Untitled](https://file.notion.so/f/s/66c230fe-15bb-423d-89c1-e194bd07a490/Untitled.png?id=4a743d3d-4548-4a7b-8c55-cd6ead1f243d&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=aqbMEM_E-PUFsAa9-Ia49vU_IyXULCsltWtNtCWUiAQ&downloadName=Untitled.png)
        
    
    ![Untitled](https://file.notion.so/f/s/4545c38d-26ac-490b-8374-eb2fb7ed8155/Untitled.png?id=1ef5b0ff-74ee-4bce-90c4-d08a000fe851&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=BHyOla-IfezrbrwAQtnZ-1kZMRXf79iygwAqq8CbkMo&downloadName=Untitled.png)
    

Link : https://app.web3oj.com/app/problem/12
</details>
