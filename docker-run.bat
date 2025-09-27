@echo off
setlocal enabledelayedexpansion

:: Multi-Tool Agent Docker Build and Run Script for Windows
:: Usage: docker-run.bat [build|start|stop|restart|dev|logs|clean|status]

set "COMPOSE_FILE=docker-compose.yml"
set "DEV_COMPOSE_FILE=docker-compose.dev.yml"
set "PROJECT_NAME=multi-tool-agent"

if "%1"=="" goto usage
if "%1"=="--help" goto usage
if "%1"=="-h" goto usage

:: Check if .env file exists
if not exist "backend\.env" (
    echo [ERROR] backend\.env file not found!
    echo Please create backend\.env with your API keys:
    echo WEATHERSTACK_API_KEY=your_key
    echo NEWSAPI_API_KEY=your_key
    echo EXCHANGERATE_API_KEY=your_key
    exit /b 1
)

if "%1"=="build" (
    echo [INFO] Building Multi-Tool Agent Docker image...
    docker-compose -f %COMPOSE_FILE% build
    if !errorlevel! equ 0 (
        echo [SUCCESS] Build completed successfully!
    ) else (
        echo [ERROR] Build failed!
        exit /b 1
    )
    goto end
)

if "%1"=="start" (
    echo [INFO] Starting Multi-Tool Agent in production mode...
    docker-compose -f %COMPOSE_FILE% up -d
    if !errorlevel! equ 0 (
        echo [SUCCESS] Application started successfully!
        echo [INFO] Access your app at: http://localhost:5000
    ) else (
        echo [ERROR] Failed to start application!
        exit /b 1
    )
    goto end
)

if "%1"=="stop" (
    echo [INFO] Stopping Multi-Tool Agent...
    docker-compose -f %COMPOSE_FILE% down
    echo [SUCCESS] Application stopped successfully!
    goto end
)

if "%1"=="restart" (
    echo [INFO] Restarting Multi-Tool Agent...
    docker-compose -f %COMPOSE_FILE% down
    docker-compose -f %COMPOSE_FILE% up -d
    echo [SUCCESS] Application restarted successfully!
    goto end
)

if "%1"=="dev" (
    echo [INFO] Starting Multi-Tool Agent in development mode...
    docker-compose -f %DEV_COMPOSE_FILE% up
    goto end
)

if "%1"=="logs" (
    echo [INFO] Showing application logs...
    docker-compose -f %COMPOSE_FILE% logs -f
    goto end
)

if "%1"=="status" (
    echo [INFO] Container status:
    docker-compose -f %COMPOSE_FILE% ps
    echo.
    echo [INFO] Container health:
    docker ps --filter "name=%PROJECT_NAME%" --format "table {{.Names}}	{{.Status}}	{{.Ports}}"
    goto end
)

if "%1"=="clean" (
    set /p "response=[WARNING] This will remove all containers and images. Continue? (y/N): "
    if /i "!response!"=="y" (
        echo [INFO] Cleaning up Docker resources...
        docker-compose -f %COMPOSE_FILE% down --rmi all --volumes
        docker-compose -f %DEV_COMPOSE_FILE% down --rmi all --volumes 2>nul
        echo [SUCCESS] Cleanup completed!
    ) else (
        echo [INFO] Cleanup cancelled.
    )
    goto end
)

echo [ERROR] Unknown command '%1'
echo.

:usage
echo Multi-Tool Agent Docker Management
echo.
echo Usage: %0 [COMMAND]
echo.
echo Commands:
echo   build     Build the Docker image
echo   start     Start the application in production mode
echo   stop      Stop the application
echo   restart   Restart the application
echo   dev       Start in development mode with hot reload
echo   logs      View application logs
echo   clean     Remove containers and images
echo   status    Show container status
echo.
echo Examples:
echo   %0 build     # Build the Docker image
echo   %0 start     # Start in production mode
echo   %0 dev       # Start in development mode

:end
endlocal