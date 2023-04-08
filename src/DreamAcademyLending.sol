// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../src/DreamOracle.sol";
import "../lib/forge-std/src/console.sol";
import "./DSMath.sol";

contract DreamAcademyLending is IPriceOracle {
    IPriceOracle public priceoracle;
    ERC20 usdc;
    ERC20 eth;

    uint256 constant public RAY = 10**27;
    uint256 constant public RATE = 1000000011568290959081926677;

    struct info1 {
        uint256 amount;
        uint256 interest;
    }

    struct info2 {
        uint256 amount;
        uint256 time;
    }

    mapping(address => uint256) _depositETH; // 누가 얼만큼 예치했는지
    mapping(address => info1) _depositUSDC;
    mapping(address => info2) _borrowUSDC; //누가 얼만큼 빌려갔는지

    address[] lenderAddr;

    uint256 UpdateTime;

    uint256 totalBorrow;
    uint256 totalUSDC;
    
    constructor (IPriceOracle _oracle, address _addr){
        priceoracle = _oracle;
        usdc = ERC20(_addr);
    }

    function deposit(address tokenAddress, uint256 amount) external payable {
        if(tokenAddress == address(0)){ //ether
            require(msg.value > 0, "deposit: deposit ether with insufficient value");
            require(msg.value == amount, "deposit: deposit ether with insufficient value");
            
            _depositETH[msg.sender] += msg.value;
        } else { //usdc
            require(amount > 0, "deposit: deposit usdc with insufficient value");
            require(usdc.balanceOf(msg.sender) >= amount, "deposit: deposit usdc with insufficient value");
            
            _depositUSDC[msg.sender].amount += amount;
            totalUSDC += amount;
            
            lenderAddr.push(msg.sender);
            
            usdc.transferFrom(msg.sender, address(this), amount);
        }
    }
    
    function borrow(address tokenAddress, uint256 amount) external{
        require(usdc.balanceOf(address(this)) >= amount, "borrow: insufficient amount");

        (uint256 ETHPrice, uint256 USDCPrice) = oracle();

        uint256 price = _depositETH[msg.sender] * ETHPrice / USDCPrice; 

        uint256 time = (block.number * 12) - _borrowUSDC[msg.sender].time;

        _borrowUSDC[msg.sender].amount = calculateInterest(_borrowUSDC[msg.sender].amount, RATE, time);
        _borrowUSDC[msg.sender].time = block.number * 12;

        uint256 able = (price / 2) - _borrowUSDC[msg.sender].amount;
        require(able >= amount, "borrow: ");

        _borrowUSDC[msg.sender].amount += amount;
        totalBorrow += amount;
        usdc.transfer(msg.sender, amount);
    }

    function repay(address tokenAddress, uint256 amount) external{
        require(tokenAddress == address(usdc), "repay: only USDC");
        require(usdc.balanceOf(msg.sender) >= amount, "repay: over");

        _borrowUSDC[msg.sender].amount -= amount;
        totalBorrow -= amount;

        usdc.transferFrom(msg.sender, address(this), amount);
    }

    function liquidate(address user, address tokenAddress, uint256 amount) external{
        (uint256 ETHPrice, uint256 USDCPrice) = oracle();

        uint256 price = _borrowUSDC[user].amount * USDCPrice / ETHPrice;
        
        require(price > _depositETH[user] * 75 / 100, "liquidity: no liquidate");
        require(_borrowUSDC[user].amount < 100 || amount == (_borrowUSDC[user].amount * 25 / 100), "");

        _borrowUSDC[user].amount -= amount;
        totalBorrow -= amount;

        _depositETH[user] -= amount * USDCPrice / ETHPrice;

    }

    function withdraw(address tokenAddress, uint256 amount) external{
        if (tokenAddress == address(0)) { // 대출한 사람 eth
            require(_depositETH[msg.sender] >= amount, "withdraw: over");

            uint256 time = (block.number * 12) - _borrowUSDC[msg.sender].time;

            _borrowUSDC[msg.sender].amount = calculateInterest(_borrowUSDC[msg.sender].amount, RATE, time);

            (uint256 ETHPrice, uint256 USDCPrice) = oracle();

            uint256 price = _borrowUSDC[msg.sender].amount * USDCPrice / ETHPrice; //usdc -> ether
        
            require(price <= (_depositETH[msg.sender]-amount)*75/100, "withdraw: can't withdraw");
            _depositETH[msg.sender] -= amount;

            (bool success, ) = msg.sender.call{value:amount}("");
        } else { // 공급자 usdc
            require(usdc.balanceOf(address(this)) >= amount, "withdraw: ");

            uint256 able = getAccruedSupplyAmount(address(usdc));
            require(able >= amount, "withdraw: insufficient amount");

            usdc.transfer(msg.sender, amount);
        }
    }

    function initializeLendingProtocol(address _addr) external payable {
        usdc.transferFrom(msg.sender, address(this), msg.value);
        _depositETH[msg.sender] += msg.value;
        _depositUSDC[msg.sender].amount += msg.value;
    }

    function getAccruedSupplyAmount(address _addr) public returns (uint256) { // 예치금 + 이자
        updateInterest();
        if (_addr == address(usdc)){
            return _depositUSDC[msg.sender].amount + _depositUSDC[msg.sender].interest;
        } else{
            return _depositETH[msg.sender];
        }
    } 

    function calculateInterest(uint p, uint r, uint n) internal returns (uint256 interest) { //liquidate나 withdraw에서 줘야 돼
        //s = p(1+r)^n
        return DSMath.rmul(p, DSMath.rpow(r, n));
    }

    function updateInterest() internal {
        uint256 time = (block.number * 12) - UpdateTime;
        uint256 totalAccumed = calculateInterest(totalBorrow, RATE, time);
        uint256 interest = totalAccumed - totalBorrow;

        for (uint256 i = 0; i < lenderAddr.length; i++){
            address user = lenderAddr[i];
            _depositUSDC[user].interest += interest * _depositUSDC[user].amount / totalUSDC;
        }
        UpdateTime = block.number * 12;
        totalBorrow = totalAccumed;
    }

    function oracle() internal returns (uint256, uint256) {
        return (priceoracle.getPrice(address(0)), priceoracle.getPrice(address(usdc)));
    }
}