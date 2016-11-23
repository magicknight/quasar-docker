# quasar-docker container-dev
___

These files allow a core quasar developer to update the client-dev container and also update the initial files for developing 

## ./do build

In order to build the client-dev container and files, simple carry out the following command.

`./do.sh build <user> <password>`

The script will make sure of the following, before it will start.

1. There are no prebuilt quasarframework/client-dev images available. If there are, you'll have to delete them. 
2. There are no processes (containers) are already running and using any of the ports needed to run the container. If a port is taken, you'll have to stop the process. 

Running this script will allow the client-dev container to be rebuilt with the newest package.json and other initial files so that the docker container and image is up-to-date with the newest dev branch of Quasar CLI and its needed dependencies.

**IMPORTANT!!!** - The additional inputs `<user>` and `<password>` are the credentials for Docker Hub. 

You'll need to keep this file handy on your local computer and run it, when an update is necessary.