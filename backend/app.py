from flask import Flask, request, jsonify
from flask_cors import CORS
from tools import weather_tool, time_tool, news_tool, exchange_rate_tool

app = Flask(__name__)
CORS(app)

@app.route("/agent", methods=["POST"])
def agent():
    """
    Multi-tool router: expects { "query": "...", "params": {...} }
    Example: { "query": "weather", "params": {"location": "London"} }
    """
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

if __name__ == "__main__":
    app.run(debug=True)
