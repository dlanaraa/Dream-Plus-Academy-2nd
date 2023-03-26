# DEX Auditing

## 01. SWAP 연산 오류
 
### 1.1 해당 코드
<pre>
<code>
if(tokenXAmount > 0){
  uint256 x_value = tokenXAmount / 1000 * 999;
  amountY = k / (amountX + x_value);
  outputAmount = reserveY - amountY;

  require(outputAmount < amountY, "amountY is less than outputAmount");
  require(tokenMinimumOutputAmount < outputAmount, "you claim too much token");
  X.transferFrom(msg.sender, address(this), tokenXAmount);
  Y.transfer(msg.sender, outputAmount);
 }
 else{
  uint256 y_value = tokenYAmount / 1000 * 999;
  amountX = k / (amountY + y_value);
  outputAmount = reserveX - amountX;

  require(outputAmount < amountX, "amountX is less than outputAmount");
  require(tokenMinimumOutputAmount < outputAmount, "you claim too much token");
  Y.transferFrom(msg.sender, address(this), tokenYAmount);
  X.transfer(msg.sender, outputAmount);
}
</code>
</pre>
- hyeon777/Dex/src/Dex.sol/swap() line 26, line 36

### 1.2 설명
- 솔리디티에서 부동 소수점을 지원하지 않기 때문에 위 코드에서는 tokenXAmount(tokenYAmount)가 1000 wei보다 작은 값이 될 경우 x_value(y_value)는 0이 됨
![Untitled](https://user-images.githubusercontent.com/127647283/227752082-daa70fc7-6585-4bc1-952e-863449bbc9a4.png)


### 1.3 파급력
- 본인이 생각하는 심각도 : Low
- 300 wei를 swap하는 test code 작성해서 확인해본 결과, outputAmount를 산정하는 과정에서 오류가 생겨 최솟값을 검증하는 require문을 통과하지 못한다.
- 1000 wei보다 작은 금액에 대해 스왑을 하지 못하는 것이기 때문에 기능적 오류를 발생시키는 정도의 버그라고 생각한다.

### 1.4 해결방안
- 999를 먼저 곱해 충분히 큰 수를 만들어준 후 1000을 나눠주는 순서로 연산식을 수정해준다.
![image](https://user-images.githubusercontent.com/127647283/227752280-60ba49e5-4940-48c6-9e7d-40bfe71be3a4.png)

<br/>

<br/>

## 02. 유동성 공급 시 pool 비율 고려 X

### 2.1 해당 코드
- jw-dream/Dex_solidity/src/Dex.sol/addliquidity()
- Gamj4tang/DEX_solidity/src/Dex.sol/addliquidity()
- kumziwu/DEX_solidity/src/Dex.sol/addLiquidity()
- hangi-dreamaer/Dex_solidity/src/Dex.sol/addLiquidity()
- jun4n/DEX-solidity/src/Dex.sol/addLiquidity()
- seonghwi-lee/Lending-DEX_solidity/src/Dex.sol/addLiquidity()
- hyeon777/DEX_Solidity/src/Dex.sol/addLiquidity()
- jt-dream/Dex_solidity/src/Dex.sol/addLiquidity()

### 2.2 설명
- DEX에 유동성을 공급할 때에는, 현재 풀의 비율에 맞춰서 공급해줘야 하는데 이를 구현하지 않고 있음

### 2.3 파급력
- 본인이 생각하는 심각도 : high
- 의도적으로 특정 토큰을 많이 공급해서 pool의 비율을 깨트리게 만듦
 -> remove할 때 현재 pool에 있는 reserve token을 이용해서 회수할 토큰을 계산하는데 pool의 비율이 깨지면 잘못된 값을 산정하게 됨
- 이를 악용하면 현실에서 더 비싼 토큰을 더 싸게 사거나, 비싸게 파는 등의 차익 거래 가능

### 2.4 해결 방안
- reserveX:reserveY = tokenXAmount:tokenYAmount 식을 사용하여 pool 비율에 토큰을 받으려면 얼마큼 받아야 하는지 구하고, tokenXAmount나 tokenYAmount 값이 많거나 작은 경우 revert를 발생시키거나 반환해주는 식으로 코드 작성

<br/>

<br/>

## 03. ERC20 기반의 LP 토큰 사용 X

### 3.1 해당 코드
- jw-dream/DEX_solidity/src/Dex.sol

### 3.2 설명
- addLiquidity나 removeLiquidity 함수를 보면 LPToken_balances나 total Liquidity 같은 변수들로 LP 토큰을 지급하는 것처럼 보임 (코드상)
- 하지만 문제 조건이었던 ERC20 토큰을 이용하여 토큰을 발행하거나, 소각하는 등의 과정이 포함되어 있지 않음

### 3.3 파급력
- 본인이 생각하는 심각도 : information
- 유동성 공급에 따른 보상을 아예 구현하지 않은 것이 아니고 요구사항에 있는 기능(ERCO20)이 구현되어 있지 않은 정도의 버그라고 생각함.

### 3.4 해결 방안
- ERC20 기반의 LP 토큰을 생성하여 상황에 따라 이를 공급하고 회수하는 식으로 코드를 수정하면 될 것 같음.

<br/>

<br/>

## 04. 불충분한 검증 (removeLiquidity)
### 4.1 해당 코드
- koor00t/DEX_solidity/src/Dex.sol/removeLiquidity()
- jt-dream/Dex_solidity/src/Dex.sol/removeLiquidity()
- hyeon777/DEX_Solidity/src/Dex.sol/removeLiquidity()

### 4.2 설명
- removeLiquidity에서 msg.sender가 가지고 있는 LPToken 양이 LPTokenAmount보다 작은지 확인하는 구문이 부재함.
- 해당 기능은 요구사항에 기재되어 있는 기능으로, 요구사항이 제대로 구현되지 않음

### 4.3 파급력
- 본인이 생각하는 심각도 : midium
- msg.sender가 유동성을 공급할 때 받은 token의 양보다 더 큰 값을 입력으로 주면 본인이 공급한 금액보다 더 많은 토큰을 탈취할 수 있게 됨
 -> 아래 있는 burn에서 오류가 발생하긴 하지만, transfer는 정상적으로 보내지는 것 같아서 관련해 test code 작성하여 test 해보고 있는 중


### 4.4 해결 방안
- require(balanceOf(msg.sender) >= LPTokenAmount) 구문 추가

</br>

</br>

## 06. 유동성 회수 과정에서 LP Token 관련 기능 부재
### 6.1 해당 코드
- hangi-dreamer/Dex_solidity/src/Dex.sol/removeLiquidity()
- jw-dream/Dex_solidity/Dex.sol/removeLiquidity()

### 6.2 설명
- removeLiquidity 함수는 addLiquidity에서 공급한 유동성을 다시 회수하는 함수로, 유동성을 공급한 대가로 받은 lpToken을 반납(회수)하고, 공급한 토큰을 다시 돌려받는 기능이 구현되어 있어야 함
- 하지만 해당 코드에는 LPToken 회수, LPToken 소각, 토큰(X, Y) 전송 등의 과정이 부재함
+) removeLiquidity() line156에서 rx에 대한 최소값 검증을 두번 진행하고 있으며, ry에 대한 최소값 검증은 진행되지 않음 (오타 같음 ..)

### 6.3 파급력
- 본인이 생각하는 심각도 : Critical
- DEX의 유동성을 회수할 때 구현되어야 하는 주요 기능들이 부재
- burn을 해주지 않을 경우 유동성을 회수하더라도 totalSupply 값이 변화되지 않고, 이는 removeLiquidity에서 반환해줄 토큰의 양을 산정할 때 사용되는 요소이기 때문에 제대로 된 가격 산정을 하지 못하게 될 가능성이 있다. 또한, DEX 사용자는 유동성을 공급은 했는데 이걸 다시 회수할 수 없게 된다. 

### 6.4 해결 방안
- rx, ry 값을 transfer함수를 이용해서 msg.sender에게 보내준다 -> IERC20(_tokenX).transfer(msg.sender, rx); IERC20(_tokenY).transfer(msg.sender, ry);
- msg.sender에게 회수한 LP Token 소각 -> burn(msg.sender, LPTokenAmount)
- 최소값 검증 -> require(ry >= minimumTokenYAmount);

</br>

</br>

## 07. transfer visibility

### 7.1 해당 코드
<pre>
<code>
function transfer(address to, uint256 lpAmount) override public returns (bool){
  _mint(to, lpAmount);
  return true;
}
</code>
</pre>
- kimziwu/DEX_solidity/src/Dex.sol/transfer()
- hangi-dreamer/Dex_solidity/src/Dex.sol/transfer()
- jt-dream/Dex_solidity/src/Dex.sol/transfer()
- koor00t/DEX_solidity.src/Dex.sol/transfer()

### 7.2 설명
- transfer 함수에서 mint를 해주고 있는데 transfer가 public으로 되어 있어서 그냥 아무나 다 transfer를 호출하고, LP Token을 mint할 수 있음

### 7.3 파급력
- 본인이 생각하는 심각도 : Ciritical
- 8.2에 작성했듯이, 해당 함수를 호출하는 사람은 누구나 LP Token을 minting할 수 있기 때문에 심각도가 높다고 생각함

### 7.4 해결방안
- transfer를 호출하는 사람이 DEX일 때만 mint해주도록 require문 추가
 -> require(msg.sender == address(this, "~");

## +) pool에 공급한 것보다 더 많은 금액 탈취 가능 (테스트 코드 작성해서 테스트 해보는 중)

![image](https://user-images.githubusercontent.com/127647283/227753529-4dcb973c-6a0e-4b76-a7e7-256e73155032.png)
- 위 test code를 작성해서 돌려본 결과, user2가 공급한 2000 ether보다 더 큰 값(3000 ether)를 빼올 수 있었음.
  -> add liquidity에서 발급 받은 lptoken의 양이 2000 ether보다 크기 때문에 가능했던 것 같음
- msg.sender가 가지고 있는 LPToken의 양이 LPTokenAmount보다 작은 경우 revert 시켜주는 require문을 작성하지 않은 코드에서는 msg.sender가 DEX에 공급한 것보다 더 많은 금액을 탈취할 수 있을 것이라는 생각이 드는데 아직 테스트 해보는 중..


## +) pool에 공급한 금액 내에 remove를 할 때 removeLiquidity가 제대로 동작하지 않음
![image](https://user-images.githubusercontent.com/127647283/227783846-37f85a25-f051-4540-bcf2-d72251097d58.png)
- test code : dex에 1000 ether, 2000 ether를 차례로 공급하고, 1000 ether를 회수하는 코드
- Assertion failed가 떠서 log를 확인해본 결과, rx와 ry를 도출해내는 과정에 문제가 있는 것으로 보이나 아직 정확한 원인은 파악하지 못함.
