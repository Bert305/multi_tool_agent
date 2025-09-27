#!/bin/bash

# Multi-Tool Agent Docker Build and Run Script
# Usage: ./docker-run.sh [build|start|stop|restart|dev|logs|clean]

set -e

COMPOSE_FILE="docker-compose.yml"
DEV_COMPOSE_FILE="docker-compose.dev.yml"
PROJECT_NAME="multi-tool-agent"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_usage() {
    echo -e "${BLUE}Multi-Tool Agent Docker Management${NC}"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build     Build the Docker image"
    echo "  start     Start the application in production mode"
    echo "  stop      Stop the application"
    echo "  restart   Restart the application"
    echo "  dev       Start in development mode with hot reload"
    echo "  logs      View application logs"
    echo "  clean     Remove containers and images"
    echo "  status    Show container status"
    echo ""
    echo "Examples:"
    echo "  $0 build     # Build the Docker image"
    echo "  $0 start     # Start in production mode"
    echo "  $0 dev       # Start in development mode"
}

check_env_file() {
    if [ ! -f "backend/.env" ]; then
        echo -e "${RED}Error: backend/.env file not found!${NC}"
        echo "Please create backend/.env with your API keys:"
        echo "WEATHERSTACK_API_KEY=your_key"
        echo "NEWSAPI_API_KEY=your_key"
        echo "EXCHANGERATE_API_KEY=your_key"
        exit 1
    fi
}

case "$1" in
    build)
        echo -e "${BLUE}Building Multi-Tool Agent Docker image...${NC}"
        check_env_file
        docker-compose -f $COMPOSE_FILE build
        echo -e "${GREEN}✅ Build completed successfully!${NC}"
        ;;
    
    start)
        echo -e "${BLUE}Starting Multi-Tool Agent in production mode...${NC}"
        check_env_file
        docker-compose -f $COMPOSE_FILE up -d
        echo -e "${GREEN}✅ Application started successfully!${NC}"
        echo -e "${YELLOW}🌐 Access your app at: http://localhost:5000${NC}"
        ;;
    
    stop)
        echo -e "${BLUE}Stopping Multi-Tool Agent...${NC}"
        docker-compose -f $COMPOSE_FILE down
        echo -e "${GREEN}✅ Application stopped successfully!${NC}"
        ;;
    
    restart)
        echo -e "${BLUE}Restarting Multi-Tool Agent...${NC}"
        docker-compose -f $COMPOSE_FILE down
        docker-compose -f $COMPOSE_FILE up -d
        echo -e "${GREEN}✅ Application restarted successfully!${NC}"
        ;;
    
    dev)
        echo -e "${BLUE}Starting Multi-Tool Agent in development mode...${NC}"
        check_env_file
        docker-compose -f $DEV_COMPOSE_FILE up
        ;;
    
    logs)
        echo -e "${BLUE}Showing application logs...${NC}"
        docker-compose -f $COMPOSE_FILE logs -f
        ;;
    
    status)
        echo -e "${BLUE}Container status:${NC}"
        docker-compose -f $COMPOSE_FILE ps
        echo ""
        echo -e "${BLUE}Container health:${NC}"
        docker ps --filter "name=$PROJECT_NAME" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
        ;;
    
    clean)
        echo -e "${YELLOW}⚠️  This will remove all containers and images. Continue? (y/N)${NC}"
        read -r response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            echo -e "${BLUE}Cleaning up Docker resources...${NC}"
            docker-compose -f $COMPOSE_FILE down --rmi all --volumes
            docker-compose -f $DEV_COMPOSE_FILE down --rmi all --volumes 2>/dev/null || true
            echo -e "${GREEN}✅ Cleanup completed!${NC}"
        else
            echo "Cleanup cancelled."
        fi
        ;;
    
    ""|--help|-h)
        print_usage
        ;;
    
    *)
        echo -e "${RED}Error: Unknown command '$1'${NC}"
        echo ""
        print_usage
        exit 1
        ;;
esac