VENV := venv
override VENV_OK := $(VENV)/bin/activate
override PYTHON := $(VENV)/bin/python3
override PIP := $(VENV)/bin/pip

.PHONY: build run test clean

$(VENV_OK): requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r $<
	$(PIP) install -e .

build: $(VENV_OK)
	$(PYTHON) -m build

run: $(VENV_OK)
	$(PYTHON) -m template

test: $(VENV_OK)
	$(PYTHON) -m unittest discover -v -s tests

clean:
	find . -name __pycache__ -exec rm -rf {} +
	find . -name '*.egg-info' -exec rm -rf {} +
	rm -rf dist $(VENV)
