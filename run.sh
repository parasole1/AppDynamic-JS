#!/bin/bash

DOCKER_PREFIX="svrnm/apm-game-"
DOCKER_NETWORK="${DOCKER_PREFIX}network"

(
  cd master/ || exit
  npm install
);

for DIR in nodes/*;
do
  docker build -t "${DOCKER_PREFIX}`basename $DIR`" $DIR;
done;

docker network create ${DOCKER_NETWORK}

node master/index.js config.yml ${DOCKER_PREFIX} ${DOCKER_NETWORK}

docker network rm ${DOCKER_NETWORK}
