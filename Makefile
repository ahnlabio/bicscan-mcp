PROJECT_NAME := $(shell \
	if [ -f pyproject.toml ]; then \
		NAME_FROM_PYPROJECT=$$(awk '/^\[project\]/{flag=1; next} /^\[/{flag=0} flag && /^name *=/{gsub(/name *= *"|"/, "", $$0); gsub(/ /, "", $$0); print}' pyproject.toml); \
		if [ -n "$$NAME_FROM_PYPROJECT" ]; then \
			echo "$$NAME_FROM_PYPROJECT"; \
		else \
			NAME_FROM_POETRY=$$(awk '/^\[tool\.poetry\]/{flag=1; next} /^\[/{flag=0} flag && /^name *=/{gsub(/name *= *"|"/, "", $$0); gsub(/ /, "", $$0); print}' pyproject.toml); \
			if [ -n "$$NAME_FROM_POETRY" ]; then \
				echo "$$NAME_FROM_POETRY"; \
			else \
				echo $$(basename $$(pwd)); \
			fi; \
		fi; \
	else \
		echo $$(basename $$(pwd)); \
	fi \
)

# Get exposed ports from Dockerfile if it exists
EXPOSED_PORTS := $(shell if [ -f Dockerfile ]; then grep -oE 'EXPOSE[[:space:]]+[0-9]+' Dockerfile | awk '{print "-p "$$2":"$$2}' | tr '\n' ' '; fi)

# Check if .env file exists and set env flag accordingly
ENV_FLAG := $(shell if [ -f .env ]; then echo "--env-file .env"; fi)

all:
	echo "Running for ${PROJECT_NAME}"
	docker image prune -f
	docker build -t ${PROJECT_NAME} .

build:
	docker image prune -f
	docker build -t ${PROJECT_NAME} .

run:
	echo "stopping previous container"
	-docker stop ${PROJECT_NAME}
	echo "removing ${PROJECT_NAME}"
	-docker container rm ${PROJECT_NAME}
	echo "start running"
	docker run --rm -it ${EXPOSED_PORTS} --name ${PROJECT_NAME} ${ENV_FLAG} ${PROJECT_NAME}:latest

serve:
	echo "stopping previous container"
	-docker stop ${PROJECT_NAME}
	echo "removing ${PROJECT_NAME}"
	-docker container rm ${PROJECT_NAME}
	echo "start running"
	docker run -d --restart unless-stopped ${EXPOSED_PORTS} --name ${PROJECT_NAME} ${ENV_FLAG} -v $(PWD)/data:/app/data ${PROJECT_NAME}:latest

shell:
	docker exec -it ${PROJECT_NAME}:latest /bin/bash

clean:
	docker image prune -f
	# rm -rf __pycache__/ data email.db ${PROJECT_NAME}.tar

logs:
	docker logs -f ${PROJECT_NAME}

export:
	docker save -o ${PROJECT_NAME}.tar ${PROJECT_NAME}:latest
	echo "Docker image saved as ${PROJECT_NAME}.tar"

stop:
	@docker stop ${PROJECT_NAME}

