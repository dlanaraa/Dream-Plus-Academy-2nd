// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Dex is ERC20 {
    ERC20 public _tokenX;
    ERC20 public _tokenY;
    uint256 _amountX;
    uint256 _amountY;
    mapping(address => uint256) _amountLPT;

    constructor(address tokenX, address tokenY) ERC20("LPT", "LPT") {
        _tokenX = ERC20(tokenX);
        _tokenY = ERC20(tokenY);        
    }

    //Swap
    //Pool 생성 시 지정된 두 종류의 토큰을 서로 교환할 수 있어야 합니다.
    //Input 토큰과 Input 수량, 최소 Output 요구량을 받아서 Output 토큰으로 바꿔주고
    //최소 요구량에 미달할 경우 revert 해야합니다. 수수료는 0.1%로 하세요
    //tokenXAmount / tokenYAmount 중 하나는 무조건 0이어야 합니다.
    //수량이 0인 토큰으로 스왑됨
    function swap(uint256 tokenXAmount, uint256 tokenYAmount, uint256 tokenMinimumOutputAmount) external returns (uint256 outputAmount){
        //둘 중 하나는 무조건 0이어야 함
        require(tokenXAmount == 0 || tokenYAmount == 0, "must have 0 amount token");
        require(_amountX >= 0 && _amountY >= 0, "can't swap");

        uint256 outputAmount;

        // tokenXAmount가 user한테 y를 받아서 x를 주는 것
        if(tokenXAmount < 0){      
            // xy = (x-dx)(y+dy) -> dx = (x * dx) / (y + dx)
            // 선행 수수료
            outputAmount = _amountX * (tokenYAmount * 999 / 1000) / _amountY + (tokenYAmount * 999 / 1000);
            
            // 최소값 검증
            require(outputAmount >= tokenMinimumOutputAmount, "less than Minimum");

            _amountX -= outputAmount;
            _amountY += tokenYAmount;

            // 보내기
            _tokenX.transferFrom(msg.sender, address(this), tokenYAmount);
            _tokenY.transfer(msg.sender, outputAmount);

        } else if(tokenYAmount < 0){       // tokenYAmount가 0이니까 user한테 X받아서 y주는 것
            // xy = (x-dx)(y+dy) -> dy = (y * dx) / (x + dx)
            outputAmount = _amountY * (tokenXAmount * 999 / 1000) / _amountX + (tokenXAmount * 999 / 1000);

            require(outputAmount >= tokenMinimumOutputAmount, "less than Minimum");

            _amountY -= outputAmount;
            _amountX += tokenXAmount;

            _tokenY.transferFrom(msg.sender, address(this), tokenXAmount);
            _tokenX.transfer(msg.sender, outputAmount);
        } else {
            revert();
        }
        return outputAmount;
    }

    //addLiquidity, removeLiquidity
    //ERC-20 기반 LP 토큰을 사용해야 합니다. 
    function addLiquidity(uint256 tokenXAmount, uint256 tokenYAmount, uint256 minimumLPTokenAmount) external returns (uint256 LPTokenAmount){
        // 0개 공급은 안됨
        require(tokenXAmount > 0, "tokenXAmount is 0");
        require(tokenYAmount > 0, "tokenYAmount is 0");
        // msg.sender가 dex한테 tokenX와 tokenB에 대한 권한을 줘야함 -> pool에 공급하는 양 만큼!
        require(_tokenX.allowance(msg.sender, address(this)) >= tokenXAmount, "ERC20: insufficient allowance");
        require(_tokenY.allowance(msg.sender, address(this)) >= tokenYAmount, "ERC20: insufficient allowance");
        // msg.sender의 token 보유량이 공급하려는 양보다 많아야 함
        require(_tokenX.balanceOf(msg.sender) >= tokenXAmount, "ERC20: transfer amount exceeds balance");
        require(_tokenY.balanceOf(msg.sender) >= tokenYAmount, "ERC20: transfer amount exceeds balance");

        // 유동성을 공급한 msg.sender한테 줄 보상
        uint reward;

        // totalSupply가 0이면 else if문의 연산이 안되니까 따로 설정해줌
        if (totalSupply() == 0) 
        {
            reward = tokenXAmount * tokenYAmount;
        } 
        // 같은 양을 넣더라도 넣는 시점의 상황을 고려해서 reward를 해줘야 함 -> totalSupply 값을 이용해서 LPT 계산
        // 수수료나 뭐 .. 그런 ?
        else if (totalSupply() != 0) 
        {
            reward = tokenXAmount * totalSupply() / _amountX;
        }
        
        // 인자로 받은 LP토큰 최소값보다 작으면 revert
        require(reward >= minimumLPTokenAmount, "less than minimum");
        // 만족하는 경우 msg.sender한테 LPT 토큰 발행해줌
        _mint(msg.sender, reward);
        _amountLPT[msg.sender] += reward;

        // msg.sender가 공급해준만큼 amountX(Y)를 추가해줌
        _amountX += tokenXAmount;
        _amountY += tokenYAmount;

        //transferFrom으로 msg.sender의 토큰을 DEX로 가져옴
        _tokenX.transferFrom(msg.sender, address(this), tokenXAmount);
        _tokenY.transferFrom(msg.sender, address(this), tokenYAmount);

        return reward;
    }

    //수수료 수입과 Pool에 기부된 금액을 제외하고는
    //더 많은 토큰을 회수할 수 있는 취약점이 없어야 합니다.
    function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) public returns (uint, uint) {
        require(LPTokenAmount > 0, "less LPToken");
        require(_amountLPT[msg.sender] >= LPTokenAmount, "less LPToken");
        
        uint fee;
        
        uint256 _returnX;
        uint256 _returnY;

        //remove할 때 수식 이해하는 중


        require(minimumTokenXAmount>= _returnX, "less than minimum");
        require(minimumTokenYAmount>= _returnY, "less than minimun");

        _tokenX.transfer(msg.sender, _returnX);
        _tokenY.transfer(msg.sender, _returnY);

        _burn(msg.sender, LPTokenAmount);

        return (_returnX, _returnY);
        
    }

    function transfer(address to, uint256 lpAmount) public override returns (bool){
        _transfer(msg.sender, to, lpAmount);
        return true;
    }

    receive() external payable{}

}