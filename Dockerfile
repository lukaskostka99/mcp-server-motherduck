# Dockerfile pro mcp-server-motherduck
# Smithery vyžaduje Dockerfile pro build a deployment

FROM python:3.11-slim

# Nastavení working directory
WORKDIR /app

# Instalace uv (rychlý Python package manager)
RUN pip install --no-cache-dir uv

# Kopírování project files
COPY pyproject.toml ./
COPY uv.lock ./
COPY src/ ./src/
COPY README.md ./
COPY LICENSE ./

# Instalace dependencies pomocí uv
RUN uv pip install --system --no-cache .

# Environment variables (nastavené přes Smithery config)
ENV PYTHONUNBUFFERED=1

# Expose port pro HTTP stream transport
EXPOSE 8000

# Health check - kontrola HTTP endpointu
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/mcp').read()" || exit 1

# Entry point - spuštění MCP serveru v stream režimu
# Parametry budou předány přes Smithery konfiguraci
ENTRYPOINT ["mcp-server-motherduck", "--transport", "stream", "--port", "8000"]

# Default argumenty (mohou být přepsány)
CMD ["--db-path", "md:"]
