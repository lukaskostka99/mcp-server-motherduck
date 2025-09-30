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

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import sys; sys.exit(0)"

# Entry point - spuštění MCP serveru
# Parametry budou předány přes Smithery konfiguraci
ENTRYPOINT ["mcp-server-motherduck"]

# Default argumenty (mohou být přepsány)
CMD ["--db-path", "md:"]
