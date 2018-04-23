#!/bin/bash

if [ -n "$1" ]
then
  git fetch

  if [ "$(git branch --list $1)" ]
  then 
    git checkout $1
  else 
    echo "Branch does not exist" && exit 1
  fi

  rm docker-compose.yml

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
