#!/bin/bash

source ~/env.sh

sudo socat TCP-LISTEN:4243,fork,bind=127.0.0.1 UNIX:/var/run/docker.sock &

