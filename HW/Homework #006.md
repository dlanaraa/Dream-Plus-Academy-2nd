## Task 01. ETH1/2 Finality 비교하기

### Finality
- 한 번 블록체인에 기록된 거래는 절대 되돌려질 수 없고 수정할 수 없다!
- 확률적 Finality
    - 시간이 지날 수록 블록들이 쌓이고, 그만큼 블록을 되돌릴 수 있는 확률이 줄어든다.
- 절대적 Finality
    - 한 번 체인에 연결되면 절대로 그 블록을 되돌릴 수 없다.

### ETH1 → PoW 합의 알고리즘
- PoW에서는 많은 블록이 생성될 수록 Finality를 보장하게 됨
    
    → 시간이 지날 수록 합의 결과가 뒤집어질 확률이 적어짐
    
    → 확률적 Finality
    
- 가장 긴 체인 알고리즘
    - 서로 다른 채굴자가 동시에 채굴에 성공하면? → 포크 발생
    - 더 긴 쪽을 메인 체인으로 선택하고, 짧은 쪽은 Rollback → Finality를 보장하기 어려움
    - 포크 발생 이전의 블록에 대해서는 Finality를 보장할 수 있지 않은가?
        - 이미 포크 되서 버려진 체인에 연결해서 그걸 가장 긴 체인으로 만들게 되면 문제가 됨
- 보통 6개의 이상의 블록이 생성됐을 경우 Finality를 보장할 수 있다고 할 수 있음

### ETH2 → PoS 합의 알고리즘
- PoS에서는 checkpoint 마다 Validator가 블록을 검증함
    
    → 2/3 이상이 검증을 마치면 Finality를 보장하게 됨
    
- checkpoint 이전의 블록은 절대 되돌릴 수 없음
    - 가장 긴 체인을 만든다고 하더라도, checkpoint 이전의 블록이라면 아무 소용 없음
- PoW를 보완한 방법이긴 하지만 PoS도 확률적 Finality이긴 함

<br>

## Task 02. TWAP 구해보기

<aside>
💡 가격을 1분 간격으로 30분 동안 기록한 것은 다음과 같습니다.
[1340, 1520, 1960, 1820, 686, 1177, 1612, 1368, 1803, 624, 1776, 1857, 1908, 926, 1915, 904, 1766, 567, 1709, 1269, 1361, 1982, 1925, 1779, 1034, 873, 715, 790, 954, 750]
TWAP Interval은 10분일때 마지막 거래가 발생한 직후의 TWAP 값을 구하세요. 풀이 과정도 쓰세요.
</aside>

### TWAP(Time Weighted Average Price, 시간 가중 평균)
- tp = (open + high + low + close) / 4
- twap = (tp1 + tp2 + … + tpn) / n

### 풀이과정
    
<aside>
💡 tp1 : [1340, 1520, 1960, 1820, 686, 1177, 1612, 1368, 1803, 624]<br>
💡 tp2 : [1776, 1857, 1908, 926, 1915, 904, 1766, 567, 1709, 1269]<br>
💡 tp3 : [1361, 1982, 1925, 1779, 1034, 873, 715, 790, 954, 750]<br><br>
</aside>
    
- Interval 평균 : (open + high + low + close) / 4
    - tp0 : 1340
    - tp1 : (1340 + 1960 + 624 + 624) / 4 = 1137
    - tp2 : (1776 + 1915 + 567 + 1269) / 4 = 1381
    - tp3 : (1361 + 1982 + 715 + 750) / 4 = 1202
- cumulative value : 이전 c값 + 이전 tp 값 * time
    - tp0 : 0
    - tp1 : 0 + 1340 * 10 = 13400
    - tp2 : 13400 + 1137 * 10 = 24770
    - tp3 : 24770 + 1381 * 10 = 38580
- TWAP
    - 38580 / 30 = 1286

