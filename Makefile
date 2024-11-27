VENV := .venv
PY := python3
override PYTHON := $(VENV)/bin/python3
override BUILD := $(VENV)/bin/build

.PHONY: build clean
build: dist/
dist/: $(BUILD) src/ README.* LICENSE
	rm -rf dist
	$(PYTHON) -m build

$(VENV): pyproject.toml
	$(PY) -m venv $(VENV)
	$(PYTHON) -m pip install -e .
$(BUILD): $(VENV)
	$(PYTHON) -m pip install build

clean:
	find . -name __pycache__ -exec rm -rf {} +
	find . -name '*.egg-info' -exec rm -rf {} +
	rm -rf dist .mypy_cache $(VENV)
