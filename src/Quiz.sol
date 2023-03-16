// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Quiz{
    struct Quiz_item {
      uint id;
      string question;
      string answer;
      uint min_bet;
      uint max_bet;
   }
    
    mapping(address => uint256)[] public bets; // 베팅한 금액
    mapping(uint => Quiz_item) public quiz_list; // 퀴즈 저장
    uint public vault_balance; // 금고에 있는 돈..?
    address owner = msg.sender;
    string[] public answer_list; // 퀴즈 정답 저장
    bool isCorrect;

    constructor () {
        Quiz_item memory q;
        q.id = 1;
        q.question = "1+1=?";
        q.answer = "2";
        q.min_bet = 1 ether;
        q.max_bet = 2 ether;
        addQuiz(q);
    }

    function addQuiz(Quiz_item memory q) public {
        require(msg.sender == owner, "fail");
        quiz_list[q.id] = q; //quiz_list에 q 값들 추가해줌
        answer_list.push(quiz_list[q.id].answer); //인자로 받은 퀴즈의 answer를 answer_list에 push해줌
        quiz_list[q.id].answer = ""; //인자로 받은 퀴즈에 대해 quiz_list의 answer는 비워줌 -> getQuiz에서 answer 확인하는거 방지?
    }

    function getAnswer(uint quizId) public view returns (string memory){
        string memory answer = answer_list[quizId-1];
        return answer; // answer는 add에서 answer_list에 저장했으니까 이 값 리턴해주면 됨
    }

    function getQuiz(uint quizId) public view returns (Quiz_item memory) {
        Quiz_item memory quiz = quiz_list[quizId]; //입력받은 퀴즈를 quiz_list에서 return해주면 됨
        return quiz;
    }

    function getQuizNum() public view returns (uint){
        uint num = quiz_list[answer_list.length].id;
        return num;
    }
    
    function betToPlay(uint quizId) public payable {
        require(msg.value >= quiz_list[quizId].min_bet, "more betting"); //베팅한 값이 최소 베팅값보다 큰지 확인
        require(msg.value <= quiz_list[quizId].max_bet, "less betting"); //베팅한 값이 최대 베팅값보다 작은지 확인
        bets.push(); //bets에 빈공간 만들어주기
        bets[quizId-1][msg.sender] += msg.value; //bets[quizid]에 [msg.sender:msg.value] 넣어주기
    }

    function solveQuiz(uint quizId, string memory ans) public returns (bool) {
        bool solve = keccak256(abi.encodePacked(answer_list[quizId-1])) == keccak256(abi.encodePacked(ans)) ? true : false; //answerlist에 저장되어 있는 답과 입력으로 받은 답이 일치하는지 확인
        vault_balance = bets[quizId-1][msg.sender]; //베팅한 금액 저장
        bets[quizId-1][msg.sender] = 0; //베팅한 금액은 초기화해줌
        isCorrect = solve; //claim에서 solve 성공한 경우에만 돈 줘야 됨
        return solve;
    }

    function claim() public {
        if (isCorrect == true){
            payable(msg.sender).call{value:vault_balance * 2}("");
        }
        vault_balance = 0; //돈 보내줬으면 초기화
    }
    receive() external payable{}
}
