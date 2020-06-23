pragma solidity >=0.4.22 <0.7.0;

contract Contest {

    struct contenstant {
        string name;
        string portfolio;
        uint votes;
        bool valid;
    }


    struct voter{
        bool voted;
    }

    mapping(address => contenstant) public contenstants;
    mapping(address => voter) private voters;

    address[] public allContestants;
    address public electoralCommitee;
    string public contestName;
    uint public totalContestants = 0;
    uint public totalVoters = 0;
    uint public entryFee = 0 ether;
    uint public votingFee = 0 ether;

    enum State { Created, Ongoing, Ended }
    State public state;

    constructor(string memory _contestName, uint _entryFee, uint _votingFee) public {
          electoralCommitee = msg.sender;
          contestName = _contestName;
          state = State.Created;
          entryFee = _entryFee;
          votingFee = _votingFee;
      }

    modifier checkPayment(uint valueSent, uint payment) {
      require(valueSent >= payment, 'Amount sent is not enough');
      _;
    }

    modifier condition(bool _condition) {
      require(_condition, 'Failed');
      _;
    }

    modifier isAdmin() {
      require(msg.sender == electoralCommitee, 'You are unauthorized');
      _;
    }

    modifier checkState(State _state) {
      require(state == _state, 'Contest state');
      _;
    }

    event contestantAdded(address contestant);
    event startContest();
    event voted(address voter);
    event endContest();

    function getAllContestansts() public view returns( address[] memory) {
        return allContestants;
    }

    function registerContestant(string memory _name, string memory _portfolio)
    public
    payable
    checkPayment(msg.value, entryFee)
    checkState(State.Created) {
        contenstant memory newContestant;
        newContestant.name = _name;
        newContestant.portfolio = _portfolio;
        newContestant.valid = true;
        contenstants[msg.sender] = newContestant;
        totalContestants ++;
        allContestants.push(msg.sender) - 1;
        emit contestantAdded(msg.sender);
    }

    function startTheContest() public checkState(State.Created) isAdmin {
        state = State.Ongoing;
        emit startContest();
    }

    function vote(address _contestant)
    public
    payable
    checkState(State.Ongoing)
    checkPayment(msg.value, votingFee)
    condition(!voters[msg.sender].voted)
    condition(contenstants[_contestant].valid) {
        voters[msg.sender].voted = true;
        contenstants[_contestant].votes ++;
        totalVoters ++;
        emit voted(msg.sender);
    }

    function endTheContest() public checkState(State.Ongoing) isAdmin {
        state = State.Ended;
        emit endContest();
    }
}