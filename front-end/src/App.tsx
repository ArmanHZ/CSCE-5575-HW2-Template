import { useEffect, useState } from 'react';
import './App.css';
import { BrowserProvider, ethers } from "ethers";
// Import the types generated by the TypeChain library when working with the final version of your contract.
// import { Counter__factory } from './generated/contract-types';

declare let window: any

function App() {

  return (
    <div className="App">
      <h1>Project 1</h1>
      <br />
      {/* Start with the handleConnectWallet and the necessary useState functions.
      {address ? (
            <>
              <div>{address}</div>
              <div>{balance}</div>
            </>
          ) : (
            <button onClick={handleConnectWallet}>Connect Wallet</button>
          )}
      */}
    </div>
  );
}

export default App;
