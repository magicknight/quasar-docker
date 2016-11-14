# quasar-docker quasar-dev

Work In Progress

These `dockerfile` and `docker-composer.yml` files will set up the container for working directly on Quasar. It is intended for people who would like to work on Quasar directly.  

Steps to get started:

1. Fork the [Quasar-Framework repo](https://github.com/quasarframework/quasar) to your own Github repo. 
2. `git clone` your repo to a local directory. 
3. Copy the `dockerfile` and `docker-composer.yml` files into that same directory. 
4. In your shell console of choice, run `docker-compose up -d´ to build and run the container in detached mode.
5. Once the container is built, enter `docker-compose exec quasar-dev sh`.
6. You should be in the `/opt/app` directory in the container through the docker exec shell. Since the docker build also ran `npm install` for you, you now only need to run `npm run dev`.
7. Have fun programming for Quasar!

##Changing dependencies

If you have changed dependencies, (i.e. added a package to `packages.json`) you can rebuild the quasar-dev container with the following command in your local console (not the exec shell). 

`docker-compose build`

You could also just use `npm install <package>` in the containers exec shell, however you'd be adding the new package(s) outside the container's cached layer, which means subsequent installs will take longer. We recommend rebuilding the container. 

Please also note, added dependencies is currently frowned upon. Please check with Razvan in the [Quasar forum](http://forum.quasar-framework.org/) or on the Gitter channel, before adding any new dependencies. 

If you have any questions, please use the [Quasar forum](http://forum.quasar-framework.org/) or the [Gitter channel](https://gitter.im/quasarframework/Lobby). If you have any issue or suggestions, we'd be happy if you could report them in [Github](https://github.com/quasarframework/quasar-docker). 

That's it! Hope you enjoy the container.