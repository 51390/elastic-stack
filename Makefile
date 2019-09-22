.PHONY: run_% run

setup:
	pip install -r requirements.txt

run: run_7.3.2

run_%: ENV_FILE_VERSION=`echo $* | sed 's/\([0-9]*\).*/\1/g'`
run_%: PROJECT_NAME=stack_`echo $* | sed 's/\./_/g'`

run_%: env_%
	ELASTICSEARCH_VERSION="$*" \
	KIBANA_VERSION="$*" \
	ENV_FILE_VERSION=$(ENV_FILE_VERSION) \
	docker-compose -f stack/docker-compose.yml -p $(PROJECT_NAME) up

env_%: 
	make stack/.env_elasticsearch_$(ENV_FILE_VERSION)
	make stack/.env_kibana_$(ENV_FILE_VERSION)

stack/.env_%:
	touch stack/.env_$*
