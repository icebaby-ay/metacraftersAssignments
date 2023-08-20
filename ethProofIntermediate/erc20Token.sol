// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract iceCoin is IERC20 {

    // public variables here

    string public tokenName = "iceCoin";
    string public tokenAbrrv = "IC";
    uint public TotalSupply = 0;


    // mapping variable here

    mapping (address => uint) public balances;

    function totalSupply() external view returns (uint256) {
        return TotalSupply;
    }

}


















contract erc20ICE is iceCoin {
        // mint function

    function mint ( address _address , uint _amount ) public {
        totalSupply = totalSupply + _amount;
        balances[_address] += _amount;
    }

    // burn function

    function burn ( address _address , uint _amount ) public {
        require(balances[_address] >= _amount, "you don't have the minimum number of tokens" );
        totalSupply = totalSupply - _amount;
        balances[_address] -= _amount;
    }
}