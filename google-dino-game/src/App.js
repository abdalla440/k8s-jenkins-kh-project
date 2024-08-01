import React from 'react';
import './App.css';
import DinoGame from './components/DinoGame';

function App() {
  console.log("Rendering App Component");
  return (
    <div className="App">
      <header className="App-header">
        <DinoGame />
      </header>
    </div>
  );
}

export default App;
