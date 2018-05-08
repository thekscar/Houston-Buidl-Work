// Set compiler version 

pragma solidity ^0.4.23; 

contract Prediction {
    
    struct Questions {
        string theQuestion;
        address asker;
        uint value;
        uint totalValue; 
    } 
    
    Questions[] public questions; 
    
    address  public owner; 
    
    uint256 public requiredStake = 10000; 
    
    //User address --> question id ---> eth value sent in
    mapping(address => mapping(uint256 => uint256)) public stakedValues; 
    mapping(address => mapping(uint256 => bool)) public theAnswer; 
    
    //function Prdiction() {}
    constructor() {
        owner = msg.sender;     
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier requireStake() {
        require(msg.value >= requiredStake);
        _;
    }
    
    function setRequiredStake(uint256 val) external onlyOwner {
        requiredStake = val; 
    }
    
    function proposeAQuestion(string question) public payable requireStake {
        //require(msg.value >= requiredStake);
        //revert(msg.value >= 10000, "Not enough wei sent to contract");
        Questions memory temp = Questions({
            theQuestion: question, 
            asker: msg.sender, 
            value: msg.value, 
            totalValue: msg.value
        });
        questions.push(temp);
    }
    
    function respondAndStake(bool YN, uint id) external payable requireStake {
        stakedValues[msg.sender][id] = msg.value; 
        theAnswer[msg.sender][id] = YN;
        assert(msg.value + questions[id].totalValue >= questions[id].totalValue);
        questions[id].totalValue = msg.value + questions[id].totalValue;
    }
    
    function grabTotalValue(uint id) public view returns(uint) {
        return questions[id].totalValue; 
    }
    
    
    
}

