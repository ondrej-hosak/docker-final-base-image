FROM       final-ci/base-image:latest
MAINTAINER Automation Development team <eng.op.autodev@avg.com>

ENV PROJECT_NAME final-api

USER travis

WORKDIR /home/travis/$PROJECT_NAME

RUN sudo apt-get update && \
  sudo apt-get install -y postgresql-client

ENV PORT 55555
EXPOSE $PORT

CMD [ "/bin/bash", "-lc", "/home/travis/init.sh" ]

