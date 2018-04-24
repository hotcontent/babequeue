#!/bin/bash
git fetch

GIT_BRANCH="$(echo $1)"
BRANCH_NAME="$(echo ${GIT_BRANCH//origin\//''})"

echo ${BRANCH_NAME}

if [ "$(git branch --list | grep $BRANCH_NAME)" ]
then
  git checkout $BRANCH_NAME
  git pull
else
  git checkout -b $BRANCH_NAME $GIT_BRANCH
fi

[ -e dokcer-compose.yml ] && rm docker-compose.yml

FEATURE_PORT=8000 

while [ "$(docker ps | grep $FEATURE_PORT)" ]
do
  FEATURE_PORT=$((FEATURE_PORT+1))
done

export FEATURE_PORT=$FEATURE_PORT
export BRANCH_NAME=$BRANCH_NAME

envsubst < "./docker-compose.template.yml" > "./docker-compose.yml"

docker-compose up -d --build
rm docker-compose.yml