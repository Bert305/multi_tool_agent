from flask import Flask, request, jsonify, send_from_directory, send_file
from flask_cors import CORS
import os
import sys

# Add current directory to Python path for imports
sys.path.append(os.path.dirname(__file__))

from tools import weather_tool, time_tool, news_tool, exchange_rate_tool

app = Flask(__name__, static_folder='../frontend/build/static')
CORS(app)

# API Routes (these must come BEFORE the catch-all route)
@app.route("/health", methods=["GET"])
def health_check():
    """Health check endpoint for Docker"""
    return jsonify({"status": "healthy", "service": "multi-tool-agent"})

@app.route("/agent", methods=["POST"])
def agent():
    """Multi-tool router: expects { "query": "...", "params": {...} }"""
    data = request.json
    query = data.get("query", "").lower()
    params = data.get("params", {})

    if "weather" in query:
        location = params.get("location", "Miami")
        return jsonify(weather_tool(location))

    if "time" in query:
        return jsonify(time_tool())

    if "news" in query:
        country = params.get("country", "us")
        return jsonify(news_tool(country))

    if "exchange" in query or "rate" in query or "currency" in query:
        base = params.get("base", "USD")
        target = params.get("target", "EUR")
        return jsonify(exchange_rate_tool(base, target))

    return jsonify({"error": "Unknown tool. Try 'weather', 'time', 'news', or 'exchange rate'."})

# Static file serving for React assets
@app.route('/static/<path:path>')
def serve_static(path):
    """Serve React static files (CSS, JS, images)"""
    return send_from_directory('../frontend/build/static', path)

# Serve React App (this MUST be last - catch-all route)
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve_react_app(path):
    """Serve the React app"""
    try:
        # For specific files, try to serve them directly
        if path and '.' in path:
            return send_from_directory('../frontend/build', path)
        # For all other routes, serve index.html (React router will handle)
        return send_file('../frontend/build/index.html')
    except Exception as e:
        # Fallback to index.html for React routing
        return send_file('../frontend/build/index.html')

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
