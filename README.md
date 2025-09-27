# 🛠️ Multi-Tool Agent

A full-stack intelligent agent that provides weather information, current time, news headlines, and currency exchange rates through a user-friendly web interface.

## 🚀 Features

- **🌤️ Weather Information**: Get current weather conditions for any city worldwide
- **📰 News Headlines**: Fetch top news stories from various countries
- **⏰ Current Time**: Display the current date and time
- **💱 Exchange Rates**: Get real-time currency conversion rates
- **🎨 Interactive Frontend**: Clean, responsive React interface with smart query detection
- **🔗 RESTful API**: Flask backend with organized tool routing

## 🏗️ Architecture

```
multi_tool_agent/
├── backend/              # Flask API server
│   ├── app.py           # Main Flask application
│   ├── tools.py         # Tool implementations
│   ├── .env             # Environment variables (API keys)
│   └── requirements.txt # Python dependencies
├── frontend/            # React web application
│   ├── src/
│   │   └── App.js      # Main React component
│   ├── package.json    # Node.js dependencies
│   └── public/         # Static assets
└── .venv/              # Python virtual environment
```

## 🛠️ Prerequisites

- **Python 3.8+** (with pip)
- **Node.js 14+** (with npm)
- **API Keys** for external services:
  - [WeatherStack](https://weatherstack.com/) - Weather data
  - [NewsAPI](https://newsapi.org/) - News headlines
  - [ExchangeRate-API](https://exchangerate-api.com/) - Currency rates
  - OpenAI & Anthropic (optional, for future AI features)

## 📦 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/Bert305/multi_tool_agent.git
cd multi_tool_agent
```

### 2. Backend Setup

#### Create and Activate Virtual Environment
```bash
# Create virtual environment
python -m venv .venv

# Activate virtual environment
# On Windows:
.venv\Scripts\Activate.ps1
# On macOS/Linux:
source .venv/bin/activate
```

#### Install Python Dependencies
```bash
cd backend
pip install flask flask-cors requests python-dotenv
```

#### Configure Environment Variables
Create a `.env` file in the `backend/` directory:
```env
WEATHERSTACK_API_KEY=your_weatherstack_api_key
NEWSAPI_API_KEY=your_newsapi_api_key
EXCHANGERATE_API_KEY=your_exchangerate_api_key
OPENAI_API_KEY=your_openai_api_key_optional
ANTHROPIC_API_KEY=your_anthropic_api_key_optional
```

### 3. Frontend Setup
```bash
cd ../frontend
npm install
```

## 🚀 Running the Application

### Start Backend Server
```bash
cd backend
python app.py
```
The Flask API will be available at: `http://127.0.0.1:5000`

### Start Frontend Development Server
```bash
cd frontend
npm start
```
The React app will open automatically at: `http://localhost:3000`

## 📋 Usage Guide

### Web Interface

1. **Open your browser** to `http://localhost:3000`
2. **Type natural language queries** in the input field
3. **Click "Ask"** or press **Enter** to submit
4. **View results** in the formatted response area

### Example Queries

#### 🌤️ Weather Queries
- "What's the weather in New York?"
- "Weather in Tokyo"
- "Current conditions in London"

**Response Format:**
```json
{
  "tool": "weather",
  "location": "New York",
  "temperature_celsius": 22,
  "temperature_fahrenheit": 71.6,
  "description": "Partly cloudy"
}
```

#### 📰 News Queries
- "Show me news from US"
- "Latest headlines from UK"
- "News from Canada"

**Response Format:**
```json
{
  "tool": "news",
  "headlines": [
    {
      "title": "Breaking News Title",
      "source": "CNN"
    }
  ]
}
```

#### ⏰ Time Queries
- "What's the current time?"
- "Show me the time"
- "Current date and time"

**Response Format:**
```json
{
  "tool": "time",
  "time": "2025-09-27 14:30:45"
}
```

#### 💱 Currency Queries
- "Exchange rate USD to EUR"
- "Convert GBP to JPY"
- "USD to CAD rate"

**Response Format:**
```json
{
  "tool": "exchange_rate",
  "base": "USD",
  "target": "EUR",
  "rate": 0.85,
  "last_updated": "2025-09-27T12:00:00Z"
}
```

### API Endpoints

#### POST `/agent`

Send queries programmatically to the backend API:

```bash
curl -X POST http://127.0.0.1:5000/agent \
  -H "Content-Type: application/json" \
  -d '{
    "query": "weather in Miami",
    "params": {"location": "Miami"}
  }'
```

**Request Body:**
```json
{
  "query": "your natural language query",
  "params": {
    "location": "city name",     // for weather
    "country": "country code",   // for news (us, uk, ca, etc.)
    "base": "USD",              // for exchange rates
    "target": "EUR"             // for exchange rates
  }
}
```

## 🎯 Smart Parameter Detection

The frontend automatically detects parameters from your natural language queries:

- **Weather**: Extracts city names from "weather in [city]"
- **News**: Detects country from "news from [country]"
- **Currency**: Parses "[FROM] to [TO]" currency patterns
- **Fallbacks**: Uses sensible defaults when parameters aren't specified

## 🔧 Development

### Project Structure
- `backend/app.py`: Main Flask application with route handling
- `backend/tools.py`: Individual tool implementations
- `frontend/src/App.js`: React frontend with smart query processing

### Adding New Tools

1. **Create tool function** in `backend/tools.py`:
```python
def new_tool(param: str):
    # Tool implementation
    return {"tool": "new_tool", "result": "data"}
```

2. **Update imports** in `backend/app.py`:
```python
from tools import weather_tool, time_tool, news_tool, exchange_rate_tool, new_tool
```

3. **Add route handling** in the `/agent` endpoint:
```python
if "keyword" in query:
    return jsonify(new_tool(params.get("param")))
```

## 🐛 Troubleshooting

### Common Issues

1. **"ModuleNotFoundError: No module named 'flask'"**
   - Ensure virtual environment is activated
   - Install dependencies: `pip install flask flask-cors requests python-dotenv`

2. **"API Key Error" responses**
   - Check `.env` file exists in `backend/` directory
   - Verify API keys are correct and active

3. **CORS errors in browser**
   - Ensure Flask-CORS is installed
   - Check that backend server is running on port 5000

4. **Frontend won't start**
   - Run `npm install` in frontend directory
   - Check Node.js version compatibility

### Logs and Debugging

- **Backend logs**: Check terminal running Flask server
- **Frontend logs**: Open browser developer console
- **API testing**: Use tools like Postman or curl

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 🌟 Future Enhancements

- [ ] AI-powered query understanding (OpenAI/Anthropic integration)
- [ ] Additional tools (calculator, unit converter, etc.)
- [ ] User authentication and query history
- [ ] Mobile-responsive improvements
- [ ] Real-time updates and WebSocket support

---

**Made with ❤️ using Flask + React**