## Task 01. [bitcoin-master](https://dreamhack.io/wargame/challenges/261/) 문제를 풀고, 풀이 보고 작성

### Merkle tree(머클트리)
- 이진 트리 형태의 자료구조
- 블록 안에 담겨 있는 트랜잭션 데이터를 해시값으로 변환
    → 해싱된 값을 두 개씩 짝지어서 해시값으로 변환
    → 이 과정을 하나의 해시값이 나올때까지 계속해서 반복
- 특징
    - SHA256 형태의 해시값
    - 32바이트의 크기를 갖음 → 머클루트만 블록체인에 기록!
    - 해당 트랜잭션 데이터의 존재 여부를 확인하고 찾을수 있음
    - 데이터의 위변조 검증 가능
- 용어
    - Leaf Node : 최하위 노드 → 트랜잭션 데이터의 해시값
    - Non-leaf Node(Merkle Branches) : 자식 노드들을 해싱한 해시값
    - Merkel Root(Root Hash) : 최상위 노드 → 최종적으로 나온 해시값
- Merkle Proof
    ![MerkleProof](https://miro.medium.com/v2/resize:fit:1200/1*gp9RaSxleAb3f9uZngpl3A.png)
    - Root Hash까지 계산하는데 필요한 해시값만 알고 있으면 됨!
    - 예시) H(K)에 대해서 검증하고 싶다! 
    → H(L), H(IJ), H(MNOP), H(ABCDEFG)만 알고 있으면 됨!
        1. H(K)와 H(L)을 해싱 → H(KL)
        2. H(KL)과 H(IJ)를 해싱 → H(IJKL)
        3. H(IJKL)과 H(MNOP)를 해싱 → H(IJKLMNOP)
        4. H(IJKLMNOP)와 H(ABCDEFGH)를 해싱 → H(ABCDEFGHIJKLMNOP)
        5. Root Hash인 H(ABCDEFGHIIJKLMNOP)가 블록체인에 기록된 값과 일치하는지 확인!
<br>

