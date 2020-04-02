# Grocy on Docker

ERP beyond your fridge - now containerized! This is the docker repo of [grocy](https://github.com/grocy/grocy).

[![Docker Pulls](https://img.shields.io/docker/pulls/grocy/grocy-docker.svg)](https://hub.docker.com/r/grocy/grocy-docker/)
[![Docker Stars](https://img.shields.io/docker/stars/grocy/grocy-docker.svg)](https://hub.docker.com/r/grocy/grocy-docker/)

## Install Docker

Follow [these instructions](https://docs.docker.com/engine/installation/) to get Docker running on your server.

## Available on Docker Hub (prebuilt) or built from source

### To run using docker just do the following:

```
> docker-compose pull # if you haven't pulled or built
> docker-compose up
```

And grocy should be accessible via `http(s)://localhost/`. The https option will work. However, since the certificate is self-signed, most browsers will complain.

Note: if you have not pulled any of the images from the repository, when you do an `up`, it will attempt to build from scratch!

### To pull the latest images to your machine:

```
docker pull grocy/nginx
docker pull grocy/grocy
```

Or just `docker-compose pull`.

### Environmental variables:

As of grocy v.1.24.1, ENV variables are accessible via the `docker-compose.yml` file as long as they are prefixed by `GROCY_`. For example, to change the language from English to French, you can modify

```
GROCY_CULTURE: en
```

to

```
GROCY_CULTURE: fr
```

### To build from scratch

```
docker-compose build
```

Note: if you experience build failures as a result of GitHub API rate limiting, you may optionally provide a GitHub API key (preferably restricted to `read:packages` scope) at build-time:

```
docker-compose build --build-arg GITHUB_API_TOKEN="your-token-here"
```

## Additional Information

The docker images build are based on [Alpine](https://hub.docker.com/_/alpine/), with an extremely low footprint (less than 10 MB for nginx, and less than 70MB for grocy with php-fm. That number is eventually bumped up to 490MB after all the dependencies are downloaded, however).

## License
The MIT License (MIT)
