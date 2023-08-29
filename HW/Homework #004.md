## Task 01. https://github.com/dream-academy-s01/practice02_QuizGame 구현하기
- [Use this template] 버튼을 누른 다음 새로운 repository에서 작업 수행
- 해당 Foundry repository에 있는 모든 테스트 케이스를 통과하여야 합니다.
- 채점은 GitHub Actions를 통해 진행됩니다 (Smart Contract 개발 실습 슬라이드 참고).
    - 테스트 코드 및 CI 관련 내용은 수정하지 마세요.
- 자세한 내용은 강의 슬라이드 참고 (06. Smart Contract 개발 실습)

<br>

## Task 02. https://github.com/dream-academy-s01/practice03_Lottery 구현하기
- [Use this template] 버튼을 누른 다음 새로운 repository에서 작업 수행
- 해당 Foundry repository에 있는 모든 테스트 케이스를 통과하여야 합니다.
- 채점은 GitHub Actions를 통해 진행됩니다 (Smart Contract 개발 실습 슬라이드 참고).
    - 테스트 코드 및 CI 관련 내용은 수정하지 마세요.
- 자세한 내용은 강의 슬라이드 참고 (06. Smart Contract 개발 실습)

<br>

## Task 03. [Web3OJ](https://app.web3oj.com/) 문제 풀기

<details>
<summary> 1. 덧셈 (쉬움) </summary>

