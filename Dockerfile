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

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2,2.1.5,jruby-1.7.16,jruby-1.7.18,jruby-1.7.19
