# quasar-docker client-dev

To get started developing an application with the Quasar Framework using Docker, you should have copied these files into your project's directory.

##package.json
If you want to add dependencies to your application's dev environment, please modify the `package.json` file accordingly. 

##docker-compose up

Next, start a shell console and enter

`docker-compose up -d`

This will get the docker container `app_app_1` started and in detached mode. 

When the container is building, it will take several minutes. Once the container is started, you should be back to the cursor in the shell.  

##docker-compose exec

To get into the container to run the Quasar CLI commands necessary to work with Quasar, run the following command.

`docker-compose exec app sh`

You should be in the `/opt/app` directory, which is your working directory in the container. It is also a shared volume with the current directory on your host computer, so any changes to the files are also reflected in the container's working directory. 

At this point, you can use all the [Quasar CLI commands](http://quasar-framework.org/guide/quasar-cli.html). 

For instance, if you'd like to start developing, you can enter

`quasar dev mat`

You should then be able to go to your browser and run `http://docker.local:8080` and see the Quasar (move your mouse) welcome page. 

Or, if you'd like you can add a component with 

`quaser new component hello`

You'll see the `hello.vue` component under the `/src/components` directory. 

##dock-compose build - adding new dependencies

If you need to add new npm packages, you will need to alter your `packages.json` file directly and run the command

`docker-compose build`

Following this step will allow you to save the new package(s) into the Docker layer holding the nmp modules for faster loading later, should you store your image on Docker Hub. Once the container build is finished, you can re-up your container and start working again.

If you have any questions, please use the [Quasar forum](http://forum.quasar-framework.org/) or the https://gitter.im/quasarframework/Lobby. If you have any issue or suggestions, we'd be happy if you could report them in [Github](https://github.com/quasarframework/quasar-docker). 

That's it! Hope you enjoy the container.
