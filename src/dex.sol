// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/utils/math/Math.sol";
import "openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract Dex is ERC20 {
    ERC20 public tokenX;
    ERC20 public tokenY;

    constructor(address _tokenX, address _tokenY) ERC20("LPT", "LPT") {
        tokenX = ERC20(_tokenX);
        tokenY = ERC20(_tokenY);        
    }

    function swap(uint256 tokenXAmount, uint256 tokenYAmount, uint256 tokenMinimumOutputAmount) external returns (uint256 outputAmount){        
        (uint reserveX, uint reserveY) = update();

        require(tokenXAmount == 0 || tokenYAmount == 0, "");
        require(reserveX > 0 && reserveY > 0, "");

        if(tokenXAmount == 0) {  // Y를 X로 스왑
            outputAmount = (reserveX * (tokenYAmount * 999 / 1000)) / (reserveY + (tokenYAmount * 999 / 1000));
            
            require(outputAmount >= tokenMinimumOutputAmount, "");

            tokenY.transferFrom(msg.sender, address(this), tokenYAmount);
            tokenX.transfer(msg.sender, outputAmount);
        } 
        else {  // X를 Y로 스왑
            outputAmount = (reserveY * (tokenXAmount * 999 / 1000)) / (reserveX + (tokenXAmount * 999 / 1000));

            require(outputAmount >= tokenMinimumOutputAmount, "");

            tokenX.transferFrom(msg.sender, address(this), tokenXAmount);
            tokenY.transfer(msg.sender, outputAmount);
        }

        update();
}

    function addLiquidity(uint256 tokenXAmount, uint256 tokenYAmount, uint256 minimumLPTokenAmount) external returns (uint256 LPTokenAmount){
        require(tokenXAmount > 0, "AddLiquidity : tokenXAmount");
        require(tokenYAmount > 0, "AddLiquidity : tokenYAmount");
        require(tokenX.allowance(msg.sender, address(this)) >= tokenXAmount, "ERC20: insufficient allowance");
        require(tokenY.allowance(msg.sender, address(this)) >= tokenYAmount, "ERC20: insufficient allowance");
        require(tokenX.balanceOf(msg.sender) >= tokenXAmount, "ERC20: transfer amount exceeds balance");
        require(tokenY.balanceOf(msg.sender) >= tokenYAmount, "ERC20: transfer amount exceeds balance");

        (uint256 reserveX, uint256 reserveY) = update();

        uint256 amountX;
        uint256 amountY;

        // DEX pool이 비어있을 때
        if (totalSupply() == 0){
            LPTokenAmount = Math.sqrt(tokenXAmount * tokenYAmount);
        } else{ // 비율에 맞게 들어왔는지 확인
            if (tokenYAmount >= _quote(tokenXAmount, reserveX, reserveY)){
                amountX = tokenXAmount;
                amountY = _quote(tokenXAmount, reserveX, reserveY);
                LPTokenAmount  = Math.min((amountX * totalSupply()/reserveX), (amountY * totalSupply()/reserveY));
            } else if (tokenXAmount >= _quote(tokenYAmount, reserveY, reserveX)) {
                amountX = _quote(tokenYAmount, reserveY, reserveX);
                amountY = tokenYAmount;
                LPTokenAmount  = Math.min((amountX * totalSupply()/reserveX), (amountY * totalSupply()/reserveY));
            } else {
                revert("AddLiquidity : INSUFFICIENT AMOUNT");
            }
        }

        require(minimumLPTokenAmount <= LPTokenAmount, "AddLiquidity : minimum LP return error");
        _mint(msg.sender, LPTokenAmount);

        tokenX.transferFrom(msg.sender, address(this), tokenXAmount);
        tokenY.transferFrom(msg.sender, address(this), tokenYAmount);

        update();
    }

    function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) public returns (uint _receiveX, uint _receiveY) {        
        require(LPTokenAmount > 0, "");
        require(balanceOf(msg.sender) >= LPTokenAmount, "");

        (uint reserveX, uint reserveY) = update();

        _receiveX = reserveX * LPTokenAmount / totalSupply();
        _receiveY = reserveY * LPTokenAmount / totalSupply();

        require(minimumTokenXAmount<= _receiveX, "");
        require(minimumTokenYAmount<= _receiveY, "");

        reserveX -= _receiveX;
        reserveY -= _receiveY;

        _burn(msg.sender, LPTokenAmount);

        tokenX.transfer(msg.sender, _receiveX);
        tokenY.transfer(msg.sender, _receiveY);
    }

    function transfer(address to, uint256 lpAmount) public override returns (bool){
    }

    function update() public returns (uint reserveX, uint reserveY){
        reserveX = tokenX.balanceOf(address(this));
        reserveY = tokenY.balanceOf(address(this));
    }

    function _quote(uint256 amount, uint256 reserve1, uint256 reserve2) public returns (uint256 reserve){
        require(reserve1 > 0 && reserve2 > 0, "zero pool");
        reserve = amount * reserve2 / reserve1;    
    }

    receive() external payable{}
}
