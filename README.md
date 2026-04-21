# PySide6 Docker App

A simple PySide6 GUI application that runs inside a Docker container on any Linux distro.

## Project structure

```
.
├── src/
│   └── main.py            # application source
├── .venv/                 # auto-created on first run — use as IDE interpreter
├── Dockerfile
├── docker-compose.yml
├── entrypoint.sh          # creates .venv for IDE support, then starts the app
├── requirements.txt
├── .dockerignore
├── .gitignore
└── README.md
```

## Requirements

- Docker
- Docker Compose
- A running X11 display server (standard on any Linux desktop)

## Build

```bash
docker compose build
```

## Run

**1. Allow Docker to access your display** (required once per login session):

```bash
xhost +local:docker
```

**2. Start the app:**

```bash
docker compose up
```

The window will appear on your desktop. Close the window to stop the container.

On the **first run** the container also populates `.venv/` on your host so your
IDE can resolve imports without any separate installation step.

**3. Revoke display access when done** (optional but recommended):

```bash
xhost -local:docker
```

## IDE setup (import resolution)

After the first `docker compose up`, a `.venv/` folder will exist in the project root.
Point your IDE's Python interpreter to it:

| IDE | Setting |
|-----|---------|
| VS Code | `Python: Select Interpreter` → select `.venv/bin/python` |
| PyCharm | `Settings → Project → Python Interpreter` → add `.venv/bin/python` |

No separate `pip install` on the host is needed.

## Development

`src/` is bind-mounted into the container, so edits to source files are reflected
immediately — just restart the container:

```bash
docker compose restart
```

## Troubleshooting

**Error: `cannot connect to X server`**
Run `xhost +local:docker` before `docker compose up`.

**Error: `could not load the Qt platform plugin "xcb"`**
Rebuild the image:
```bash
docker compose build --no-cache
```

**Slow build / pip timeout**
PySide6 is large. The Dockerfile uses `--timeout=300 --retries=5`. If it still
fails, retry — Docker caches layers so it resumes from where it left off:
```bash
docker compose build
```
