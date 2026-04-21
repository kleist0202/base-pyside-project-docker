#!/bin/bash
set -e

# Populate .venv on first run so the host IDE can resolve imports.
# The container itself always uses the system Python (faster startup).
# Check for PySide6 specifically — not just venv existence — so a bare venv
# created on the host still gets packages installed by Docker.
if [ ! -d "/app/.venv/lib/python3.12/site-packages/PySide6" ]; then
    echo "[entrypoint] Installing packages into .venv for IDE support..."
    python -m venv /app/.venv
    /app/.venv/bin/pip install --quiet --no-cache-dir --timeout=300 --retries=5 \
        -r /app/requirements.txt
    echo "[entrypoint] .venv ready — point your IDE to .venv/bin/python"
fi

exec python src/main.py
