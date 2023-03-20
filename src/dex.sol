// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract mkcoin is ERC20 {
    address owner;

    constructor() ERC20("LIM", "LIM"){
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public {
        require(owner == msg.sender, "Only Owner");
        _mint(to, amount);
    }
}

contract Dex {
    ERC20 public _tokenX;
    ERC20 public _tokenY;
    mkcoin public _tokenLP;

    constructor(address tokenX, address tokenY){
        _tokenX = ERC20(tokenX);
        _tokenY = ERC20(tokenY);
        _tokenLP = new mkcoin();
        
    }

    //Swap
    //Pool 생성 시 지정된 두 종류의 토큰을 서로 교환할 수 있어야 합니다.
    //Input 토큰과 Input 수량, 최소 Output 요구량을 받아서 Output 토큰으로 바꿔주고
    //최소 요구량에 미달할 경우 revert 해야합니다. 수수료는 0.1%로 하세요
    //tokenXAmount / tokenYAmount 중 하나는 무조건 0이어야 합니다.
    //수량이 0인 토큰으로 스왑됨
    function swap(uint256 tokenXAmount, uint256 tokenYAmount, uint256 tokenMinimumOutputAmount) external returns (uint256 outputAmount){

    }

    //addLiquidity, removeLiquidity
    //ERC-20 기반 LP 토큰을 사용해야 합니다.
    //수수료 수입과 Pool에 기부된 금액을 제외하고는
    //더 많은 토큰을 회수할 수 있는 취약점이 없어야 합니다. 
    function addLiquidity(uint256 tokenXAmount, uint256 tokenYAmount, uint256 minimumLPTokenAmount) external returns (uint256 LPTokenAmount){

    }

    function removeLiquidity(uint256 LPTokenAmount, uint256 minimumTokenXAmount, uint256 minimumTokenYAmount) public returns (uint, uint) {

    }

    function transfer(address to, uint256 lpAmount) external returns (bool){

    }

}