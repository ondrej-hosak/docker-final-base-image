.PHONY: all logs hub api worker

all: logs hub api worker

baseimage:
	docker build -t "final-ci/base-image:latest" base-image

api: baseimage
	docker build -t "final-ci/final-api:latest" final-api

