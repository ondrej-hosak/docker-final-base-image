FROM       final-ci/base-image:latest
MAINTAINER Ivo Reznicek <ireznice@googlemail.com>

ENV PROJECT_NAME travis-logs
ENV GIT_URL https://github.com/final-ci/$PROJECT_NAME.git

ADD [ "./assets/*", "/home/travis/" ]

USER root

RUN [ "chown", "travis:travis", "/home/travis/prepare_version.sh", "/home/travis/start", "/home/travis/init.sh", "/home/travis/convert_config.rb" ]

USER travis

RUN [ "/bin/bash", "-lc", "/home/travis/prepare_version.sh" ]

WORKDIR /home/travis/$PROJECT_NAME

RUN sudo apt-get update && \
  sudo apt-get install -y postgresql-client

RUN mkdir -p /home/travis/logs

CMD [ "/bin/bash", "-lc", "/home/travis/start"]

