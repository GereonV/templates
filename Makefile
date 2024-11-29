VENV := .venv
PY := python3
override PYTHON := $(VENV)/bin/python3
override BUILD := $(VENV)/bin/build
override DEV := $(VENV)/bin/mypy

.PHONY: env
env: $(VENV)
$(VENV): pyproject.toml
	$(PY) -m venv $(VENV)
	$(PYTHON) -m pip install -e .

.PHONY: test mypy
test: $(DEV)
	$(PYTHON) -m pytest --color=yes tests
mypy: $(DEV)
	$(PYTHON) -m mypy --strict --show-error-context --pretty src tests
$(DEV): $(VENV)
	$(PYTHON) -m pip install -e .[dev]

.PHONY: build
build: dist/
dist/: $(BUILD) src/ README.* LICENSE
	rm -rf dist
	$(PYTHON) -m build
$(BUILD): $(VENV)
	$(PYTHON) -m pip install build

.PHONY: clean
clean:
	find . -name __pycache__ -exec rm -rf {} +
	find . -name '*.egg-info' -exec rm -rf {} +
	rm -rf dist .mypy_cache $(VENV)
