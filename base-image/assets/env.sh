#!/bin/bash

export ENV=${ENV:-"production"}

export FINAL_LOGS_DATABASE=${FINAL_LOGS_DATABASE:-"travis_logs_${ENV}"}
export FINAL_DATABASE=${FINAL_DATABASE:-"travis_${ENV}"}
export FINAL_AMQP_VHOST=${FINAL_AMQP_VHOST:-"travis_${ENV}"}
export FINAL_OUTPUT_LOGS_DIR=${FINAL_OUTPUT_LOGS_DIR:-"/var/log/finalci/logs"}
export RAILS_ENV=${RAILS_ENV:-${ENV}}
export RACK_ENV=${RACK_ENV:-${ENV}}

#see man login(1) and ENVIRON(7)
SHELL=/bin/bash
USER=${USER:-"travis"}
LOGNAME=travis
LC_MESSAGES=POSIX
LANG=en_US.UTF-8

source ~/.rvm/scripts/rvm
