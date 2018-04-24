#!/bin/bash

if [ -n "$1" ]
then
  git fetch

  [ -e dokcer-compose.yml ] && rm docker-compose.yml

  BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
  FEATURE_PORT=8000 


  if [ "$(docker ps | grep $FEATURE_PORT)" ]
  then
    FEATURE_PORT=$((FEATURE_PORT+1))
  fi

  export FEATURE_PORT=$FEATURE_PORT
  export BRANCH_NAME=$BRANCH_NAME

  envsubst < "./docker-compose.template.yml" > "./docker-compose.yml"

  docker-compose up -d --build
  rm docker-compose.yml
else
  echo "Specify branch name" && exit 1
fi
