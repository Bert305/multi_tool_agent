import os
import requests
from datetime import datetime
from dotenv import load_dotenv

load_dotenv()

def weather_tool(location: str):
    api_key = os.getenv("WEATHERSTACK_API_KEY")
    url = f"http://api.weatherstack.com/current?access_key={api_key}&query={location}"
    r = requests.get(url).json()
    if "current" not in r:
        return {"error": r}
    c = r["current"]
    temp_c = c["temperature"]
    temp_f = temp_c * 9 / 5 + 32
    return {
        "tool": "weather",
        "location": location,
        "temperature_celsius": temp_c,
        "temperature_fahrenheit": round(temp_f, 2),
        "description": c["weather_descriptions"][0]
    }

def time_tool():
    now = datetime.now()
    return {
        "tool": "time",
        "time": now.strftime("%Y-%m-%d %H:%M:%S")
    }

def news_tool(country: str = "us"):
    api_key = os.getenv("NEWSAPI_API_KEY")
    url = f"https://newsapi.org/v2/top-headlines?country={country}&apiKey={api_key}"
    r = requests.get(url).json()
    if "articles" not in r:
        return {"error": r}
    articles = [{"title": a["title"], "source": a["source"]["name"]}
                for a in r["articles"][:5]]
    return {
        "tool": "news",
        "headlines": articles
    }

def exchange_rate_tool(base_currency: str = "USD", target_currency: str = "EUR"):
    api_key = os.getenv("EXCHANGERATE_API_KEY")
    url = f"https://v6.exchangerate-api.com/v6/{api_key}/pair/{base_currency}/{target_currency}"
    r = requests.get(url).json()
    if "conversion_rate" not in r:
        return {"error": r}
    return {
        "tool": "exchange_rate",
        "base": base_currency,
        "target": target_currency,
        "rate": r["conversion_rate"],
        "last_updated": r.get("time_last_update_utc", "Unknown")
    }
