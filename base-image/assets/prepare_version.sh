#!/bin/bash

source ~/env.sh

CCOMMIT_FILE=/home/travis/$PROJECT_NAME/.current-commit
[ -f $CCOMMIT_FILE ] && [ $FINAL_VERSION == $(cat $CCOMMIT_FILE) ] && exit 0

echo "The requested version needs to be re-checked out....."

cd ~

if [ ! -d $PROJECT_NAME ]; then
  git clone $GIT_URL $PROJECT_NAME
fi

cd $PROJECT_NAME
if ! mountpoint -q /home/travis/$PROJECT_NAME; then
  echo -n "" > $CCOMMIT_FILE #in case that this script fails
  git fetch
  git checkout $FINAL_VERSION
fi

#because of rvm and correct ruby version
cd ..
cd $PROJECT_NAME

git config --global url."https://".insteadof git://

bundle install --jobs 8

git rev-parse HEAD > $CCOMMIT_FILE

