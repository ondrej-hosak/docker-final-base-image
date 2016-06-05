FROM       final-ci/base-image:latest
MAINTAINER Ivo Reznicek <ireznice@googlemail.com>

ENV PROJECT_NAME travis-hub
ENV GIT_URL https://github.com/AVGTechnologies/$PROJECT_NAME.git

COPY [ "./assets/*", "/home/travis/" ]

USER root

RUN [ "chown", "travis:travis", "/home/travis/prepare_version.sh", "/home/travis/start", "/home/travis/init.sh", "/home/travis/convert_config.rb", "/home/travis/features.rb" ]

USER travis

RUN [ "/bin/bash", "-lc", "/home/travis/prepare_version.sh" ]

RUN [ "/bin/bash", "-lc", "cd /home/travis/travis-hub; source /home/travis/.rvm/scripts/rvm; cd `bundle show travis-core`; rvm use 2.1.5; pwd; bundle;"]

WORKDIR /home/travis/$PROJECT_NAME

RUN sudo apt-get update && \
  sudo apt-get install -y postgresql-client

CMD [ "/bin/bash", "-lc", "/home/travis/start"]

