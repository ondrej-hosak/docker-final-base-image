FROM       final-ci/base-image:latest
MAINTAINER Automation Development team <eng.op.autodev@avg.com>

ENV PROJECT_NAME final-api

USER travis

RUN git config --global url."https://".insteadof git://

RUN [ "git", "clone", "git@github.com:AVGTechnologies/final-api.git", "/home/travis/final-api"]

WORKDIR /home/travis/$PROJECT_NAME


RUN /bin/bash -c 'source ~/.rvm/scripts/rvm; bundle install'

RUN sudo apt-get update && \
  sudo apt-get install -y postgresql-client

ENV PORT 55555
EXPOSE $PORT

CMD [ "/bin/bash", "-lc", "/home/travis/start" ]
