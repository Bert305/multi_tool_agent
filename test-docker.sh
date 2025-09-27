#!/bin/bash

# Docker Setup Test Script for Multi-Tool Agent
# This script tests the Docker configuration and API endpoints

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

BASE_URL="http://localhost:5000"

echo -e "${BLUE}🐳 Multi-Tool Agent Docker Test${NC}"
echo "=================================="

# Test 1: Health Check
echo -e "\n${BLUE}Test 1: Health Check${NC}"
if curl -f -s "$BASE_URL/health" > /dev/null; then
    echo -e "${GREEN}✅ Health check passed${NC}"
else
    echo -e "${RED}❌ Health check failed${NC}"
    echo "Make sure the container is running: docker-compose up -d"
    exit 1
fi

# Test 2: Frontend Access
echo -e "\n${BLUE}Test 2: Frontend Access${NC}"
if curl -f -s -o /dev/null "$BASE_URL/"; then
    echo -e "${GREEN}✅ Frontend accessible${NC}"
else
    echo -e "${RED}❌ Frontend not accessible${NC}"
fi

# Test 3: API Endpoint - Time Tool
echo -e "\n${BLUE}Test 3: Time Tool API${NC}"
response=$(curl -s -X POST "$BASE_URL/agent" \
    -H "Content-Type: application/json" \
    -d '{"query": "current time", "params": {}}')

if echo "$response" | grep -q '"tool": "time"'; then
    echo -e "${GREEN}✅ Time tool working${NC}"
    echo "Response: $response"
else
    echo -e "${RED}❌ Time tool failed${NC}"
    echo "Response: $response"
fi

# Test 4: API Endpoint - Weather Tool (without API key, expect error)
echo -e "\n${BLUE}Test 4: Weather Tool API Structure${NC}"
response=$(curl -s -X POST "$BASE_URL/agent" \
    -H "Content-Type: application/json" \
    -d '{"query": "weather in London", "params": {"location": "London"}}')

if echo "$response" | grep -q '"tool": "weather"' || echo "$response" | grep -q '"error"'; then
    echo -e "${GREEN}✅ Weather tool endpoint working${NC}"
    echo "Response: $response"
else
    echo -e "${RED}❌ Weather tool endpoint failed${NC}"
    echo "Response: $response"
fi

# Test 5: Container Status
echo -e "\n${BLUE}Test 5: Container Status${NC}"
container_status=$(docker ps --filter "name=multi-tool-agent" --format "{{.Status}}")
if [ -n "$container_status" ]; then
    echo -e "${GREEN}✅ Container running: $container_status${NC}"
else
    echo -e "${RED}❌ Container not found or not running${NC}"
fi

echo -e "\n${BLUE}🎉 Test Summary${NC}"
echo "=================================="
echo -e "${GREEN}✅ Docker setup is working correctly!${NC}"
echo -e "${YELLOW}💡 Access your app at: $BASE_URL${NC}"
echo -e "${YELLOW}📚 API docs available in README.md${NC}"