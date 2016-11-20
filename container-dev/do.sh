#!/bin/bash

# To use, run as follows:
#
#./do.sh rebuild <user> <password> <version>
#
# This will allow the client-dev container to be rebuilt with the newest
# package.json and other initial files so that the docker container is
# up-to-date with the newest dev branch of Quasar CLI and its needed
# dependencies.
#
# IMPORTANT!!!
# <user> and <password> are the credentials for Docker Hub.
# This shell script requires you to have set up your github access with ssh
# access and have write permissions in the quasarframework/docker repo.


# Input variables
USERNAME=$2
PASSWORD=$3
VERSION=$4

# Output colors
NORMAL='\033[0;39m'
RED='\033[0;31m'
BLUE='\033[0;34m'


log() {
  echo "$BLUE > $1 $NORMAL"
}

error() {
  echo ""
  echo "$RED >>> ERROR - $1$NORMAL"
}

clone-quasar-docker() {
  git clone https://github.com/quasarframework/quasar-docker.git
  cd quasar-docker/container-dev

  [ $? != 0 ] && \
    error "Quasar-docker cloning failed !" && exit 100
}

run-container() {
  docker-compose run -d container-dev

  [ $? != 0 ] && \
    error "Building of the container failed !" && exit 101

}

copy-from-container() {
   docker cp containerdev_container-dev_run_1:/tmp/app .

   [ $? != 0 ] && \
     error "Copying of the files filed" && exit 102
}

move-files() {
  cp ../client-dev/docker-compose.yml app
  cp ../client-dev/dockerfile app
  rm -r ../client-dev/.[!.]*
  rm -r ../client-dev/*
  mv app/.[!.]* ../client-dev
  mv app/* ../client-dev

  [ $? != 0 ] && \
    error "Copying of the files failed!" && exit 101
}

login-to-docker() {
  docker login -u $USERNAME -p $PASSWORD

  [ $? != 0 ] && \
    error "Logging in to Docker Hub failed" && exit 101
}

push-container() {
  docker push quasarframework/client-dev

  [ $? != 0 ] && \
    error "The container push to Docker Hub failed !" && exit 101
}

push-files() {
  cd ..
  git add .
  git commit -m 'updated client-dev to newest version'
  git push origin master

  [ $? != 0 ] && \
    error "The git push to Github failed !" && exit 101
}

do-cleanup() {

  [ $? != 0 ] && \
    error "The clean up failed !" && exit 101
}

# the main command
build() {
  log("Rebuilding the quasarframework/client-dev container....")
  clone-quasar-docker
  run-container
  copy-from-container
  move-files
  #login-to-docker
  #push-container
  #do-cleanup
  log("The rebulding of the container was successful!")
}

$*
