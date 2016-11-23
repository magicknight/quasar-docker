#!/bin/bash

# To use, run as follows:
#
#./do.sh build <user> <password>
#
# This will allow the client-dev container to be rebuilt with the newest
# package.json and other initial files so that the docker container is
# up-to-date with the newest dev branch of Quasar CLI and its needed
# dependencies.
#
# IMPORTANT!!!
# <user> and <password> are the credentials for Docker Hub.

# Input
USERNAME=$2
PASSWORD=$3

# Output colors
NORMAL='\033[0;39m'
RED='\033[0;31m'
BLUE='\033[0;34m'

# Check open ports
NS=`netstat -an | grep -a 0.0.0.0:8080`

# Check for presence of image
IMAGE=`docker images -q quasarframework/client-dev`

log() {
  echo "$BLUE > $1 $NORMAL"
}

error() {
  echo ""
  echo "$RED >>> ERROR - $1$NORMAL"
}

if [ "$3" == "" ]
then
  error "Sorry, you forgot your Docker Hub username or password. Please try again." && exit 100
elif [ "$1" != "build" ]
then
  error "Use the command <build> only. Thank you!" && exit 101
fi

if [ "$NS" != "" ]
then
  error "Sorry, you must already be running something on Port 8080. Please stop that process and try again." && exit 100
fi

if [ "$IMAGE" != "" ]
then
  error "Sorry, you must remove the quasarframework/client-dev image with ID(s) $IMAGE, before building. Please delete the image(s) and try again." && exit 100
fi

clone-quasar-docker() {
  echo "Rebuilding the quasarframework/client-dev container...."
  git clone git@github.com:/quasarframework/quasar-docker.git
  cd quasar-docker/container-dev

  [ $? != 0 ] && \
    error "Quasar-docker cloning failed !" && exit 102
}

run-container() {
  docker-compose up -d

  [ $? != 0 ] && \
    error "Building of the container failed !" && exit 103

}

copy-from-container() {
   docker cp containerdev_container-dev_run_1:/tmp/app .

   [ $? != 0 ] && \
     error "Copying of the files from the contaier failed" && exit 104
}

move-files() {
  cp ../client-dev/docker-compose.yml app
  cp ../client-dev/dockerfile app
  rm -r ../client-dev/.[!.]*
  rm -r ../client-dev/*
  mv app/.[!.]* ../client-dev
  mv app/* ../client-dev
  rm -r app

  [ $? != 0 ] && \
    error "Copying of the files failed!" && exit 106
}

login-to-docker() {
  docker login -u $USERNAME -p $PASSWORD

  [ $? != 0 ] && \
    error "Logging in to Docker Hub failed" && exit 104
}

push-container() {
  docker push quasarframework/client-dev

  [ $? != 0 ] && \
    error "The container push to Docker Hub failed !" && exit 101
}

git-push-files() {
  cd ..
  git add .
  git commit -m 'updated client-dev to newest version'
  git push origin master

  [ $? != 0 ] && \
    error "The git push to Github failed !" && exit 106
}

clean-up() {
  docker-compose down
  docker rmi quasarframework/client-dev

  [ $? != 0 ] && \
    error "The clean-up failed!" && exit 107

  echo "The rebulding of the container was successful!"
}

# the main command
build() {
  run-container
  login-to-docker
  #push-container
  clean-up
}

$*
