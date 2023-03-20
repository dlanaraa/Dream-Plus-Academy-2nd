// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Dex is ERC20 {
    ERC20 public _tokenX;
    ERC20 public _tokenY;
    uint _amountX;
    uint _amountY;
    uint _amountLPT;

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

        
        if(tokenXAmount == 0){      // tokenXAmount가 user한테 y를 받아서 x를 주는 것
            // xy = (x-dx)(y+dy) -> dx = (x * dx) / (y + dx)
            // 선행 수수료
            outputAmount = _amountX * (tokenXAmount * 999 / 1000) / _amountY + (tokenXAmount * 999 / 1000);
            
            // 최소값 검증
            require(outputAmount >= tokenMinimumOutputAmount, "less than Minimum");

            // res만큼 X에 더해주고, Y에서 빼주기
            _amountX += outputAmount;
            _amountY -= outputAmount;

            // 보내기
            _tokenX.transferFrom(msg.sender, address(this), outputAmount);
            _tokenY.transfer(msg.sender, outputAmount);

        } else if(tokenYAmount == 0){       // tokenYAmount가 0이니까 user한테 X받아서 y주는 것
            // xy = (x-dx)(y+dy) -> dy = (y * dx) / (x + dx)
            outputAmount = _amountY * (tokenYAmount * 999 / 1000) / _amountX + (tokenXAmount * 999 / 1000);

            require(outputAmount >= tokenMinimumOutputAmount, "less than Minimum");

            _amountY += outputAmount;
            _amountX += outputAmount;

            _tokenY.transferFrom(msg.sender, address(this), outputAmount);
            _tokenX.transfer(msg.sender, outputAmount);
        } else {
            revert();
        }
        return outputAmount;
    }

    //addLiquidity, removeLiquidity
    //ERC-20 기반 LP 토큰을 사용해야 합니다.
    //수수료 수입과 Pool에 기부된 금액을 제외하고는
    //더 많은 토큰을 회수할 수 있는 취약점이 없어야 합니다. 
    function addLiquidity(uint256 tokenXAmount, uint256 tokenYAmount, uint256 minimumLPTokenAmount) external returns (uint256 LPTokenAmount){
        require(tokenXAmount > 0, "tokenXAmount is 0");
        require(tokenYAmount > 0, "tokenYAmount is 0");
        require(_tokenX.allowance(msg.sender, address(this)) >= tokenXAmount, "ERC20: insufficient allowance");
        require(_tokenY.allowance(msg.sender, address(this)) >= tokenYAmount, "ERC20: insufficient allowance");
        require(_tokenX.balanceOf(msg.sender) >= tokenXAmount, "ERC20: transfer amount exceeds balance");
        require(_tokenY.balanceOf(msg.sender) >= tokenYAmount, "ERC20: transfer amount exceeds balance");
        uint reward;

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
        
        require(reward >= minimumLPTokenAmount, "less than minimum");
        _mint(msg.sender, reward);
        _amountLPT += reward;

        _amountX += tokenXAmount;
        _amountY += tokenYAmount;
        _tokenX.transferFrom(msg.sender, address(this), tokenXAmount);
        _tokenY.transferFrom(msg.sender, address(this), tokenYAmount);

        return reward;
    }

    function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) public returns (uint, uint) {
    }

    function transfer(address to, uint256 lpAmount) public override returns (bool){
        _transfer(msg.sender, to, lpAmount);
        return true;
    }

}