### bitcoin-master
![Untitled](https://file.notion.so/f/s/eb328f21-afe2-40ea-b4fa-51b6574016e7/Untitled.png?id=c18e9650-3bcb-4ddd-8c09-55915fedcd08&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693389600000&signature=4xwdMdCR37TnqZi4pU1WbxExzJYoo_yCG-kZs2eOZ1c&downloadName=Untitled.png)

- 여기서 ????? 위치에 들어가는 해시값을 구해줘야하는 것 같음
    - 이 위치가 계속해서 바뀜
- 해시값으로는 원본데이터를 알 수 없으니까 .. bruteforce를 해서 구해야 될 것 같음 …..
- HASH(해시)
    - 암호화 알고리즘 중 하나
    - 특징
        - 입력 값의 길이가 달라도 항상 고정된 길이의 해시값을 만들어 줌.
        - 입력 값이 아주 조금 달라지더라도 해시값은 완전히 달라짐
        - 단방향 알고리즘 → 해시값을 가지고 원본 데이터를 알아낼 수 없음
        - 같은 입력을 주면 항상 같은 해시값 출력
        - 해시 충돌 → 서로 다른 입력값에 대해 같은 출력값(해시값)이 나올 수 있음
    - 종류 : SHA256, SHA512, md5, keccak256 등
    - 사용 예시 : 무결성 검증, 패스워드 검사, 머클트리(Merkle tree)
- app.py
    
    ```python
    #!/usr/bin/python3
    from flask import Flask
    import requests
    import os
    from time import time
    
    from run import *
    
    app = Flask(__name__)
    app.secret_key = os.urandom(32)
    mr = None
    index = None
    tx_hashes = None
    lru_time = 0
    
    @app.route("/")
    def index():
        global mr, index, tx_hashes
        tx_hashes, mr, index, dat = main()
        return dat
    
    @app.route("/check/<t>")
    def checker(t):
        global tx_hashes, mr, index, lru_time
        if lru_time + 15 > time():
            return "nop~!"
        lru_time = time()
        if index is None or mr is None:
            return "none!"
    
        tx_hashes[index] = t
        if calculate_merkle_root(tx_hashes) == mr:
            from bitcoin import FLAG
    
            return FLAG
        else:
            return "STUDY AGAIN zz"
    
    if __name__ == "__main__":
        app.run(host="0.0.0.0", port=8000)
    ```
    
    - line 20 → run.py의 main 함수 실행
    - FLAG를 return 해주는 코드를 포함하고 있음
        - /check/<t>에 구한 해시값을 보내주면 머클루트 계산해서 맞으면 FLAG를 return 해주는 것 같음!
- run.py
    
    ```python
    import binascii
    from hashlib import sha256
    from pprint import pprint
    from bitcoin import FLAG, calculate_merkle_root, hash2
    
    def get_random_bytes():
        with open("/dev/urandom", "rb") as f:
            return f.read(2)
    
    def make_tx_hashes():
        return [
            sha256(get_random_bytes()).digest()[::-1].hex()
            for i in range((get_random_bytes()[0] % 16) + 16)
        ]
    
    def main():
        tx_hashes = make_tx_hashes()
        mr = calculate_merkle_root(tx_hashes)
        index = get_random_bytes()[0] % len(tx_hashes)
        tx_hashes[index] = "?" * 64
        ret = ""
        ret += str(("merkle_root:", mr))
        ret += "\n"
        ret += str("tx list:")
        ret += str(tx_hashes)
        return tx_hashes, mr, index, ret
    
    if __name__ == "__main__":
        main()
    ```
    
    - main 함수 보면 get_random_byte에서 랜덤 값 가져와서 해당 인덱스 값을 ?로 변경해주고 있음
        - get_random_byte에서는 2바이트 크기임
    - 실행시켜보면 calculate_merkle_root에서 오류
        - bitcoin.py
            
            ```python
            from bitcoin.py2specials import *
            from bitcoin.py3specials import *
            from bitcoin.main import *
            from bitcoin.transaction import *
            from bitcoin.deterministic import *
            from bitcoin.bci import *
            from bitcoin.composite import *
            from bitcoin.stealth import *
            from bitcoin.blocks import *
            from bitcoin.mnemonic import *
            ```
            
        
        → 머클루트 구하는 코드를 직접 구현해줘야하는 것 같음
        
- 머클루트 구하기
    - 머클루트 생성 방식 : leaf node 값들을 해싱 → 해싱된 값을 또 해싱 → 계속 반복 → 머클 루트
    - 예제
        
        ```python
        import hashlib
        import binascii
        
        def merkle(hashList):
            if len(hashList) == 1:
                return hashList[0]
            newHashList = []
            for i in range(0, len(hashList)-1, 2):
                newHashList.append(hashing(hashList[i], hashList[i+1]))
            if len(hashList) % 2 == 1: # odd, hash last item twice
                newHashList.append(hashing(hashList[-1], hashList[-1]))
            return merkle(newHashList)
        
        def hashing(a, b):
            a1 = binascii.unhexlify(a)[::-1] # big to little
            b1 = binascii.unhexlify(b)[::-1] # big to little
            enc = a1 + b1
            h = hashlib.sha256(hashlib.sha256(enc).digest()).digest()
            return binascii.hexlify(h[::-1])
        
        txHashes = []
            
        print(merkle(txHashes))
        ```
        
- exploit
    
    ```python
    from hashlib import sha256
    import hashlib
    import binascii
    
    def merkle(hashList): #머클루트 구하는 함수
            # hashList가 1인 것은 남은 노드 수가 1개인 것 -> RootHash
        if len(hashList) == 1:
            return hashList[0]
        
        newHashList = []
    
            # 만약, hashList의 길이가 홀수이면 마지막 노드를 하나 복사해서 맨 끝에 추가 -> 짝수 개로 맞춰주기
        if len(hashList) % 2 == 1:
            hashList.append(hashList[-1])
    
            #2개씩 묶어서 hashing 작업 진행
        for i in range(0, len(hashList)-1, 2):
            newHashList.append(hashing(hashList[i], hashList[i+1]))
            
            # merkle(newHashList)를 반환해서 다시 노드가 1개 남을 때까지 계속 반복
        return merkle(newHashList)
    
    def hashing(a, b): #두 노드를 합쳐서 sha256으로 해싱해주는 함수
            # 문자열을 바이트 코드로 변환해주고 리틀엔디안 방식으로 변환해줌
        a1 = binascii.unhexlify(a)[::-1]
        b1 = binascii.unhexlify(b)[::-1]
        enc = a1 + b1
        h = hashlib.sha256(hashlib.sha256(enc).digest()).digest()
            # 해싱된 값(h)을 다시 빅엔디안 방식으로 변환해주고, 문자열로 변환
        return binascii.hexlify(h[::-1])
    
    # 임의의 바이트를 해싱하는 부분
    # run.sh의 get_random_bytes 랜덤값을 2바이트씩 받아오고 있었으므로 
    # for문의 범위를 256*256-1로 설정해줌
    for i in range(0, 256*256-1):
            # 랜덤값 2바이트를 sha함수를 통해 해시값으로 만들어줌
        txt = hashlib.sha256(i.to_bytes(2, byteorder='little')).digest()[::-1].hex()
        txHashes = ['994ed6452267f9cce4c54ee64ece394ee340d5ffe1214275a2737d836d1050a4', '76924bf5c23ee45142ec5fc3fc30ceca6de3119dd8e0892eeb1527e12d843138', '8c274f9dedc541f4f889460c7869b58abcca25ab25e94122d476af54bd88438f', '796fa88e05d6f512c052c7b9355fc19d23a44966fd5c0b78502b0eff476b9801', 'fb2502470c06341bca6cb42f561e0057581ef29b37a74d3086efe07cdcb27738', '564f29dd1a54d346eb7fa7e30a941eb33fc1f98ae6d97ea2ada99e135558a121', '9a4a816ee448f83e11f55c92cc9a963ce6b12a494d1e43f47e5c551af05ad385', '73a6ab77baf2fccd44725a0327531e8f77e5c5fcd8f280c5de1449ea2999a57d', '310524f368453684cf7d4c482c0e354748536b8e7923cccb69195bc9fb61396f', 'a1050ddac9f36be4094b9ff9f42f02e4f0aa1bf251f099d97ffd5453ccce9cc1', '430440a694f096652b7d0597bc0168454e7dfd7cb595edd0cd63d20af5d75799', '8d3b22c1333583fa2ab5ea92a32d76abe563e392a567c6f85a8b6fe552e0a384', 'f0f4069dea9bf82a8f3e288bbc81acf36d52fa5d31f15e80f4f20e9cc94f7506', '3a0f6eb40e9fb891d26fd63b47887dbe473696a6e5b7ff25572af7b5cef03af8', '1bf228bc76d982950b469f0da73ae770832e5a472d090590b426832ed7866ae0', 'cccf9e7899bd1a3f3ffb61f67127121b1e912244888824226edee54beaca8280', 'c296345eaaeaf6ed14fb123ec5f1accb4ec2f76e4658cbb7996ffd1b3c6082ee', '????????????????????????????????????????????????????????????????', '13e03fdec3dcd6a3dcd9acb21fdebdac3bcd7aaa3d2236c9a29933b9d1d15600']
        # ? 위치인 txHashes[17]에 랜덤값으로 생성된 해시값을 넣어줌
            txHashes[17] = txt
    
        mr = "feb9d4d687b883c699ab6b47e1eb9406bf893502b8c8a0aa218acc1b21e31dbe"
    
            # mr 값과 merkle(txHashes)의 반환값이 같다면 Success와 함께 txt값 출력
        if (mr == str(merkle(txHashes), 'ascii')):
            print("Success!")
            print(txt)
    ```

<br>


## Task 02. "nerve extend coyote retreat cage educate nothing tired humble people file region review zero waste" mnemonic이 31337번 째 생성할 주소는 무엇일까요?
- 니모닉(mnemonic)
    - 지갑을 복구하기 위한 일반적인 단어들의 조합
    - 보통 12~24개가 랜덤으로 정해짐
    - 개인키를 대신함
    - 니모닉 단어 생성 프로세스
    - 니모닉 개념 이해 참고자료
        
        - [해시 니모닉을 생성하는 방법 및 장치](https://patents.google.com/patent/KR101290940B1/ko)
        
        - [2주차 공부](https://velog.io/@syapeach4/2주차-공부)
            
- mnemonic을 이용해서 주소 생성하기
    
    ```python
    from web3 import Web3
    
    w3 = Web3()
    
    mnemonic = "nerve extend coyote retreat cage educate nothing tired humble people file region review zero waste"
    
    w3.eth.account.enable_unaudited_hdwallet_features()
    
    acc = w3.eth.account.from_mnemonic(mnemonic, account_path=f"m/44'/60'/0'/0/{31336}")
    print(f"\naddress{31337} = '{acc.address}'")
    print(f"private{31337} = '{Web3.toHex(acc.key)}'")
    ```
    
    [How to create a Web3py account using mnemonic phrase](https://stackoverflow.com/questions/68050645/how-to-create-a-web3py-account-using-mnemonic-phrase)
    
    <aside>
    <blockquote> 💡 Result</blockquote>
    - address31337 = '0xD8371F024078CEcab1C726a1122229855eeCE0f0'<br>
    - private31337 = '0xa2d9e28fb7c5408cd7ce56d009a54f7701dcec972cbb4935dbb163e6e301bbd5'
    </aside>
<br>
    
            
## Task 03. 본인 이름 keccak256 hash 앞 2바이트가 Ethereum 주소와 일치하도록 만들기
- script
    
    ```solidity
    import secrets, codecs, os
    import ecdsa
    from Crypto.Hash import keccak
    
    def gen_private():
        curve_order = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141
    
        while True:
            private_key = secrets.token_hex(32)
            if int(private_key, 16) < curve_order:
                return private_key
    
    def gen_public(private_key):
        private_key_bytes = codecs.decode(private_key, "hex")
        public_key_bytes = (ecdsa.SigningKey.from_string(private_key_bytes, curve=ecdsa.SECP256k1)
                                            .get_verifying_key().to_string())
        public_key = codecs.encode(public_key_bytes, "hex").decode("utf-8")
        return public_key
    
    def gen_address(public_key):
        k = keccak.new(digest_bits=256)
        k.update(codecs.decode(public_key, "hex"))
        k_hash = k.hexdigest()
        address = k_hash[-40:]
        return address
    
    def clear_console():
        if os.name == "nt":
            os.system("cls")
        else:
            os.system("clear")
    
    if __name__ == "__main__":
        first_make = True
    
        name = keccak.new(digest_bits=256)
        name.update("임나라".encode('utf-8'))
    
        address = ''
    
        while (address[:4] != name.hexdigest()[:4]):
            clear_console()
    
            if first_make:
                input(" ")
                first_make = False
            else:
                print()
    
            private_key = gen_private()
            public_key = gen_public(private_key)
            address = gen_address(public_key)
    
            print(" Keccak256   =", name.hexdigest())
            print(" Address     =", address)
    
    ```

    <aside>
    <blockquote> 💡 Result</blockquote>
    - Keccak256   = 4f26f725320e6c1fe41c2d07050b2a33a02d827dab44c366156341f71362f8ba<br>
    - Address     = 4f26bb12173916e4459921d504a02b222eabc4c6
    </aside>


![Untitled](https://file.notion.so/f/s/e985630c-f973-4a7b-864a-9f5b67001409/Untitled.png?id=5662d742-f54b-4035-8eaf-d161ec8d0125&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=gv1yqEddqNk5YzUwXRpuaHs7hKhs_SJDZ-2Srg5HnR0&downloadName=Untitled.png)
<br>

## Task 04. Task 03에서 만든 주소에서 Goerli Testnet 0x1fa6f37f62c745c967ed635d7d6a7240788e4995 로 1337 wei 전송하기
        
![Untitled](https://file.notion.so/f/s/77b4ecee-17bb-4880-8138-292703bc385c/Untitled.png?id=eed5b797-55d4-45c4-96a6-d7130c63e4df&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=4taeE1Sbz5hN3qK8oHFQIP8RUq_JXstfeAcRzk-ELG8&downloadName=Untitled.png)
- 1 WEI = 0.000000000000000001 ETH
- 1337 WEI = 0.000000000000001337 ETH
<br>

## Task 05. 다음 트랜잭션을 분석하고 각 트랜잭션 실행 및 결과가 성공하기 위해서 어떤 요건이 충족되었어야 하는지 서술하세요.
- Tx1: https://etherscan.io/tx/0x5be3d534fb9766936a3e76a9e69ce5d25fd856f01bf595b8778d118814d05ea4

    ![Untitled](https://file.notion.so/f/s/b85c6028-2e5d-4508-b3f4-29a345770c08/Untitled.png?id=7104e0bd-0ab1-4ee4-9680-1afe882bd7c8&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=ahQ-Klg_JZfQYjxXFNDbQQjzN8hw0e1xTrCZeR1Lccc&downloadName=Untitled.png)
    
    - 기본 정보
        - To : 0x3A9FfF453d50D4Ac52A6890647b823379ba36B9E
        - From : 0xe2859334Be46dB836Da81BDA171830a23D408832
        - Value : 0ETH
    - 원인
        - 이더리움에서는 가스비를 더 많이 지불하는 사용자가 트랜잭션을 먼저 전송할 수 있음
        - 다른 사용자에 비해 가스비가 낮으면 트랜잭션 전송 우선순위에서 밀림 → pending 상태
        - 해당 트랜잭션에서는 가스비를 1Gwei만 지불하고 있음
    - 해결 방안
        - 가스비를 더 높인 뒤 전송
        
        ![Untitled](https://file.notion.so/f/s/b66ffa51-ebc9-40cb-8a8d-4cec5c774102/Untitled.png?id=c55f8f0a-bb46-49f5-af3e-24e00ee68ec6&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=_Qv8pEtes22hQu4XAKYPj5zAtcasqTi8auZRERWE9w0&downloadName=Untitled.png)
        
        Reference : [암호화폐 용어 – 이더리움 무한펜딩, 전송지연(Pending), 전송취소 해결방법 3가지(메타마스크, MEW)](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=moon0819&logNo=222098662957)
        
- Tx2: https://goerli.etherscan.io/tx/0x98c5df74dca12c113530a0bb6336fa55fd80073461a5acfabbeea01ab4cb82e2
    
    ![Untitled](https://file.notion.so/f/s/002aaf8b-1cfd-4f07-8284-816eed6e9441/Untitled.png?id=e6038b45-b5bb-4832-8063-3cf8f8759b31&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=AUO-3oqnLQIfsmV5tzDZ_Wd5n3r26S9kcKWoHtjJuIM&downloadName=Untitled.png)
    
    - 기본 정보
        - To : 0x410601dD6B4375C0723C1C0d0924e55cAeA324aa
        - From : 0xd63f66B0C0ccE2f3906CF98128dD7eF566922204
        - Value : 0.01ETH
    - 원인
        - 오류 메시지 → out of gas가 원인
        - 트랜잭션 실행 당시, 전송하는 사람의 가스 부족할 때 발생하는 오류
        - 즉, 트랜잭션을 수행하는데 필요한 필수 가스보다 작아서 트랜잭션 전송에 실패하게 된 것!
    - 해결 방안
        - 트랜잭션 전송에 필요한 충분한 ETH를 번 후 트랜잭션을 전송
        
        ![Untitled](https://file.notion.so/f/s/42e7a378-1ce5-439a-b6d2-1fec9f42e825/Untitled.png?id=dfbf0919-a9cc-45b5-828e-9ea362d89500&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=lAM_nrPKSO9_TVoI7P7AoCkLsOKVrOW1MYRX4K1a-e4&downloadName=Untitled.png)
        
- Tx3: https://goerli.etherscan.io/tx/0xfe2ffc52247501c024c1e629af182761d4427bfa1f3d87e98efbf2f701f5047e
    
    ![Untitled](https://file.notion.so/f/s/0286891b-7b35-437f-97ad-c36db053cda9/Untitled.png?id=8a1be7e9-3cd6-4d19-af4f-0438313e0d14&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=nUe-_V0R4GZPw2iiywoT1f1d9ZZltAipV6GxpjSZorM&downloadName=Untitled.png)
    
    - 기본 정보
        - To : 0x410601dD6B4375C0723C1C0d0924e55cAeA324aa
        - From : 0xd63f66B0C0ccE2f3906CF98128dD7eF566922204
    - 원인
        
        ![Untitled](https://file.notion.so/f/s/3ab3af8d-2f88-47dc-8b85-b01a1e5085eb/Untitled.png?id=3bfcc21e-039f-4cec-9e42-e65ca7dc5a6d&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=99sIkEIxaC05xqbBz1q8XLocUhr2PVzzzRPKLG_hUpE&downloadName=Untitled.png)
        
        - 오류 메시지 → execution reverted가 원인
            - revert()
                - 스마트 컨트랙트 코드 실행 중 revert 함수를 만나면 프로그램 실행이 중단되고, 가스비를 환불해준다.
        - 스마트 컨트랙트의 요구조건을 만족하지 못할 때 발생
            - contract
                - Bytecode
                    
                    ![Untitled](https://file.notion.so/f/s/800eeb13-65ae-4c11-83d7-93fcd2a130c4/Untitled.png?id=fbc4d0e4-f623-41bf-81a6-a666a4140e94&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=i_Cts-HkP41VBBfqiiIsV9HE4ZO5l7lWz5C1rAspY9Q&downloadName=Untitled.png)
                    
                - Decompile
                    
                    ![Untitled](https://file.notion.so/f/s/70bf158f-9a16-4a81-a04d-57610226ace6/Untitled.png?id=05d9b7bc-e540-4811-a4d1-b4ebe3fa7b75&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=4OWMNpwWVxavrvjr6VYiSBwDT_tncU--uH-CUOc6VvY&downloadName=Untitled.png)
                    
                    - Decomfile 결과, fallback 함수가 실행되고 있음
                    - fallback
                        - fallback 함수는 컨트렉트의 호출 함수가 확인되지 않을 때, 함수에서 이더를 보낼 때(transfer) 디폴트 함수로 동작한다
                            1. 호출한 함수가 컨트랙트에 존재하지 않을 때 실행(해당 컨트랙트 내에 함수들의 시그니쳐와 매칭되는 것이 없을 때 실행)
                            2. 이더는 받았는데 데이터는 받지 못했을 때 실행
        - contract 확인 결과, fallback 함수가 실행되어 오류가 발생한 것을 알 수 있음
        - fallback 함수 실행 원인
            
            ![Untitled](https://file.notion.so/f/s/8ffbe59b-b8b6-4dcd-b2da-83937ac9bd78/Untitled.png?id=1afb6332-0c58-4eaa-b423-7b2fb28b20f4&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=hor4gw7k2JohZ5Nvjo5S3kQrUJ9MHbMellYdsowwkAo&downloadName=Untitled.png)
            
            - input data를 보면 0x 만 기록되어 있음
                
                → input data가 없다!
                
            - 이더는 받았는데 데이터는 받지 못해서 발생한 것으로 생각해볼 수 있음
    - 해결 방안
        - mint 함수 호출 → 아직 이해하는 중..!
            
        Reference : [contract write function has no input data(0x)](https://ethereum.stackexchange.com/questions/130936/contract-write-function-has-no-input-data0x)
<br>
                    
## Task 06. Bitcoin과 Ethereum의 각 공개키 생성 방법을 서술하시오.
### Cryptographic Keys
- 대칭키 암호화
    - 암복호화 키가 동일한 암호화 방식
    - 키 교환 문제 → 탈취 가능성 위험성
    - 종류 : DES, 3DES, AES, SEED, ARIA 등
- 비대칭키 암호화
    - 공개키 : 모든 사람이 접근 가능함 / 개인키 : 사용자만 가지고 있는 키
    - 키 교환 문제 해결
    - 원리 : A가 B의 공개키로 데이터를 암호화해서 보내면 B는 본인의 개인키로 복호화 해서 데이터 확인
    - usage : Diffie-Hellman, RSA, DSA, ECC 등
<br>

### ECC(Elliptic Curve Cryptography)
- 타원곡선을 기반으로 하는 공개키 암호기술 구현 방식
- RSA 암호방식에 대한 대안으로 제안된 방식
- 더 작은 데이터(적은 bit 수)의 암호키로 동일한 암호성능을 나타냄
→ bit 수가 적으면 연산이 빠르게 됨
→ 암호 연산 성능이 좋아짐
- 타원곡선방정식
    - 방정식
        
        $$
        y^2 = x^3 + ax + b
        $$        
- secp256k1
    - 비트코인과 이더리움에서는 a = 0, b = 7을 사용        

        $$
        y^2 = x^3 + 7
        $$
        
- G(base point, generator point)
    - 타원곡선 위의 임의의 값
    - 블록체인을 이용하는 모든 사람이 같은 값을 알고 있어야 함
    - 비트코인과 블록체인에서 G = 0279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798를 사용
<br>

### 키 생성
- 개인키
    - 256비트 길이의 랜덤한 숫자로 구성되어 있음
    - 주로 64자리의 16진수
    - 트랜잭션 발생 주체 검증
        - 개인키로 서명한 트랜잭션을 공개키로 검증
        → Digital ID 같은 느낌!
        - 입출금과 관련된 자금에 대한 소유권을 통제할 수 있음
    - 절대 유출되면 안됨!!
- 공개키
    - 타원곡선암호로 생성됨 → secp256k1
    - 소유권을 증명하거나 코인을 전송 받을 때 공개키 암호화 사용
    - 개인키를 통해 디지털 서명을 하고, 공개키로 서명의 유효성 확인
    - 공개키를 분실하더라도 개인키로부터 공개키를 다시 만들 수 있음(단방향)
    - 공개키 생성 과정
        
        ![Untitled](https://file.notion.so/f/s/b12e6200-7664-400d-be8a-27a91d742203/Untitled.png?id=0635d976-de70-4e11-b788-55c056cf66a3&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=JT822ers4nJMeDRpw1_BB68_fcxd66smqBYlHhwgnTA&downloadName=Untitled.png)
        
        <aside>
        <blockquote> 💡 K = k * g </blockquote>
        - K = 공개키<br>
        - k = 개인기<br>
        - g = 타원 곡선 위의 임의의 값(모든 사람이 같은 같은 값을 볼 수 있음)<br>
        </aside>
        1. 타원곡선과 접점인 점의 접선 구하기(G, -2G)
        2. 접선과 만나는 점에 대칭점 구하기 (-2G, 2G)
        3. 이 과정을 k번 반복해서 K 찾기 → public key 생성
    - 종류
        - Uncompressed
            - x, y 좌표 모두 사용
            - 트랜잭션의 크기가 커짐 → 더 많은 수수료 지불
            - 형식 : 04<x><y> → 520bits
        - Compressed
            - x 좌표만 사용
            - 타원은 x축을 기준으로 대칭이기 때문에 y값이 2개임
            - 최근에는 주로 compressed key를 사용함
            - 형식
                - Y가 짝수 : 02<X> → 264bits
                - Y가 홀수 : 03<x> → 264bits

### 비트코인과 이더리움
1. 이더리움 주소
    - 비트코인
        - mainnet과 testnet의 주소가 다름
            - 지갑 및 체크섬 생성 과정에서 추가하는 prefix 값이 다름
            - mainnet은 0x00, testnet은 0x6f
        - 주소 만들기
            
            ![Untitled](https://file.notion.so/f/s/b7ea9400-df0e-4007-8be1-8b1d684dc4aa/Untitled.png?id=aab5c5c2-8b97-431e-bea1-8ff44ec8696c&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693396800000&signature=4tyPrcbFKZyPht48-JYkHwoHRs4e4vSLwOg_XKVyZDw&downloadName=Untitled.png)
            
            - 공개키를 sha256 해싱하고, 해당 결과를 ripemd-160 해시 → 160비트 크기의 공개키 HASH 생성
            - 맨 앞에는 prefix 추가(0x00)하고, 맨 뒤에는 checksum을 추가해줌
                
                → 0x00 + 공개키 HASH + checksum
                
            - base58check 인코딩
    - 이더리움
        - 기본+모든 네트워크에서 동일한 주소를 가지고 있음
        - 사용자가 사용할 네트워크를 선택할 수 있음
        - 주소 만들기
            - 공개키를 keccak256으로 해시 → 마지막 20바이트 사용
            - 위 과정을 통해 나온 결과에 0x 붙이기
2. checksum
    - 비트코인
        - 체크섬으로 주소에 대한 유효성 검사
        - 비트코인 주소를 만들 때 base58 encoding하기 전에 수행
        - checksum 생성 과정
            - 주소를 만들 때 생성된 160 bit 크기의 공개키 HASH의 맨 앞에 16진수 바이트 추가
            - 위 과정을 통해 나온 결과에 SHA256를 두 번 적용하고 나온 값의 앞에 4바이트가 checksum
    - 이더리움
        - 비트코인에 비해 간단하게 생성됨
        - 체크섬 메커니즘
            - 주소를 keccak256으로 해시 → 0x 떼기
            - 이더리움 주소에서 소문자를 대문자로 바꿔줌
            - 위 과정을 통해 나온 결과에 0x 붙인 것이 checksum

https://brunch.co.kr/@doyoulovez/7
        
## Task 07. 다음 BeaconScan의 slot을 분석하고 각 항목들의 의미를 서술하시오.(https://beaconscan.com/slot/5943000)
- 개념 정리
    - Beacon Chain
        - 이더리움 2.0의 PoS 시스템 체인
            - 고정된 보증금(32ETH)를 예치하여 등록하면 누구나 검증인으로 참여할 수 있음
            - 예치금을 내면, 대기 프로세스와 비콘 프로세스에 의해 처리됨
        - PoS 활성 검증인 집단을 저장하고 관리함
            - 어떤 validator가 블록을 제안/증명할지
            - 참여자의 행동에 따른 보상 및 제제
        - 매 epoch마다 검증자를 slot으로 나누고, 각 slot당 최소 128개의 검증자를 위원회로 할당
    - slot : 블록 제안자가 증명할 블록을 제안하는 기간
        - slot != 블록의 개수
    - Randao
        - 탈중앙화 된 방식으로 난수를 생성하기 위한 방법
        - 검증자가 제안자/위원회로 결정될 때 사용하는 의사난수 과정
        - 공격의 위험 방지
- 항목
    - slot : 해당 블록이 생성되는 slot
    - Epoch Number : 현재 slot의 epoch
    - Status : 현재 slot의 상태
    - Age : 현재 슬롯의 날짜 및 시간
    - Proposer : 현재 블록을 제안한 사람
    - BlockRoot Hash : 해당 slot의 32바이트 크기의 해시값
    - ParentRoot Hash : 상위 slot의 32바이트 크기의 해시값
    - State Root : 해당 slot 처리 후 결과 상태의 32바이트 크기의 해시값
    - Randao Reveal : 제안자/위원회 등을 선정하기 위한 랜덤값
    - Graffiti : 32바이트 크기의 임의의 데이터 공간 → validator에 원하는 그래비티(그림?)를 넣을 수 있음
    - Eth_1BlockHash : 이더리움 1.0 블록의 해시값(보증금도 고려)
    - Eth_1 Deposit Root : 해당 블록에 포함되어 있는 마지막 Deposit에 대한 32바이트 크기의 deposit 트리의 해시값
    - Eth_1 Deposit Count : 해당 블록을 포함하여 제네시스 블록부터 지금까지 beacon chain에 deposit된 금액의 총 합
    - Signature : 블록을 생성한 validator의 BLS 서명
    - Slashing P/A : proposer와 attester가 slashing 여부
        - slashing : 검증자가 악의적인 행동을 하면 벌칙 줌
            - PoS에서 Validator의 악의적인 행위를 방지하기 위한 것
                
                → 블록체인 네트워크가 원활하게 돌아가는데 방해하는 Validator한테 페널티
                
            - 지분 금액의 일정 비율에 대해 벌금 부과
            - 악의적인 행위
                - Downtime : 정해진 시간 안에 서명하지 않는 것
                - Double-Singing : 두 개의 다른 블록에 동시에 서명하는 것
                
- 참고자료
    
    [The Beacon Chain | ethereum.org](https://ethereum.org/en/upgrades/beacon-chain/)
    
    [슬롯 (블록체인) - 해시넷](http://wiki.hash.kr/index.php/슬롯_(블록체인))
    
    [No.1 가상자산 플랫폼, 빗썸 - Bithumb 카페](https://cafe.bithumb.com/view/board-contents/1639737)
    
    [이더리움 비콘 체인 이해하기](https://medium.com/decipher-media/이더리움-비콘-체인-이해하기-c0d6a80f3ecf)
