.PHONY: all logs hub api worker

all: logs hub api worker

baseimage:
	docker build -t "final-ci/base-image:latest" base-image

logs: baseimage
	docker build -t "final-ci/travis-logs:latest" travis-logs

hub: baseimage
	docker build -t "final-ci/travis-hub:latest" travis-hub

api: baseimage
	docker build -t "final-ci/final-api:latest" final-api

worker: baseimage
	docker build -t "final-ci/travis-worker:latest" travis-worker
