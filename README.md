# github-repo-search
A Ruby on Rails project that consumes the github's API to search for repositories by name with the results being ordered by stargazers numbers.


## requirements

you need to have docker compose installed and configured in your machine

[install docker compose](https://docs.docker.com/compose/install/)

[post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/) 

### Setting up
build the repository. This might take a few minutes because it will need to download and setup everything needed.

```
$ docker-compose up --build
```

this is only necessary when getting the project for the first time or if you make changes to the Gemfile or the Compose file to try out some different configurations.

## How to run
to access the docker console you can:

1. up the compose in background
```
$ docker-compose up -d
```

2. find the container name
```
$ docker ps
```

3.  now get inside the container
```
$ docker container exec -it CONTAINER_NAME bash
```

## See how it works

![github_repo_search](https://user-images.githubusercontent.com/17392686/134446799-d945c62c-c624-4f37-ade5-4243492debfe.gif)



