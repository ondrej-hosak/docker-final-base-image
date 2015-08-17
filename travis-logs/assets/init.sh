#!/bin/bash

source ~/env.sh

if PGPASSWORD=$POSTGRESQL_ENV_POSTGRES_PASSWORD psql -U postgres -h $POSTGRESQL_PORT_5432_TCP_ADDR -d $FINAL_LOGS_DATABASE -c '\q' 2>&1; then

  echo "$FINAL_LOGS_DATABASE database already exists"

else

  PGPASSWORD=$POSTGRESQL_ENV_POSTGRES_PASSWORD psql -U postgres -h $POSTGRESQL_PORT_5432_TCP_ADDR -c "CREATE DATABASE $FINAL_LOGS_DATABASE;"
  echo "$FINAL_LOGS_DATABASE database created"

fi

cd ~/$PROJECT_NAME
bundle exec rake db:migrate

