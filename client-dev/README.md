# quasar-docker client-dev

To get started developing an application with the Quasar Framework using Docker, you should have copied these files into your project's directory.

## package.json
If you want to add dependencies to your application's dev environment, please modify the `package.json` file accordingly. 

## docker-compose up

Next, start a shell console and enter

`$ docker-compose up -d`

This will get the docker container `clientdev_app_1` started and in detached mode. 

When the container is building, it will take several minutes. Once the container is started, you should be back to the cursor in the shell.

To shut down the container, naturally the command is 

`docker-composer down`

## docker cp - copy files to the host

Once the container is running, we'll need to get the initial files needed to work on Quasar. They have already been stored in the image and are on the new container. To get the files, carry out the following command.

`docker cp clientdev_app_1:/tmp/app .`

You can now enter the `/app` directory. This will be your starting point to develop with Quasar

## docker-compose exec

To get into the container to run the [Quasar CLI commands](http://quasar-framework.org/guide/quasar-cli.html) necessary to work with Quasar, or to start the server, run the following command.

`$ docker-compose exec app sh`

You should be in the root directory. You should now 

`cd /opt/app` 

into the working directory. This directory is also a shared volume with the `/app` directory on your host computer, so any changes to the files on the host are also reflected in the container. 

**Important**: As a last step, you will need to run 

`npm install`

so all the dependencies are installed too. If you wish to add any additional dependencies, please do so directly in the `package.json` file.

At this point, you can use all the [Quasar CLI commands](http://quasar-framework.org/guide/quasar-cli.html). 

For instance, if you'd like to start developing, you can enter

`$ quasar dev mat`

You should then be able to go to your browser and run `http://docker.local:8080` and see the Quasar (move your mouse) welcome page. 

Or, if you'd like you can add a component with 

`$ quaser new component hello`

You'll see the `hello.vue` component under the `/src/components` directory. 

## docker-compose build - adding new dependencies

As mentioned earlier, if you need to add new npm packages, you will need to alter your `packages.json` file directly and run the command

`$ docker-compose build`

Following this step will allow you to save the new package(s) into the Docker layer holding the nmp modules for faster loading later, should you store your image on Docker Hub. Once the container build is finished, you can re-up your container and start working again.

If you have any questions, please use the [Quasar forum](http://forum.quasar-framework.org/) or the https://gitter.im/quasarframework/Lobby. If you have any issue or suggestions, we'd be happy if you could report them in [Github](https://github.com/quasarframework/quasar-docker).

## docker tag and push - save your work!

Once you make changes, you'll more than likely want to save it and if it is finished work, upload the image to your repo on Docker Hub or any other container registry. To do this, first [re-tag the image](https://docs.docker.com/engine/reference/commandline/tag/) with the following command.

`$ docker tag <image-id> <repository-name>/<image-name>:<[optional] tag>` 

This should have renamed your image. 

Now you can "[push](https://docs.docker.com/engine/reference/commandline/push/)" your image to the registry. If, for example, you are going to be using Docker Hub, you'll need to [login](https://docs.docker.com/engine/reference/commandline/login/) first. To push the image to Docker Hub, use the following command.

`$ docker push <repository-name>/<image-name>:<[optional] tag>` 

You'll probably also want to commit and push your code changes to Github or some other CVS. 

That's it! Hope you enjoy the container.

