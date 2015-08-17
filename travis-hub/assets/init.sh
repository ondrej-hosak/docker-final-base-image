#!/bin/bash

source ~/env.sh

cd ~/$PROJECT_NAME


#create a database when needed
pushd `bundle show travis-core`
rvm use 2.1.5
bundle
cp /home/travis/travis-hub/config/database.yml ./config/
bundle exec rake db:create db:migrate --trace
popd


#setup redis features
bundle exec ruby ../features.rb

#setup users and repositories according to config
bundle exec ruby ../default_db_content.rb < config/config.yml

#drop out the services which we are not interested in now
cp Procfile Procfile.bak
cat Procfile.bak | grep -v "worker" | grep -v "dispatch" | grep -v "enque" >Procfile


