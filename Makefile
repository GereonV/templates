VENV := venv
override VENV_OK := $(VENV)/bin/activate
override PYTHON := $(VENV)/bin/python3
override PIP := $(VENV)/bin/pip
override MYPY := $(VENV)/bin/mypy
override FLAKE8 := $(VENV)/bin/flake8

.PHONY: build run test mypy clean

$(VENV_OK): requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r $<

build: $(VENV_OK)
	$(PYTHON) -m build

run: $(VENV_OK)
	$(PYTHON) -m template

test: $(VENV_OK)
	$(PYTHON) -m unittest discover -v -s tests -t .

mypy: $(VENV_OK)
	$(MYPY) src tests

flake8: $(VENV_OK)
	$(FLAKE8) src tests

clean:
	find . -name __pycache__ -exec rm -rf {} +
	find . -name '*.egg-info' -exec rm -rf {} +
	rm -rf dist .mypy_cache $(VENV)
