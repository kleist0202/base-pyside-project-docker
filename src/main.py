import sys
from PySide6.QtWidgets import (
    QApplication, QMainWindow, QWidget,
    QVBoxLayout, QPushButton, QLabel
)
from PySide6.QtCore import Qt


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("PySide6 Docker App")
        self.setMinimumSize(320, 200)

        central = QWidget()
        self.setCentralWidget(central)
        layout = QVBoxLayout(central)
        layout.setSpacing(16)
        layout.setContentsMargins(24, 24, 24, 24)

        self._count = 0
        self.label = QLabel("Count: 0")
        self.label.setAlignment(Qt.AlignCenter)
        self.label.setStyleSheet("font-size: 24px; font-weight: bold;")

        btn = QPushButton("Click me!")
        btn.setStyleSheet("font-size: 16px; padding: 8px;")
        btn.clicked.connect(self._increment)

        reset_btn = QPushButton("Reset")
        reset_btn.setStyleSheet("font-size: 14px; padding: 6px;")
        reset_btn.clicked.connect(self._reset)

        layout.addWidget(self.label)
        layout.addWidget(btn)
        layout.addWidget(reset_btn)

    def _increment(self):
        self._count += 1
        self.label.setText(f"Count: {self._count}")

    def _reset(self):
        self._count = 0
        self.label.setText("Count: 0")


def main():
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
