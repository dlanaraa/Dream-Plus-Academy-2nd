// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Lottery{
    mapping(address => uint) money; // 로또 구매할 때 지불한 금액
    mapping(address => uint) choose_num;//로또에서 선택한 숫자
    uint count; //숫자 맞춘 사람 수
    uint times; //times를 기준으로 24시간 후에 claim, draw 실행

    constructor () {
        times = block.timestamp; //컨트랙트 배포되는 시점을 기준으로 함
    }

    function buy(uint _num) public payable { //로또 구매 함수 (_num은 선택한 숫자)
        require(msg.value != 0, "give money"); // 이더 보냈는지 확인
        require(msg.value == 0.1 ether, "only 0.1 ether"); // 이더는 0.1이더만 보내야 함
        require(money[msg.sender] == 0, "exist"); // 중복 구매 확인
        require(block.timestamp < times + 24 hours, "timeover"); // 이 함수가 호출된 시점이 times를 기준으로 24시간이 지났는지 확인

        money[msg.sender] = msg.value; // msg.sender가 보낸 이더를 money에 저장
        choose_num[msg.sender] = _num; //선택한 숫자를 choose_num에 추가
        if (choose_num[msg.sender] == 1){ //winningNum을 1로 설정했기 때문에 선택한 숫자가 1인 경우 숫자를 맞췄다는 것을 의미하므로 count + 1
            count += 1;
        }
    }

    function claim() public payable { // 당첨자한테 돈 주는 함수
        require(block.timestamp >= times + 24 hours, "selling time"); // claim은 timestamp를 기준으로 24시간이 지난 후에 실행되어야 됨
        if (choose_num[msg.sender] == winningNumber()){ //선택한 숫자가 winningNumber와 일치하는 경우 돈을 보내줌
            payable(msg.sender).call{value: address(this).balance/count}(""); //당첨된 사람이 여러 명이면 당첨금을 나눠 가져야 됨
            count -= 1; // 한 명이 돈 찾아갔으면 이에 따른 count - 1
        }
        if (count == 0){ // 모두 돈을 찾아갔으면?
            times = block.timestamp; //timestamp를 초기화 시켜줌
        }
        money[msg.sender] = 0; // 로또가 끝났으니까 지불했던 돈도 다시 0으로 초기화해줘야 됨
    }

    function draw() public payable { // 당첨자 뽑는 함수
        require(block.timestamp >= times + 24 hours, "selling time"); // draw도 claim과 마찬가지로 timestamp를 기준으로 24시간이 지난 후 실행되어야 됨
        require(address(this).balance != 0, "already draw"); //만약 당첨자가 나와서 돈을 다 나눠가진 상태라면 이 이 컨트랙트에는 돈이 없을 것 -> 이미 draw와 claim을 했다고 생각
    }

    function winningNumber() public returns(uint16) { // 당첨 번호 -> 1로 고정해줌
        return 1;
    }
}