# Multi-stage Docker build for Multi-Tool Agent
# Stage 1: Build React Frontend
FROM node:18-alpine AS frontend-build

WORKDIR /app/frontend

# Copy package files first for better caching
COPY frontend/package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy frontend source
COPY frontend/ ./

# Build the React app
RUN npm run build

# Stage 2: Python Backend with Frontend
FROM python:3.11-slim AS backend

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Copy backend requirements first for better caching
COPY requirements.txt ./

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy backend source
COPY backend/ ./backend/

# Copy built frontend from previous stage
COPY --from=frontend-build /app/frontend/build ./frontend/build/

# Create __init__.py files to make backend a proper Python package
RUN touch /app/__init__.py

# Create non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser && \
    chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=backend/app.py
ENV FLASK_ENV=production
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Use gunicorn for production with the correct working directory
WORKDIR /app/backend
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--timeout", "30", "--keep-alive", "2", "--max-requests", "1000", "--max-requests-jitter", "100", "app:app"]