Reference : [A Guide on Uniswap v3 TWAP Oracle](https://tienshaoku.medium.com/a-guide-on-uniswap-v3-twap-oracle-2aa74a4a97c5)

<br>

## Task 03. 무엇을 선택하는게 더 유리한가?**
- 드리머 홍길동씨는 XYZ 토큰을 보유한 재단과 업무를 진행하기로 하였다.
- XYZ 토큰을 보유한 재단은 홍길동씨가 업무한 대가로 $10,000에 상응하는 XYZ토큰을 제공하기로 하였다.
- 재단은 홍길동씨에게 $10,000에 상응하는 XYZ 토큰의 갯수를 계산하기 위해서 사용하는 가격을 3일 전 종가 TWAP 또는 전일 종가 가격 중 하나를 고르라고 하는데, 시장 상황에 따라 어떤 선택을 하는게 유리한지 가능한 경우를 모두 작성하세요.

<br>

## Task 04. DEX 만들기
- CPMM (xy=k) 방식의 AMM을 사용하는 DEX를 구현하세요.
- Swap : Pool 생성 시 지정된 두 종류의 토큰을 서로 교환할 수 있어야 합니다. Input 토큰과 Input 수량, 최소 Output 요구량을 받아서 Output 토큰으로 바꿔주고 최소 요구량에 미달할 경우 revert 해야합니다. 수수료는 0.1%로 하세요.
- Add / Remove Liquidity : ERC-20 기반 LP 토큰을 사용해야 합니다. 수수료 수입과 Pool에 기부된 금액을 제외하고는 더 많은 토큰을 회수할 수 있는 취약점이 없어야 합니다. Concentrated Liquidity는 필요 없습니다.
- 주요 기능 인터페이스는 아래를 참고해 만드시면 됩니다.
    - function swap(uint256 tokenXAmount, uint256 tokenYAmount, uint256 tokenMinimumOutputAmount) external returns (uint256 outputAmount);
        - tokenXAmount / tokenYAmount 중 하나는 무조건 0이어야 합니다. 수량이 0인 토큰으로 스왑됨.
    - function addLiquidity(uint256 tokenXAmount, uint256 tokenYAmount, uint256 minimumLPTokenAmount) external returns (uint256 LPTokenAmount);
    - function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) external;
    - function transfer(address to, uint256 lpAmount) external returns (bool);

- 진행 상황
![Untitled](https://file.notion.so/f/s/d433e8a5-e930-43d7-908e-271254b8da4b/Untitled.png?id=b7392b72-be9c-4e53-8d16-8b963ec65a96&table=block&spaceId=e22d3740-ccb0-45be-94fb-71b2a782635c&expirationTimestamp=1693404000000&signature=si4qHGDvX-3tOkdMoQksn-T3gpvUuBD1thHl2idjjcw&downloadName=Untitled.png)

## Task 05. Lending 서비스 만들기
- ETH를 담보로 사용해서 USDC를 빌리고 빌려줄 수 있는 서비스를 구현하세요. → 과담보
- 이자율은 24시간에 0.1% (복리), Loan To Value (LTV)는 50%, liquidation threshold는 75%로 하고 담보 가격 정보는 “참고코드"를 참고해 생성한 컨트랙트에서 갖고 오세요.
- 필요한 기능들은 다음과 같습니다. Deposit (ETH, USDC 입금), Borrow (담보만큼 USDC 대출), Repay (대출 상환), Liquidate (담보를 청산하여 USDC 확보)
- 청산 방법은 다양하기 때문에 조사 후 bad debt을 최소화에 가장 적합하다고 생각하는 방식을 적용하고 그 이유를 쓰세요.
- 실제 토큰을 사용하지 않고 컨트랙트 생성자의 인자로 받은 주소들을 토큰의 주소로 간주합니다.
- 주요 기능 인터페이스는 아래를 참고해 만드시면 됩니다.
    - function deposit(address tokenAddress, uint256 amount) external;
    - function borrow(address tokenAddress, uint256 amount) external;
    - function repay(address tokenAddress, uint256 amount) external;
    - function liquidate(address user, address tokenAddress, uint256 amount) external;
    - function withdraw(address tokenAddress, uint256 amount) external;
