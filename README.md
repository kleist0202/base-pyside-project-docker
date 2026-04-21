# PySide6 Docker App

A simple PySide6 GUI application that runs inside a Docker container on any Linux distro.

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

**3. Revoke display access when done** (optional but recommended):

```bash
xhost -local:docker
```

## Troubleshooting

**Error: `cannot connect to X server`**
Run `xhost +local:docker` before `docker compose up`.

**Error: `could not load the Qt platform plugin "xcb"`**
Missing XCB libraries. Rebuild the image:
```bash
docker compose build --no-cache
```

**Slow build / pip timeout**
PySide6 is a large package. The Dockerfile uses `--timeout=300 --retries=5` to handle slow connections. If it still fails, retry:
```bash
docker compose build
```
Docker caches layers, so it will resume from where it left off.
