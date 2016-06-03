FROM       ubuntu:14.04.2
MAINTAINER Lukáš Svoboda <lukas.svoboda@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN useradd -m -s /bin/bash travis
RUN chown -R travis:travis /home/travis
RUN echo 'travis ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX && \
  locale-gen en_US.UTF-8 && \
  dpkg-reconfigure locales

RUN apt-get update && \
    apt-get install -y \
      build-essential \
      curl \
      git-core \
      libssl-dev \
      libreadline-dev \
      libyaml-dev \
      libxml2-dev \
      libxslt-dev \
      libcurl4-openssl-dev \
      libffi-dev \
      python-software-properties \
      libpq-dev \
      zlib1g-dev \
      wget

USER travis

ENV CONFIGURE_OPTS --disable-install-doc
RUN echo 'gem: --no-rdoc --no-ri' >> /home/travis/.gemrc

RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
#RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.2,2.1.5,jruby-1.7.16,jruby-1.7.18,jruby-1.7.19 --gems=foreman

# because invalid .gemspec file in remote gem https://github.com/joshk/sshjr/issues/3
# old version of bundler does not validate .gemspec file
RUN /bin/bash -lc 'source /home/travis/.rvm/scripts/rvm ; rvm 1.7.16,1.7.18,1.7.19,2.1.5,2.2.2 do gem install bundler -v 1.9.4'

ENV FINAL_VERSION master

USER root

COPY "./assets/*" "/home/travis/"

RUN [ "chown", "travis:travis", "/home/travis/prepare_version.sh", "/home/travis/start", "/home/travis/init.sh", "/home/travis/convert_config.rb", "/home/travis/env.sh", "/home/travis/default_db_content.rb"]

# in normal environment this should be removed
# RUN [ "git", "config", "--global", "url.\"https://\".insteadOf", "git://" ]
# RUN [ "git", "config", "--global", "url.\"https://\".insteadOf", "ssh://" ]

