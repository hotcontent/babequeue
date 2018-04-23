#!/bin/bash

if [ -n "$1" ]
then
  git fetch

  if [ "$(git branch --list $branch_name)" ]
  then 
    git checkout $1
  else 
    echo "Branch does not exist" && exit 1
  fi

  rm docker-compose.yml

  export BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
  export FEATURE_PORT=8001

  envsubst < "./docker-compose.template" > "./docker-compose.yml"
else
  echo "Specify branch name" && exit 1
fi
