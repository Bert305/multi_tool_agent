import React, { useState } from "react";
import axios from "axios";

function App() {
  const [input, setInput] = useState("");
  const [output, setOutput] = useState("");
  const [loading, setLoading] = useState(false);

  const sendQuery = async () => {
    if (!input.trim()) return;
    
    setLoading(true);
    try {
      let params = {};
      
      // Smart parameter detection
      if (input.toLowerCase().includes("weather")) {
        const locationMatch = input.match(/in (\w+)/i);
        params.location = locationMatch ? locationMatch[1] : "London";
      } else if (input.toLowerCase().includes("news")) {
        const countryMatch = input.match(/from (\w+)/i);
        params.country = countryMatch ? countryMatch[1] : "us";
      } else if (input.toLowerCase().includes("exchange") || input.toLowerCase().includes("rate")) {
        const currencyMatch = input.match(/(\w{3})\s+to\s+(\w{3})/i);
        if (currencyMatch) {
          params.base = currencyMatch[1].toUpperCase();
          params.target = currencyMatch[2].toUpperCase();
        } else {
          params.base = "USD";
          params.target = "EUR";
        }
      }

      const res = await axios.post("http://127.0.0.1:5000/agent", {
        query: input,
        params: params
      });
      setOutput(JSON.stringify(res.data, null, 2));
    } catch (err) {
      setOutput("Error: " + err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      sendQuery();
    }
  };

  const exampleQueries = [
    "What's the weather in New York?",
    "Show me the current time",
    "Get news from US",
    "Exchange rate USD to EUR"
  ];

  return (
    <div style={{ padding: 20, maxWidth: 800, margin: "0 auto", fontFamily: "Arial, sans-serif" }}>
      <h1 style={{ textAlign: "center", color: "#333" }}>🛠️ Multi-Tool Agent</h1>
      
      <div style={{ marginBottom: 20 }}>
        <input
          style={{ 
            width: "70%", 
            padding: "12px", 
            fontSize: "16px",
            border: "2px solid #ddd",
            borderRadius: "8px",
            marginRight: "10px"
          }}
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyPress={handleKeyPress}
          placeholder="Ask about weather, time, news, or exchange rates..."
          disabled={loading}
        />
        <button 
          onClick={sendQuery}
          disabled={loading || !input.trim()}
          style={{
            padding: "12px 20px",
            fontSize: "16px",
            backgroundColor: loading ? "#ccc" : "#007bff",
            color: "white",
            border: "none",
            borderRadius: "8px",
            cursor: loading ? "not-allowed" : "pointer"
          }}
        >
          {loading ? "Loading..." : "Ask"}
        </button>
      </div>

      <div style={{ marginBottom: 20 }}>
        <h3>Example queries:</h3>
        <div style={{ display: "flex", flexWrap: "wrap", gap: "10px" }}>
          {exampleQueries.map((query, index) => (
            <button
              key={index}
              onClick={() => setInput(query)}
              style={{
                padding: "8px 12px",
                backgroundColor: "#f8f9fa",
                border: "1px solid #ddd",
                borderRadius: "4px",
                cursor: "pointer",
                fontSize: "14px"
              }}
            >
              {query}
            </button>
          ))}
        </div>
      </div>

      {output && (
        <div style={{
          backgroundColor: "#f8f9fa",
          padding: "15px",
          borderRadius: "8px",
          border: "1px solid #ddd"
        }}>
          <h3>Response:</h3>
          <pre style={{ 
            whiteSpace: "pre-wrap", 
            fontSize: "14px",
            margin: 0,
            color: "#333"
          }}>
            {output}
          </pre>
        </div>
      )}
    </div>
  );
}

export default App;

