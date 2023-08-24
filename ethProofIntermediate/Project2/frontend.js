import {useState, useEffect} from "react";
import {ethers} from "ethers";
import ABI from "../artifacts/contracts/Assessment.sol/Assessment.json";

import React from 'react'

export default function header() {
    
    // set wallet and pick one account from wallet

    const [ethWallet, setEthWallet] = useState(undefined);
    const [account, setAccount] = useState(undefined);

    // set contract from contract address and abi

    const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
    const contractABI = ABI.abi;

    const [contract, setContract] = useState[undefined];

    // set contract input values 
    const [workingId, setWorkingId] = useState[undefined];
    const [workingAddress, setWorkingAddress] = useState[undefined];

    // set contract function output values

    const [moderator, setModerator] = useState[undefined];
    const [userId, setUserId] = useState[undefined];
    const [idState, setIdState] = useState[Boolean];

    const getWallet = async() => {
        // check if there is a wallet
        if (window.ethereum) {
            setEthWallet(window.ethereum)
        } else {
            alert("You need to install a web3 wallet to use this site")
        }

        // once the wallet has been stored ...
        if (ethWallet) {
            // get the account from the Wallet
            const account = await ethWallet.request({method: "eth_accounts"});

            // handle the account (perform preparatory operations on it)
            handleAccount(account);
        }
    }

    const handleAccount = (account) => {
        // check if there is an account
        if (account) {
            // then set that account
            console.log("Account connected: ", account);
            setAccount(account);
        } else {
            // else throw an error message
            console.log("No account found");
        }
    }

    // connects user to contract (bridge between wallet and contract address)
    const connectUser = async() => {
        try {

        getWallet();

        getContract(); 

        } catch (error) {
            alert(error);
            location.reload(true)       
        }
    }

    const getContract = () => {

        // get signer
        const provider = new ethers.providers.Web3Provider(ethWallet);
        const signer = provider.getSigner();

        // create contract object from address, signer and ABI
        const contract = new ethers.Contract(contractAddress, contractABI, signer)

        setContract(contract);

    }

    const getModerator = async () => {
        // if the contract exists set the moderator, else fail the code
        if (contract) {   
            setModerator(await contract.moderator())
        }
    }

    const client = async() => {
        if (moderator != account) {
            return (
                <div>
                    <div> contract address: {contractAddress}</div> 
                    <div> Welcome User: {account} </div>
                </div>
            )
        } else {
            return (
                <></>
            )
        }
    }

    const admin = async () => {
        if (moderator == account) {
            return (
                <div>
                    <div> contract address: {contractAddress}</div> 
                    <div> Welcome admin </div>
                </div>
            )
        } else {
            return (
                <></>
            )
        }
    }

  return (
    <div>
        <div className = "heading"> welcome to icebaby's gamerAuth</div>
        {client()}
        {admin()}
    </div>
  )
}