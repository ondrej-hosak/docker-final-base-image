# Dockerized final-api application


## create base image
     cd base-image
     sudo docker build -t "final-ci/base-image:latest" .
     cd ..

## create other app images
     cd travis-logs
     #create travis-logs image
     sudo docker build -t "final-ci/travis-logs:latest" .
     cd ../travis-hub

     #create travis-hub image
     sudo docker build -t "final-ci/travis-hub:latest" .
     cd ../final-api

     #create final-api image
     sudo docker build -t "final-ci/final-api:latest" .
     cd ../travis-worker

     #create travis-worker image
     sudo docker build -t "final-ci/travis-worker:latest" .
     cd ..

## prepare custom configs
     cp config/config.example.yml config/config.yml
     #and adjust your users and repositories

     cp config/travis.example.yml config/travis.yml
     #and adjust your config for travis-hub, final-api and travis-logs

     cp config/worker.example.yml config/worker.yml
     #and adjust your config for travis-worker

## run pre-requisities
     sudo docker run --name final-postgress -e POSTGRES_PASSWORD=mysecretpassword -d postgres:9.3
     sudo docker run --name final-redis -d redis:3.0.3
     sudo docker run --name final-rabbitmq -d rabbitmq:3.5.3

## run travis services in development mode

     cd config
     #logs
     sudo docker run --link final-postgress:postgresql --link final-redis:redis --link final-rabbitmq:rabbitmq --name final-travis-logs --rm -v `pwd`/travis.yml:/travis.yml -v /mnt/data:/var/log/finalci/logs -e ENV=development -t 'final-ci/travis-logs:latest'

     #hub
     sudo docker run --link final-postgress:postgresql --link final-redis:redis --link final-rabbitmq:rabbitmq --name final-travis-hub --rm -v `pwd`/travis.yml:/travis.yml -v `pwd`/database.yml:/database.yml -v `pwd`/config.yml:/config.yml -e ENV=development -t 'final-ci/travis-hub:latest'

     #api
     sudo docker run --link final-postgress:postgresql --link final-redis:redis --link final-rabbitmq:rabbitmq --name final-api --rm -v `pwd`/travis.yml:/travis.yml -v /mnt/data:/var/log/finalci/logs -p 55555:55555 -e ENV=development -t 'final-ci/final-api:latest'

     #worker
     sudo docker run --link final-postgress:postgresql --link final-redis:redis --link final-rabbitmq:rabbitmq --name travis-worker-docker --rm -v `pwd`/worker.yml:/worker.yml -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`/id_rsa:/id_rsa -e ENV=development -t 'final-ci/travis-worker:latest'
     cd ..

## run travis services in production mode

     cd config
     #logs
     sudo docker run --link final-postgress:postgresql --link final-redis:redis --link final-rabbitmq:rabbitmq --name final-travis-logs --rm -v `pwd`/travis.yml:/travis.yml -v /mnt/data:/var/log/finalci/logs -e ENV=production -t 'final-ci/travis-logs:latest'

     #hub
     sudo docker run --link final-postgress:postgresql --link final-redis:redis --link final-rabbitmq:rabbitmq --name final-travis-hub --rm -v `pwd`/travis.yml:/travis.yml -v `pwd`/database.yml:/database.yml -v `pwd`/config.yml:/config.yml -e ENV=production -t 'final-ci/travis-hub:latest'

     #api
     sudo docker run --link final-postgress:postgresql --link final-redis:redis --link final-rabbitmq:rabbitmq --name final-api --rm -v `pwd`/travis.yml:/travis.yml -v /mnt/data:/var/log/finalci/logs -p 55555:55555 -e ENV=production -t 'final-ci/final-api:latest'

     #worker
     sudo docker run --link final-postgress:postgresql --link final-redis:redis --link final-rabbitmq:rabbitmq --name travis-worker-docker --rm -v `pwd`/worker.yml:/worker.yml -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`/id_rsa:/id_rsa -e ENV=production -t 'final-ci/travis-worker:latest'
     cd ..

## test dockerized application
     git clone https://github.com/final-ci/final-runner.git
     cd final-runner

     #test application
     ruby ./run.rb -d -b http://localhost:55555 ./examples/stash-payload.json

     #it should be noted that some fields from stash-payload.json file
     #should be adjusted according to your current configuration files before testing of specific environment.


