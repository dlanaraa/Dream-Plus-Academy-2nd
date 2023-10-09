//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EIP712 {
    string public name_;
    string public version_;
    bytes32 private DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
    bytes32 private PERMIT_TYPEHASH = keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    constructor(string memory name, string memory version) public{
        name_ = name;
        version_ = version;
    }

    function _domainSeparator() public view returns (bytes32) {
        return keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name_)), keccak256(bytes(version_)), block.chainid, address(this)));
    }

    function _toTypedDataHash(bytes32 structHash) public view returns (bytes32 data) {
        return keccak256(abi.encodePacked("\x19\x01", _domainSeparator(), structHash));
    }
}