![](https://file.notion.so/f/s/d18efd79-0616-486f-b023-ff316b910033/Untitled.png?id=1637e09a-fbce-4b18-aed0-e9df90b59ece&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=pSpYFQKHbghHVbD91Su7Zx7BIt4y_yJ0-rzAcr4HL7s&downloadName=Untitled.png)

### 풀이과정

1. 코드 작성하기<br>

    ``` solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    interface IPlusCalculator {
        function plus(uint256, uint256) external pure returns (uint256);
    }

    contract PlusCalculatorProblem{
        IPlusCalculator public plusCalculator;

        function setPlusCalculator(address _plusCalculator) public {
            plusCalculator = IPlusCalculator(_plusCalculator);
        }
    }

    contract MyPlusCalculator is IPlusCalculator {
        PlusCalculatorProblem public plusCalculatorProblem;

        function plus(uint256 input1, uint256 input2) override public pure returns (uint256){
            return input1 + input2;
        }
    }
    ```
    - 덧셈 기능을 하는 plus 함수 구현 → 입력으로 받은 두 인자(input1, input2)의 합을 return 해주도록 코드를 작성함

2. 작성한 컨트랙트(MyPlusCalculator)를 Deploy 해줌<br>

    ![](https://file.notion.so/f/s/6358bf97-f7d6-4063-a654-408dba7ad79b/Untitled.png?id=d66615b8-b679-4b32-a2f2-44fc805db4ac&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=CqFTXW8BJtRGlltWSk_osQR0oo-mC5jz0DLZMWVcdrQ&downloadName=Untitled.png)

3. 문제에 있는 instance 주소 넣고 at address로 컨트랙트 불러오기 (PlusCalculatorProblem 컨트랙트)<br>

    ![](https://file.notion.so/f/s/438621fc-c0f2-45c2-80a4-c64c0a868b12/Untitled.png?id=9fbfb130-e855-4cfe-8a79-96b0c34d8050&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=S3wLPlDv-JkxM_kfqPtmPoZmjIA042vByiAPC7dor1g&downloadName=Untitled.png)
    
4. PlusCalculatorProblem 컨트랙트가 생성됐으면, setPlusCalculator에 MyPlusCalculator 컨트랙트의 주소 넣고 호출 <br>

5. plusCalculator 값 확인 → 제대로 설정되면 MyPlusCalculator 컨트랙트 주소 출력<br>

    ![](https://file.notion.so/f/s/37218345-6d96-4ece-b2a7-934e576de7ab/Untitled.png?id=e9f799ef-064e-430b-9d6b-6f686b6f52c5&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=kGkY0tAkJzyL8P8xFCUyIZrxdMlKOynDKpffkPBIr9U&downloadName=Untitled.png)
    
6. 다시 MyPlusCalculator로 돌아와서 plus 함수에 인자값 넣고 호출하기<br>

    ![](https://file.notion.so/f/s/8e15c633-a8ac-4b27-b805-bddd4da57b79/Untitled.png?id=a81c4113-d951-4e3a-9469-ff928d59e7d8&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=tWv6BcJMf_pT-RWWZ4dEuwFx-g99v6WFmo457bT1wxU&downloadName=Untitled.png)
    
7. Web3OJ 사이트에서 제출하기<br>

    ![](https://file.notion.so/f/s/b8d54831-8ec0-4391-972b-01a68330aa0a/Untitled.png?id=c404f926-e90d-4d67-9171-e085d9f4cf18&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=roVaiJ6NpKj6-mfZjy0IqVyNcf1o44xWWrr_9NUdX4M&downloadName=Untitled.png)
    
LINK : https://app.web3oj.com/app/problem/1
</details>

<details>
<summary> 2. 뺄셈 (쉬움) </summary>

![](https://file.notion.so/f/s/1f2124d9-fc8c-4581-9f4c-d2365214ea81/Untitled.png?id=54e1866f-ae02-4745-8bbf-c5e87a143248&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=FKTV5tD4RAxuczdmifVFDjVU6MXk87srxnSrliACexY&downloadName=Untitled.png)

### 풀이과정

1. 코드 작성하기 <br>

    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    import "@openzeppelin/contracts/access/Ownable.sol";

    interface IMinusCalculator {
        function minus(uint256, uint256) external pure returns (uint256);
    }

    contract MinusCalculatorProblem{
        IMinusCalculator public minusCalculator;

        function setMinusCalculator(address _minusCalculator) public {
            minusCalculator = IMinusCalculator(_minusCalculator);
        }
    }

    contract MyMinusCalculator is IMinusCalculator {
        MinusCalculatorProblem public minuscalculatorproblem;

        function minus(uint256 input1, uint256 input2) override public pure returns (uint256){
            return input1 - input2;
        }
    }
    ```
    - 뺄셈 기능을 하는 minus 함수 구현 → 입력으로 받은 두 인자(input1, input2)의 차를 return 해주도록 코드를 작성함


2. MyMinusCalculator 컨트랙트 Deploy해주기 <br>

    ![](https://file.notion.so/f/s/ecc288f4-9ab6-4c19-862a-074536f55ce8/Untitled.png?id=8aaf4ad1-3f05-4509-a0c2-0cb028743935&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=YUeNboRoKjitxjaJiO2Q_sQ8SEg5vMHrlU7-ykmhOR4&downloadName=Untitled.png)

3. 문제에 있는 instance 주소 넣고 at address (MinusCalculatorProblem 컨트랙트) <br>

    ![](https://file.notion.so/f/s/6790a191-5f4b-454e-b8e2-c14fce6ec7b7/Untitled.png?id=8767f86b-38e0-46ea-9275-90bf29a325a0&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=osNx7Pp2UwMAlBT4Q8zwBlM0zvygAI_QwYRRK4PSam0&downloadName=Untitled.png)

4. MinusCalculatorProblem 컨트랙트가 생성됐으면, setMinusCalculator 함수에 MyMinusCalculator 컨트랙트 주소 넣고 호출 <br>

    ![](https://file.notion.so/f/s/0d54d279-67de-41c8-94b7-50a15e4957e0/Untitled.png?id=d3bf7175-e2fa-4691-b06a-7085f44dba00&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=q7TxwIPxJghJqBeVGoY_BIUJ9-PDxGEjGHuQJOOeJZg&downloadName=Untitled.png)

5. minusCalculator 값 확인 → 제대로 Deploy되면 MyMinusCalculator 컨트랙트 주소 출력<br>

    ![](https://file.notion.so/f/s/2afb4ef0-dc86-4884-82d4-afb92b6df51e/Untitled.png?id=f6fb7256-5612-42f8-b159-1e6f3fe9c592&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=M02-qZHbgI_nCd4DVUltJZ7HPYJXVxAWsvwczd8cN7I&downloadName=Untitled.png)

6. 다시 MyMinusCalculator로 돌아가서 minus 함수에 인자값 넣고 호출하기<br>

    ![](https://file.notion.so/f/s/9102aea9-d7b6-4a2a-954a-1770aece3e97/Untitled.png?id=ceabdce2-6545-4571-ac87-f12245e9253f&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=3MYmFHsztx4aXOvyiSW8827YqaD3oCLGw6ktLVBKf_c&downloadName=Untitled.png)

7. Web3OJ 사이트에서 제출하기<br>

    ![](https://file.notion.so/f/s/cd06bc1e-5f0b-4a0e-82f2-b3a21cfb6e3e/Untitled.png?id=86c99bb8-00d7-4b25-b368-687de853777e&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=RJTrNsih8X9bqPqgp18t8EhuDqtlQCy1lf7dbRZGJXI&downloadName=Untitled.png)
    
LINK : https://app.web3oj.com/app/problem/2
</details>

<details>
<summary> 3. 곱셈 (쉬움) </summary>

![](https://file.notion.so/f/s/004ce0ba-0d16-474c-8735-ecb4e8c6c182/Untitled.png?id=2462566d-9f9e-420f-a4e7-298533f20b03&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=lRVCljQ5xO52FpRyDz4pgNBIHMqiUm3QVaxWjey6qa4&downloadName=Untitled.png)

### 풀이과정

1. 코드 작성하기<br>

    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    import "@openzeppelin/contracts/access/Ownable.sol";

    interface IMultiplicationCalculator {
        function multiply(uint256, uint256) external pure returns (uint256);
    }

    contract MultiplicationCalculatorProblem{
        IMultiplicationCalculator public multiplicationCalculator;

        function setMultiplicationCalculator(address _multiplicationCalculator) public {
            multiplicationCalculator = IMultiplicationCalculator(_multiplicationCalculator);
        }
    }

    contract MyMultiplicationCalculator is IMultiplicationCalculator {
        MultiplicationCalculatorProblem public multiplicationcalculatorproblem;
        
        function multiply(uint256 input1, uint256 input2) override public pure returns (uint256){
            return input1 * input2;
        }
    }
    ```

    - 나눗셈 기능을 하는 multiply 함수 구현 → 입력으로 받은 두 인자(input1, input2)의 곱을 return 해주도록 코드를 작성함

2. MyMultiplicationCalculator 컨트랙트 Deploy 해주기<br>

    ![](https://file.notion.so/f/s/a7387253-77fa-4128-8732-8630cfaafdb4/Untitled.png?id=4eedb411-9870-4018-8b4e-c53efaac35bc&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=7o6MguC1KBepTjqJfpkj-OVgDib7vlD3YXUB-w8eJmg&downloadName=Untitled.png)

3. 문제에 있는 instance 주소 넣고 at address (MultiplicationCalculatorProblem)<br>

    ![](https://file.notion.so/f/s/1862f04a-cea3-4711-83c4-5c1becd86fcf/Untitled.png?id=3413c89c-7610-460c-9377-a1716627e0e0&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=4_5Umd5AmHPX-G_3FZmGDuEnocV5H06ljciTesaty-c&downloadName=Untitled.png)

4. MultiplicationCalculatorProblem 컨트랙트가 생성됐으면, setMultiplicationCalculator 함수에 MyMultiplicationCalculator 컨트랙트 주소 넣고 호출<br>

    ![](https://file.notion.so/f/s/11978e3b-5d5b-47be-9f4b-24933d6b75ce/Untitled.png?id=ad53796e-6c6b-47e3-92ff-2ab1aae81981&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=qtMCgHlhTQUeZoJZsnhUjY_Xy8IarQRcc882y-srJE8&downloadName=Untitled.png)

5. multiplicationCalculator 값 확인 → 제대로 Deploy 됐으면 MyMultiplicationCalculator 컨트랙트 주소 출력<br>

    ![](https://file.notion.so/f/s/fbbc7a29-0fba-41f4-9814-7be16beaeb32/Untitled.png?id=980490fa-88b5-440d-acf8-35055a0d3412&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=2AEd5fJLbub982E3qvseAuKoocR98N3vpV8wo1xjVNc&downloadName=Untitled.png)

6. 다시 MyMultiplicationCalculator로 돌아가서 multiply 함수에 인자값 넣고 호출하기<br>

    ![](https://file.notion.so/f/s/6f4626ec-c744-4637-8876-5a385c8209c2/Untitled.png?id=686cb3b6-86da-4e21-8148-24c3836ab819&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=kmMnQX8Kk_pR_3NHxxjSXqz2biQX8gZsKmwZx-FqscE&downloadName=Untitled.png)

7. Web3OJ 사이트에서 제출하기<br>

    ![](https://file.notion.so/f/s/a48b63ab-f88d-40d5-82b4-d6eb3d270db8/Untitled.png?id=f4e0926a-dcea-418b-99b4-d1308fd71495&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=1KudykhYwFWgGu_vHqYmrVqMxFW2dMoK1rYuDAZP1GM&downloadName=Untitled.png)
    
LINK : https://app.web3oj.com/app/problem/3
</details>

<details>
<summary> 4. 나눗셈 (쉬움) </summary>

![](https://file.notion.so/f/s/382ca49e-867d-4b99-88d9-a31e42ef7c26/Untitled.png?id=319a0ddb-0a54-45da-80dc-cffe432d2d04&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=tNEWo1wNIabUFKP7vUKupePxiQIu4dbdkqvQzTUeVq8&downloadName=Untitled.png)

### 풀이과정

1. 코드 작성하기<br>

    ``` solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    import "@openzeppelin/contracts/access/Ownable.sol";

    interface IDivisionCalculator {
        function divide(uint256, uint256) external pure returns (uint256);
    }

    contract DivisionCalculatorProblem{
        IDivisionCalculator public divisionCalculator;

        function setDivisionCalculator(address _divisionCalculator) public {
            divisionCalculator = IDivisionCalculator(_divisionCalculator);
        }
    }

    contract MyDivisionCalculator is IDivisionCalculator {
        DivisionCalculatorProblem public divisioncalculatorproblem;

        function divide(uint256 input1, uint256 input2) override public pure returns (uint256){
            return input1 / input2 ;
        }
    }
    ```

2. MyDivisionCalculator 컨트랙트 Deploy 해주기<br>

    ![](https://file.notion.so/f/s/57f5c35c-71e4-445c-be39-cd099baf6d33/Untitled.png?id=4336497b-3e2f-46dc-af66-ce79c0f8123c&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=A7DrBnIXZn4nm2dTqhoQpXmZSZ4q8ZhFAV6OpygqVys&downloadName=Untitled.png)

3. 문제에 있는 instance 주소 넣고 at address (DivisionCalculatorProblem 컨트랙트)<br>

    ![](https://file.notion.so/f/s/58db0100-086c-4104-b108-c1f9e9a7663c/Untitled.png?id=6ad69a85-7628-4b73-ac34-c57805547155&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=pPhIvbu3PgLm5JWSBGloCaRj5O2V0E1MnlBpeCxRWaM&downloadName=Untitled.png)

4. DivisionCalculatorProblem 컨트랙트가 생성됐으면, setDivisionCalculator 함수에 MyDivisionCalculator 컨트랙트 주소 넣고 호출<br>

    ![](https://file.notion.so/f/s/f7f24337-1919-4824-b9e0-063648294227/Untitled.png?id=6fa95ce5-25fb-46dc-909b-03638a20f1fe&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=dt-QucJ8NornF-T5kE3fiUVbjVGYyraPu0lOD0vTlvY&downloadName=Untitled.png)

5. divisionCalculator 값 확인 → 제대로 Deploy 되면 MyDivisionCalculator 주소 출력<br>

    ![](https://file.notion.so/f/s/22bfe36e-66e2-4a50-b6a9-345423855503/Untitled.png?id=331acfc1-a757-4c09-84e1-79c24e34b6ef&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=mYi7H3T8StPd5Szlmii7g4s2ZoTPq9MtlvpwqTTnyqI&downloadName=Untitled.png)

6. 다시 MyDivisionCalculator 컨트랙트로 돌아가서 divide 함수에 인자값 넣고 호출하기<br>

    ![](https://file.notion.so/f/s/494ccdc0-7b76-459c-808e-5706bb808ce7/Untitled.png?id=0c2ae205-97a8-4d98-8bcc-26d9b40952ff&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=EmlIc4UkWjIATSCJ4I3TAe5buooAyLk5mMpcW344w50&downloadName=Untitled.png)

7. Web3OJ 사이트에서 제출하기<br>

    ![](https://file.notion.so/f/s/16c16e26-e649-4075-a86e-d753158ba32e/Untitled.png?id=7b8ace81-75b7-4634-8760-29f95679508f&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=1jNuxIpK6WD3ff10roAokboXmGa3K4Epps15ZOTkE7Q&downloadName=Untitled.png)
    
LINK : https://app.web3oj.com/app/problem/4
</details>

<details>
<summary> 21. Run with ABI (중간) </summary>

![](https://file.notion.so/f/s/2a29218a-f86d-4481-a8b0-7a68ce573aed/Untitled.png?id=1c40480c-a394-4dee-b302-29046b5649c0&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=Ko56fSoNDJNhTB-tlm5i5756Vct84VhyjEsJSvidwnI&downloadName=Untitled.png)

###  풀이과정

1. Hint에 나와있는대로, Etherscan에서 문제 컨트랙트 인스턴스 주소 확인해봄<br>

        ```solidity
        # Palkeoramix decompiler. 

        def storage:
        unknowna146bf7aAddress is addr at storage 0

        def getAddress() payable: 
        return unknowna146bf7aAddress

        def unknowna146bf7a() payable: 
        return unknowna146bf7aAddress

        #
        #  Regular functions
        #

        def _fallback() payable: # default function
        revert

        def unknownda17c605(uint256 _param1) payable: 
        require calldata.size - 4 >=ΓÇ▓ 32
        require _param1 == addr(_param1)
        unknowna146bf7aAddress = addr(_param1)
        return unknowna146bf7aAddress
        ```
    - constructor() → unknowna146bf7aAddress 설정
    - getAddress() → unknowna146bf7aAddress값 return
    - unknowna146bf7a() → unknowna146bf7aAddress값 return
    - fallback()
    - unknownda17c605()
        - param1 == addr(param1) == unknowna146bf7aAddress
    - addr() → 아직 알 수 없음
    - 문제에서 주소를 등록하는 함수가 ‘funcName(address)’ 형식이었음
    → 위의 디컴파일 된 결과를 보면 unknownda17c605 함수 주소를 등록하는 함수임을 생각해볼 수 있음
    - 함수를 호출해주기 위해 해당 함수의 이름을 알아야 하는데 정보가 없음 
    → function signature를 구해줘야 할 것 같음 ..
    - 혹시 .. unknown 뒤에 있는 da17c605가 시그니처 아닐까?
    - call로 호출해주면 될 것 같은데 signature를 이용해서 인자값과 함께 호출하는 방법 → abi.encode

        ``` solidity
        // SPDX-License-Identifier: MIT
        pragma solidity ^0.8.17;

        interface IERC20 {
            function transfer(address, uint) external;
        }

        contract Token {
            function transfer(address, uint) external {}
        }

        contract AbiEncode {
            function test(address _contract, bytes calldata data) external {
                (bool ok, ) = _contract.call(data);
                require(ok, "call failed");
            }

            function encodeWithSignature(
                address to,
                uint amount
            ) external pure returns (bytes memory) {
                // Typo is not checked - "transfer(address, uint)"
                return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
            }

            function encodeWithSelector(
                address to,
                uint amount
            ) external pure returns (bytes memory) {
                // Type is not checked - (IERC20.transfer.selector, true, amount)
                return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
            }

            function encodeCall(address to, uint amount) external pure returns (bytes memory) {
                // Typo and type errors will not compile
                return abi.encodeCall(IERC20.transfer, (to, amount));
            }
        }
        ```

        - 현재 함수 시그니처랑 인자값을 알고 있음 → encodeWithSelector 함수 사용

2. Attack 소스코드 작성하기<br>

    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.4;

    contract Attack {

        address addr = 0x749bE04AB5c46Cf7ae6a7598Cc7Fa440d746d244; //인스턴스 주소
        address argv = 0x4F26BB12173916e4459921d504a02B222eaBC4C6; //내 메타마스크 지갑 주소

        function CallFunc() public returns (bytes memory) {
            bytes4 signature = 0xda17c605;
            addr.call(abi.encodeWithSelector(signature, argv));
        }
    }
    ```
- signature를 이용하여 함수를 호출하는 CallFunc()
- return 값을 설정해주지 않았을 때 계속해서 통과를 하지 못함
    - 이처럼 직접 상태변수를 변경하지 않고, 읽기만 하거나 또는 데이터를 카피하여 사용하되, 실제 상태변수에는 변화를 주고 싶지 않다면 memory 키워드를 쓰면된다.

3. Web3OJ 사이트에서 제출하기<br>

    ![](https://file.notion.so/f/s/09a18e0e-d94a-4054-b565-b5472c278b78/Untitled.png?id=4028f3b3-ca0a-4c0e-82a8-763015c27098&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=Bhuo_pJUhBi06yD6XeUhS95WVsX2lDASZ-km_6Tb1k8&downloadName=Untitled.png)
    
LINK : https://app.web3oj.com/app/problem/21
</details>

<details>
<summary> 24. ETH 송금하고 받기 (쉬움) </summary>

![](https://file.notion.so/f/s/25f6e67d-27be-4860-84e9-7f2662445a65/Untitled.png?id=75651617-329c-4297-aaf3-e2b1a63644f9&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=w41B-FfT-65bngnNggLTDTfM3tGujmc8eBPPaHJDWYo&downloadName=Untitled.png)

###  문제 컨트랙트

```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReceiveEtherFunctionProblem {
    address payable public contractAddress; // 이더를 돌려받을 컨트랙트 주소

	// 이더를 돌려받을 컨트랙트 주소 설정하기
    function setReceiveEtherAddress(address payable _contractAddress) public {
        require(_contractAddress.code.length > 0, "_contractAddress is not Contract");
        contractAddress = _contractAddress;
    }
}

contract Attack {
    address payable owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    function SendETH(address payable _to, uint money) public payable {
        (bool result, ) = _to.call{value : money}("");
        require(result, "Fail");
    }

    receive() external payable {}
}
```

- 이더를 받아야 함 → receive나 fallback 함수
- 이더를 보내주는 함수가 구현되어 있지 않음 → SendETH 함수 정의
    - 돈 보낼 주소랑 금액을 입력으로 받아야 함
    - call함수 이용해서 이더 전송
- Owner 설정
    - 이더스캔에서 해당 컨트랙트를 확인해봤더니 어떤 변수(stor1)랑 caller가 일치하는지 확인해주고 있었음
    - constructor에 owner를 payable(msg.sender)로 설정
    - msg.sender 말고는 돈 못 보내도록 설정
- 문제 마지막에 보면, 제출하기를 누르면 set에 설정한 주소로 이더를 보내준다고 명시되어 있음 → _to인자는 attack 컨트랙트의 주소가 되어야 됨
- attack을 deploy해서 컨트랙트 주소를 구해주고, 이 값을 set해주면 됨

    
LINK : https://app.web3oj.com/app/problem/24
</details>

<details>
<summary> 25. 자물쇠 풀기 (쉬움) </summary>

![](https://file.notion.so/f/s/2125eecc-052b-41fb-81aa-e817ad8d7c9a/Untitled.png?id=2c1664e2-9f4c-46e7-9e5b-94bc37785bf5&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=Q-7_x3_P3jW4r9dL1IEq9-q2J7e3T2WXOc0vdOjZhDg&downloadName=Untitled.png)

### 풀이과정

1. 코드 작성하기<br>

    ``` solidity
    // SPDX-License-Identifier: GPL-3.0

    pragma solidity ^0.8.0;

    contract LockProblem {
        bool public lock = true;
        address private player;

        constructor(address _player) {
            player = _player;
        }

        function unlock() public {
            require(tx.origin == player, "Only the player(tx.origin) can unlock the lock");
            require(msg.sender != player, "The player(msg.sender) cannot unlock the lock");
            lock = false;
        }
    }

    contract LockAttack {
        LockProblem public lockProblem;

        constructor(address _addr) {
            lockProblem = LockProblem(_addr);
        }

        function attack() public{
            lockProblem.unlock();
        }
    }
    ```
    - unlock 함수에 있는 require문 → tx.origin은 player이어야 하는데, msg.sender는 player면 안됨
    - 맨 처음에 player가 unlock 함수 호출하는 사이에 다른 컨트랙트 넣어서 다른 컨트랙트가 unlock을 호출하게 만들어주면?<br>
    → tx.origin은 player가 되는데, msg.sender는 다른 컨트랙트의 주소가 됨!

2. EOA가 LockAttack 컨트랙트를 호출하고, LockAttack 컨트랙트가 문제 컨트랙트를 호출해주도록 만들어줘야 함<br>

3. LockAttack 컨트랙트의 인자로 문제 컨트랙트의 인스턴스 주소를 넣어줌<br>

    ![](https://file.notion.so/f/s/92873fc2-f80a-4fe3-ae32-50458ebb3764/Untitled.png?id=c58ee4b2-9b79-4305-8bad-e5e5eaacde6c&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=g8p6drdGlekVvPgIGuPd5lXO9nVsPJOSiqkge7b0QqU&downloadName=Untitled.png)
    
4. LockAttack 컨트랙트에서 lockProblem 값을 확인해서 주소가 제대로 들어갔는지 확인 <br>
    ![](https://file.notion.so/f/s/f2b0b85d-20e0-4301-af03-8b65e0079696/Untitled.png?id=810ca910-e6f7-4625-93ff-aaa75c2399cc&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=7OPEIrjFjWCNq6sqsmG6v8xOWO6B8d6WzRoAk3fJ7Ks&downloadName=Untitled.png)

5. LockAttack 컨트랙트의 attack 함수 호출 → LockProblem의 unlock 함수 호출<br>

    
6. Web3OJ 사이트에서 제출하기<br>

    ![](https://file.notion.so/f/s/ff9a7c02-01fc-4bb9-88d2-0dfad7769334/Untitled.png?id=9b030173-0ab8-4d69-b769-459bd50c9142&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=CpK1B9692TuQuiwh9gnds_heyLGKCNdNU2lj_JyTVHY&downloadName=Untitled.png)
    
LINK : https://app.web3oj.com/app/problem/25
</details>

<details>
<summary> 26. 문자열 비교 (쉬움) </summary>

![](https://file.notion.so/f/s/c2f865f5-cc48-4803-87a1-6200fc9334f4/Untitled.png?id=c202eed5-faf9-4684-8c03-17645e396e78&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=Vl4SPqgrnnDOfXPeLkmjR2Q5t5ceEvEjJEA-21fgiUU&downloadName=Untitled.png)

### 풀이과정

1. 코드 작성하기<br>

    ``` solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    interface IStringCompare {
        function compare(string memory _a, string memory _b) external pure returns (bool);
    }

    contract StringCompareProblem {
        IStringCompare public stringCompareContract;

        function setStringCompareContract(address _stringCompareContract) public {
            stringCompareContract = IStringCompare(_stringCompareContract);
        }
    }

    contract MyStringCompareProblem is IStringCompare { 
        function compare(string memory input1, string memory input2) override external pure returns (bool){
            return (keccak256(abi.encodePacked(input1)) == keccak256(abi.encodePacked(input2)));
        }
    }
    ```
    - 솔리디티에서 문자열 비교할 때는 문자열 자체를 비교하는게 아니라 이걸 keccak256으로 인코딩해서 인코딩한 값이  일치하는지 확인
    - MyStringCompareProblem 컨트랙트에 문자열을 비교해주는 함수 compare 구현   

2. MyStringCompareProblem 컨트랙트 Deploy 해주기<br>
    ![](https://file.notion.so/f/s/4b164ea2-28c7-4179-8f01-2aa9c2eb9e5b/Untitled.png?id=6a713e2e-22e6-4b50-b1fd-333412786c1f&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=vjoIkvDS1rX9-6TLQLhXUMQtTv0XHwuQF_ng5ZaWG5s&downloadName=Untitled.png)

3. 문제에 있는 instance 주소 넣고 at address (StringCompareProblem 컨트랙트) <br>

    ![](https://file.notion.so/f/s/eeabb4ef-29a1-4a4d-bfa3-dfadf6b6fe7b/Untitled.png?id=94362abe-73dd-40aa-a446-10ae679e83a9&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=Zf8eXqk2BCFiTJnRlutfj2VAp1mDIJXqv5R4VlSHl5s&downloadName=Untitled.png)
    
4. StringCompareProblem 컨트랙트가 생성됐으면, setStringCompareContract 함수에 MyStringCompareProblem 컨트랙트 주소 넣고 호출 <br>
    ![](https://file.notion.so/f/s/4e2d98cb-af0d-4349-b665-c2c5917d7798/Untitled.png?id=914c9634-d074-4bc4-b729-020a11450480&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=zSNx7W4ZJNC_QCnB7FM_-b4O_0MMLn_sQZ5l-1mUals&downloadName=Untitled.png)

5. stringCompareContract 값 확인 → 제대로 등록 되면 MyStringCompareProblem 컨트랙트 주소 출력 <br>
    ![](https://file.notion.so/f/s/2a1fef9e-3078-4f65-81bd-583b033d998c/Untitled.png?id=010d6198-3539-4bff-a211-a97635fe051a&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=S-14fzNmy__5CbaAG2CVKGWO_pWiMXWXks0jtVcwOtY&downloadName=Untitled.png)

6. 다시 MyStringCompareProblem로 돌아가서 인자값 넣고 호출하기<br>
    ![](https://file.notion.so/f/s/5b52ae1a-5375-4258-8048-b6616f17007d/Untitled.png?id=f6c1470e-4356-45a0-a224-90767adef496&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=jkIML42yLCF5mwC3BTYvO_0fH_F1vSsM1UYcVb-Y0ps&downloadName=Untitled.png)

    
7. Web3OJ 사이트에서 제출하기<br>

    ![](https://file.notion.so/f/s/868d449d-ab86-456c-8d1d-88a315e34076/Untitled.png?id=76c00ca7-e4f1-4bed-bd94-0ae5b3b9cefb&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=kEWVVYNCPQpCF6CCsXPJCWZgo-plmFVyL0XkgI9lZDA&downloadName=Untitled.png)
    
LINK : https://app.web3oj.com/app/problem/26
</details>

<details>
<summary> 27. 에러 메시지 처리하기 (쉬움) </summary>

![](https://file.notion.so/f/s/92ce5f69-0794-4320-8331-f2aa807aea6e/Untitled.png?id=e944f3a8-d9a7-44a6-8b07-0e4198397662&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=XhNFmVrwAI7UV6mLoWLMDITX7k-Wte0q6Nj2rQK_1ZM&downloadName=Untitled.png)

### 문제 컨트랙트

``` solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract ErrorHandleProblem {
    string public errorMessage;

    function throwError() public {
        // 여기에 에러를 내는 함수가 작성되어 있습니다.
    }

    function setErrorMessage(string memory _errorMessage) public {
        errorMessage = _errorMessage;
    }
}
contract Attack {
    ErrorHandleProblem errorhandleproblem;

    constructor() {
        address problemAddr = 0xA346C50DB9786B89d1FDE3f52f18d0f7a2a44DB1; //인스턴스 주소
        errorhandleproblem = ErrorHandleProblem(problemAddr);
    }

    function ThrowError() public {
        try errorhandleproblem.throwError() {
            
        } catch Error(string memory error){
        errorhandleproblem.setErrorMessage(error);
        }
    }
}
```

<br>

### 풀이과정

- 문제 코드를 보면, throwError에서 에러를 발생시켜주고 있음
- 여기서 발생한 에러 메시지를 받아서 setErrorMessage의 인자로 넣어줘야 됨
- try catch문
    - try catch문 외부에서 발생한 에러를 catch에서 핸들할 수 있음
    - try문에서 throwError를 실행시켜서 에러 발생시킴
    - catch Error (string error) → revert 나 require를 통해 생성된 에러 핸들
    - 여기서 error 받아서 setErrorMessage의 인자로 넣어주기

<br>

### Web3OJ 사이트에서 제출하기

![](https://file.notion.so/f/s/01254725-e30e-4eee-b54f-ef7061475cc9/Untitled.png?id=8112e471-5a44-4b90-8a0f-307d3802e4b3&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=h5EKO9-w9azPdejKlt96b64oTmbwB64SbFnPQovNSJc&downloadName=Untitled.png)


LINK : https://app.web3oj.com/app/problem/27
</details>

<details>
<summary> 28. 에러 코드 처리하기 (쉬움) </summary>

![](https://file.notion.so/f/s/24d164f9-4bca-46c8-8940-d1e9d64a8294/Untitled.png?id=2be68699-083f-42af-80a5-bd7ede8b2567&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=Tveh1u1WxQ4cBFGFYkKoZaUR04huDF3177LghT7oWSU&downloadName=Untitled.png)

### 문제 컨트랙트

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ErrorHandleProblem2 {
    uint public errorCode;

    function throwError() public {
        // 여기에 에러를 내는 함수가 작성되어 있습니다.
    }

    function setErrorCode(uint _errorCode) public {
        errorCode = _errorCode;
    }
}

contract Attack {
    ErrorHandleProblem2 public errorhandleproblem;

    constructor() {
        address problemAddr = 0x9F14203Ea8d97420A0897222dFb96E0C5525b0e9; //인스턴스 주소
        errorhandleproblem = ErrorHandleProblem2(problemAddr);
    }

    function ThrowError() public {
        try errorhandleproblem.throwError() {
            
        } catch Panic (uint error){
        errorhandleproblem.setErrorCode(error);
        }
    }
}
```

<br>

### 풀이과정

- 문제 코드를 보면, throwError에서 에러를 발생시켜주고 있음
- 여기서 발생한 에러 메시지를 받아서 setErrorCode의 인자로 넣어줘야 됨
- try catch문
    - try catch문 외부에서 발생한 에러를 catch에서 핸들할 수 있음
    - try문에서 throwError를 실행시켜서 에러 발생시킴
    - catch Panic (uint error) →  assert를 통해 생성된 에러 핸들
    - 여기서 error 받아서 setErrorCode의 인자로 넣어주기

<br>

### Web3OJ 사이트에서 제출하기

![](https://file.notion.so/f/s/54599a96-75a2-4233-9ae8-7e242b6a8831/Untitled.png?id=347308be-2bb0-4631-9723-dc4f8fdbcf66&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=tHuvLE5tF_R1VrdHMLNl4VAP6cevY2HgUDkZSGkWfMM&downloadName=Untitled.png)

    
LINK : https://app.web3oj.com/app/problem/28
</details>

<details>
<summary> 30. 배열의 합 구하기 (중간) </summary>

![](https://file.notion.so/f/s/68e0cb98-e896-458a-b62a-8d2cbbb0a87a/Untitled.png?id=0b1eadaa-7a64-4467-a420-acc0ee777e2a&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=fKfPqT-leoB4KlVdx5LKxxjpjCAmIktXEoTCErf03DU&downloadName=Untitled.png)

### 문제 컨트랙트

``` solidity
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISumOfArray {
    function sum(uint[] memory _a) external pure returns (uint);
}

contract SumOfArrayCompetitionProblem {
    ISumOfArray public sumOfArrayContract;

    function setSumOfArrayContract(address _sumOfArrayContract) public {
        sumOfArrayContract = ISumOfArray(_sumOfArrayContract);
    }
}

contract SumArray is ISumOfArray {
    function sum(uint[] memory _a) override external pure returns (uint total) {
        total = 0;
        for (uint i = 0; i < _a.length; i++){
            total += _a[i];
        }
				return total;
    }
}
```

- ISumOfArray를 상속받는 SumArray 컨트랙트 작성
- sum 함수 구현
- for문으로 배열에 있는 값들 더해주면 된다고 생각했음

<br>

### 풀이과정

```solidity
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISumOfArray {
    function sum(uint[] memory _a) external pure returns (uint);
}

contract SumOfArrayCompetitionProblem {
    ISumOfArray public sumOfArrayContract;

    function setSumOfArrayContract(address _sumOfArrayContract) public {
        sumOfArrayContract = ISumOfArray(_sumOfArrayContract);
    }
}

contract SumArray is ISumOfArray {
    function sum(uint[] calldata _a) override external pure returns (uint total) {
        unchecked{
            for (uint i = 0; i < _a.length; ++i){
                total += _a[i];
            }
		    return total;
        }
    }  
}
```

- 이더스캔에서 해당 컨트랙트를 확인해봤더니 require 문에 calldata의 size 값으로 뭔가 하는 것 같음
- sum의 인자값을 memory가 아닌 calldata로 수정

    → memory를 사용하면 calldata에 비해 가스비가 더 발생한다고 함
    
- 생각해보니까 문제에서 최소한의 가스를 사용하라고 했었음
- SumArray에서 가스비 줄이는 방법
    1. memory → calldata
    2. i++ → ++i
    3. total = 0; 지우기 → 솔리디티에서는 어차피 초기값이 0이라서 굳이 0으로 설정 안해줘도 됨
    4. unchecked 추가


<br>

### Web3OJ 사이트에서 제출하기

![](https://file.notion.so/f/s/a38b7e1c-8b0e-41ec-a5b2-3ea73b7e0dff/Untitled.png?id=3c99fb08-7768-4b87-b0e9-a1ea6ceb3e12&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=g_3pPrphuT2gJPqjK2sjq6iTV1VwMJ1HlQCOl0nPvEs&downloadName=Untitled.png)

    
LINK : https://app.web3oj.com/app/problem/30

Reference : [Solidity Gas Optimizations Tricks](https://betterprogramming.pub/solidity-gas-optimizations-and-tricks-2bcee0f9f1f2)
</details>

<details>
<summary> 31. 휴먼계좌에 이더 넣기 (중간) </summary>

![](https://file.notion.so/f/s/6df2004d-ad7f-4cab-8ec1-a1c84219b8ec/Untitled.png?id=5c1b215c-16ec-494c-8724-e2f007251cdd&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=R-m0tfLOxhkP2NNvLvJi_mmgSsG0k2EPJPsYf4kkgYo&downloadName=Untitled.png)

### 문제 컨트랙트

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DormantAccount {
    
}

contract AccountAttack {
    address target = 0x5fbB836d19C5B03Cf698155E6a5d65770d305Fce; //인스턴스 주소

    constructor() payable{}

    function attack() public {  
        selfdestruct(payable(target));
    }

    receive() external payable{}

}
```

<br>

### 풀이과정

- selfdestruct
    - 현재 컨트랙트를 파기하고, 주소에 저장된 남은 ETH는 지정된 주소로 옮겨짐
    - 스토리지와 코드는 지워짐
    - 제거된 컨트랙트에 이더 보내면 이더는 그냥 사라짐 ,,
- AccountAttack 컨트랙트 deploy할 때 1 wei를 함께 보내주고 attack 함수를 실행시키면, AccountAttack에 저장되어있는 1wei가 DormantAccount로 옮겨질 것!

    ![](https://file.notion.so/f/s/c56a46ad-e29d-4542-8ac4-0ced622c5e1c/Untitled.png?id=8492bf83-8649-4e1d-b60b-2c42d25b35bb&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=uOUQ7Vez2TnG7GNoCTn8z0fwSbEpeunil4BNH50c6A4&downloadName=Untitled.png)
<br>

### Web3OJ 사이트에서 제출하기

![](https://file.notion.so/f/s/d61b67a7-cada-4bf5-8480-8d25ec033a23/Untitled.png?id=81213f18-d364-40ea-b734-2bc1c4faa878&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=8QM5i_68VhN-B9gBEiHEcoxrF-bRNGlShSuWhQQvsFo&downloadName=Untitled.png)

    
LINK : https://app.web3oj.com/app/problem/31

</details>
