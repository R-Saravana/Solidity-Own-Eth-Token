// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyToken {
    string public name = "Token_Full_Name";
    string public symbol = "Token_Name";
    string public standard = "Token_Version";
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    address owner;

    constructor(){
        owner = msg.sender;
    }

    function CreateMyToken(uint256 createAmount) public onlyAdmin{

        balanceOf[msg.sender] = balanceOf[msg.sender] +createAmount;
        totalSupply = totalSupply + createAmount;
    }
    
    function BurnMyToken(uint256 burnAmount) public onlyAdmin{

        balanceOf[msg.sender] = balanceOf[msg.sender] -burnAmount;
        totalSupply = totalSupply - burnAmount;
    }

    modifier onlyAdmin{
        require(msg.sender==owner,"Only Owner can create amount of MyToken");
        _;
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to,_value);

        return true;
    }
    
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    function approve(address payable _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    function transferFrom(address payable _from, address payable _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }

}