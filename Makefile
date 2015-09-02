.PHONY: all logs hub api worker

all: logs hub api worker

baseimage:
	sudo docker build -t "final-ci/base-image:latest" base-image

logs: baseimage
	sudo docker build -t "final-ci/travis-logs:latest" travis-logs

hub: baseimage
	sudo docker build -t "final-ci/travis-hub:latest" travis-hub

api: baseimage
	sudo docker build -t "final-ci/final-api:latest" final-api

worker: baseimage
	sudo docker build -t "final-ci/travis-worker:latest" travis-worker

