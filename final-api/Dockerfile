FROM       final-ci/base-image:latest
MAINTAINER Ivo Reznicek <ireznice@googlemail.com>

ENV PROJECT_NAME final-api
ENV GIT_URL https://github.com/final-ci/$PROJECT_NAME.git

USER travis

RUN [ "/bin/bash", "-lc", "/home/travis/prepare_version.sh" ]

WORKDIR /home/travis/$PROJECT_NAME

RUN sudo apt-get update && \
  sudo apt-get install -y postgresql-client

ENV PORT 55555
EXPOSE $PORT

CMD [ "/bin/bash", "-lc", "/home/travis/start"]

