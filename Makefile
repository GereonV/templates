VENV := venv
PY := python3
override VENV_OK := $(VENV)/bin/activate
override PYTHON := $(VENV)/bin/python3
override PIP := $(VENV)/bin/pip
override MYPY := $(VENV)/bin/mypy
override FLAKE8 := $(VENV)/bin/flake8

.PHONY: build install uninstall run test mypy flake8 clean

$(VENV_OK): requirements.txt pyproject.toml
	$(PY) -m venv $(VENV)
	$(PIP) install -r $<

dist/: $(VENV_OK) src/ README.* LICENSE
	rm -rf dist
	$(PYTHON) -m build
build: dist/

install: build
	$(PY) -m pip install --user dist/*.whl

uninstall:
	$(PY) -m pip uninstall template

run: $(VENV_OK)
	$(PYTHON) -m template

test: $(VENV_OK)
	$(PYTHON) -m unittest discover -v -s tests -t .

mypy: $(VENV_OK)
	$(MYPY) --strict src tests

flake8: $(VENV_OK)
	$(FLAKE8) src tests

clean:
	find . -name __pycache__ -exec rm -rf {} +
	find . -name '*.egg-info' -exec rm -rf {} +
	rm -rf dist .mypy_cache $(VENV)
