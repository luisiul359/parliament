SHELL=/bin/bash

.PHONY = setup init run test clean format_code

# Defines the default target that `make` will try to make, or in the case of a phony target, execute the specified commands
# This target is executed whenever we just type `make`
.DEFAULT_GOAL = run

# This will install the package manager Poetry
setup:
	curl -sSL https://install.python-poetry.org/ | ${PYTHON} -
	@echo "Done."

init:
	poetry install

runlocal:
	poetry run uvicorn src.app.main:app --reload --env-file .env

run:
	docker build -t portuguese-politics .
	docker run -d --name portuguese-politics -p 80:8000 portuguese-politics

test:
	#mkdir -p data
	poetry run pytest tests # --cov=. --cov-report=xml:data/unit_coverage.xml

clean:
	rm -r .venv 

format_code:
	poetry run black .
	poetry run isort .
