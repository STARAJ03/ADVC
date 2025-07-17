FROM python:3.10.8-slim-bullseye

# Install system dependencies
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        gcc \
        libffi-dev \
        ffmpeg \
        aria2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy application files
COPY . /app/
WORKDIR /app/

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade -r requirements.txt pytube

# Set environment variable
ENV COOKIES_FILE_PATH="youtube_cookies.txt"

# Start the application
CMD gunicorn app:app & python3 main.py
