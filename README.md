# 🛠️ Multi-Tool Agent

A full-stack i## 🐳 Docker Deployment (Recommended)

The Multi-Tool Agent uses an **optimized Docker setup** that runs both frontend and backend together in a single container for maximum performance and efficiency.

### 🚀 **Why Docker is Recommended:**
- **⚡ Faster Runtime**: Single container serves both React frontend and Flask API
- **🏗️ Multi-Stage Build**: Optimized build process with separate frontend and backend stages
- **📦 Production Ready**: Uses Gunicorn WSGI server with health checks and security hardening
- **🔧 Zero Configuration**: Everything bundled together - no need to run frontend and backend separately
- **🛡️ Containerized**: All dependencies isolated, consistent across environments

### Prerequisites
- **Docker** and **Docker Compose** installed
- API keys configured in `backend/.env`ent agent that provides weather information, current time, news headlines, and currency exchange rates through a user-friendly web interface.

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

## � Docker Deployment (Recommended)

The easiest way to run the Multi-Tool Agent is using Docker, which bundles both frontend and backend into a single container.

### Prerequisites
- **Docker** and **Docker Compose** installed
- API keys configured in `backend/.env`

### Quick Start with Docker

#### Using Docker Compose (Recommended)
```bash
# Build and start the application
docker-compose up --build

# Or run in detached mode
docker-compose up -d --build
```

#### Using Convenience Scripts

**Windows:**
```cmd
# Build the image
docker-run.bat build

# Start in production mode
docker-run.bat start

# View logs
docker-run.bat logs

# Stop the application
docker-run.bat stop
```

**Linux/macOS:**
```bash
# Make script executable
chmod +x docker-run.sh

# Build the image
./docker-run.sh build

# Start in production mode
./docker-run.sh start

# View logs
./docker-run.sh logs

# Stop the application
./docker-run.sh stop
```

#### Manual Docker Commands
```bash
# Build the image
docker build -t multi-tool-agent .

# Run the container
docker run -d \
  --name multi-tool-agent \
  -p 5000:5000 \
  --env-file backend/.env \
  multi-tool-agent
```

### Docker Features

✅ **Optimized Multi-Stage Build**: Separate Node.js and Python build stages for efficient image size  
✅ **Unified Frontend + Backend**: React app and Flask API served together on single port 5000  
✅ **Production Ready**: Uses Gunicorn WSGI server with optimal worker configuration  
✅ **Health Checks**: Built-in container health monitoring for reliability  
✅ **Security Hardened**: Runs as non-root user with minimal attack surface  
✅ **Hot Deployment**: Single container handles both web interface and API calls  
✅ **Environment Isolation**: All dependencies containerized for consistent deployments  
✅ **Static Asset Optimization**: Proper serving of React build files (CSS, JS, images)  

### Docker Commands Reference

| Command | Description |
|---------|-------------|
| `docker-run.bat build` | Build the Docker image |
| `docker-run.bat start` | Start in production mode |
| `docker-run.bat dev` | Start in development mode |
| `docker-run.bat stop` | Stop the application |
| `docker-run.bat restart` | Restart the application |
| `docker-run.bat logs` | View application logs |
| `docker-run.bat status` | Show container status |
| `docker-run.bat clean` | Remove containers and images |

### 🏗️ **Dockerfile Architecture**

The Multi-Tool Agent uses an advanced **multi-stage Docker build** that optimizes both development and production deployment:

```dockerfile
# Stage 1: Frontend Build (Node.js)
FROM node:18-alpine AS frontend-build
- Builds React app with npm ci --only=production
- Creates optimized production bundle
- Generates static files (CSS, JS, HTML)

# Stage 2: Backend + Unified Serving (Python)
FROM python:3.11-slim AS backend
- Installs Python dependencies with pip
- Copies Flask backend application
- Copies built React files from Stage 1
- Configures Gunicorn for production serving
- Serves both React frontend and Flask API on port 5000
```

**Key Benefits:**
- **🔥 Single Container**: No need for separate frontend/backend containers
- **⚡ Faster Startup**: Everything loads together in one process
- **📦 Smaller Image**: Multi-stage build eliminates Node.js from final image
- **🛡️ Security**: Runs as non-root user with minimal dependencies

### 🎯 Access Your Application
Once running, your **complete full-stack application** will be available at:
- **🌐 Web Interface**: `http://localhost:5000` *(React frontend with smart query processing)*
- **🔧 API Endpoint**: `http://localhost:5000/agent` *(Flask backend for programmatic access)*
- **❤️ Health Check**: `http://localhost:5000/health` *(Container status monitoring)*

> **💡 Pro Tip**: The Docker container serves both your React frontend and Flask API simultaneously on port 5000, eliminating the need to run separate development servers!

### 📋 **Container Management Commands**

Essential commands for managing your Docker container:

| Command | Description |
|---------|-------------|
| `docker-compose down` | **Stop** the container and remove it |
| `docker-compose up -d` | **Start** the container in detached mode (background) |
| `docker-compose build --no-cache` | **Rebuild** the container from scratch (recommended after code changes) |
| `docker-compose logs -f` | **View logs** in real-time (follow mode) |

**Quick Usage Examples:**
```bash
# Stop the application (will deactivate the application running on docker)
docker-compose down

# Start the application in background (will activate the frontend and backend using docker)
docker-compose up -d

# Rebuild after making code changes
docker-compose build --no-cache
docker-compose up -d

# Monitor application logs
docker-compose logs -f
```

## �📦 Manual Installation (Alternative)

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

### Docker Issues

1. **"docker-compose: command not found"**
   - Install Docker Desktop which includes Docker Compose
   - Or install Docker Compose separately

2. **"Port 5000 already in use"**
   - Change port mapping: `docker-compose up -p 8000:5000`
   - Or stop other services using port 5000

3. **"Build failed" or dependency errors**
   - Clear Docker cache: `docker system prune -a`
   - Rebuild: `docker-compose build --no-cache`

4. **Container exits immediately**
   - Check logs: `docker-compose logs`
   - Verify `.env` file exists in `backend/` directory

5. **Health check failing**
   - Container may still be starting (wait 30-60 seconds)
   - Check logs for application errors

### Manual Installation Issues

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