# quasar-docker container-dev
___

These files allow a core quasar developer to update the client-dev container and also update the initial files for developing 

## ./do build

In order to build the client-dev container and files, simple carry out the following command.

`./do.sh build <user> <password>`

This will allow the client-dev container to be rebuilt with the newest package.json and other initial files so that the docker container and image is up-to-date with the newest dev branch of Quasar CLI and its needed dependencies.

IMPORTANT!!!
<user> and <password> are the credentials for Docker Hub. 

You'll need to keep this file handy on your local computer and run it, when an update is necessary.