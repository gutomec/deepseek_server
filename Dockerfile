FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://ollama.com/install.sh | sh

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

COPY models.txt .

EXPOSE 8501
EXPOSE 11434

RUN echo '#!/bin/bash\nollama serve &\nsleep 5\nollama pull deepseek-r1:1.5b\nollama pull deepseek-r1:32b\nstreamlit run app.py --server.address=0.0.0.0' > /app/start.sh \
    && chmod +x /app/start.sh

CMD ["/app/start.sh"]