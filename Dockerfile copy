# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Set working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Copy the models file
COPY models.txt .

# Expose ports for Streamlit and Ollama
EXPOSE 8501
EXPOSE 11434

# Create startup script
RUN echo '#!/bin/bash\nollama serve &\nsleep 5\nollama pull deepseek-r1:1.5b\nstreamlit run app.py --server.address=0.0.0.0' > /app/start.sh \
    && chmod +x /app/start.sh

# Run the startup script when the container launches
CMD ["/app/start.sh"]