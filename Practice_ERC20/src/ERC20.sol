// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./EIP712.sol";

contract ERC20 is EIP712{
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;
    mapping(address => uint256) private _nonces;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    bool private paused;
    uint private _totalSupply;
    address public owner;
    bytes32 public _permit = keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");


    constructor(string memory name, string memory symbol) EIP712(name, "1")
    {
        _name = name;
        _symbol = symbol;
        _decimals = 18;
        _mint(msg.sender, 100 ether);
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender, "onlyOwner");
        _;
    }

    modifier pausable {
        require(paused == false, "paused");
        _;
    }

    function name() public view returns (string memory){
        return _name;
    }    

    function symbol() public view returns (string memory){
        return _symbol;
    }

    function decimals() public view returns (uint8){
        return _decimals;
    }

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256){
        return balances[_owner];
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function transfer(address _to, uint256 _value) external pausable returns (bool success) {
        require(_to != address(0), "transfer to the zero address");
        require(balances[msg.sender] >= _value, "Value exceeds balance");

        unchecked {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
        }

        emit Transfer(msg.sender, _to, _value); 
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
        require(_spender != address(0), "approve to the zero address");

        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }

    function _approve(address _owner, address spender, uint256 amount) internal virtual {
        require(spender != address(0), "ERC20: approve to the zero address");

        allowances[_owner][spender] = amount;
        emit Approval(_owner, spender, amount);
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return allowances[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success) {
        require(_from != address(0), "transfer to the zero address");
        require(_to != address(0), "transfer to the zero address");

        uint256 currentAllowance = allowance(_from, msg.sender);
        if (currentAllowance != type(uint256).max){
            require(currentAllowance >= _value, "insufficient allowance");
            unchecked{     //나는 5원만 보내게 했는데 이걸 안하면 5원씩 계속 보내서 잔고를 Burning시킬 수 있음
                allowances[_from][msg.sender] -= _value;
            }
        }

        require(balances[_from] >= _value, "value exceeds balance");

        unchecked{
            balances[_from] -= _value;
            balances[_to] += _value;
        }

        emit Transfer(_from, _to, _value);
    }

    function _mint(address _owner, uint256 _value) internal{ //내가 토큰을 얼마나 발행하겠다! / internal 함수라 owner함수인지 확인하지 않아도 됨
        require(_owner != address(0), "mint to the zero address");
        _totalSupply += _value;
        unchecked{
            balances[_owner] += _value;
        }
        emit Transfer(address(0), _owner, _value);
    }

    function _burn(address _owner, uint256 _value) internal{ //내가 누군가의 토큰을 아예 태워버리겠다!
        require(_owner != address(0), "burn from the zero address");
        require(balances[_owner] >= _value, "burn amount exceeds balance");
        unchecked {
            balances[_owner] -= _value;
            _totalSupply -= _value;
        }

        emit Transfer(_owner, address(0), _value);
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    function nonces(address _owner) public returns (uint) {
        return _nonces[_owner];
    }

    function permit(address _owner,address spender,uint256 value,uint256 deadline,uint8 v,bytes32 r,bytes32 s) public {
        require(block.timestamp <= deadline, "ERC20Permit: expired deadline");


        bytes32 hashStruct = keccak256(abi.encode(_permit,_owner,spender,value,_nonces[_owner],deadline));
        bytes32 hash = _toTypedDataHash(hashStruct);

        address signer = ecrecover(hash, v, r, s);
        

        require(signer == _owner, "INVALID_SIGNER");
        _nonces[_owner]++;

        _approve(_owner, spender, value);
    }
}