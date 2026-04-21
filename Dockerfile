FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    # Qt / OpenGL essentials
    libgl1 \
    libegl1 \
    libglib2.0-0 \
    libfontconfig1 \
    libdbus-1-3 \
    # X11
    libx11-6 \
    libxext6 \
    libxrender1 \
    # XCB platform plugin (Qt uses this under X11)
    libxcb1 \
    libxcb-cursor0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-util1 \
    libxcb-xinerama0 \
    libxcb-xkb1 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --timeout=300 --retries=5 -r requirements.txt

COPY . .

# Force XCB backend so the app works on both X11 and XWayland hosts
ENV QT_QPA_PLATFORM=xcb

CMD ["python", "src/main.py"]
