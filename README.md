# Grocy on Docker

ERP beyond your fridge - now containerized! This is the docker repo of [https://github.com/grocy/grocy](grocy).

[![Docker Pulls](https://img.shields.io/docker/pulls/grocy/grocy-docker.svg)](https://hub.docker.com/r/grocy/grocy-docker/)
[![Docker Stars](https://img.shields.io/docker/stars/grocy/grocy-docker.svg)](https://hub.docker.com/r/grocy/grocy-docker/)

## Install Docker

Follow [these instructions](https://docs.docker.com/engine/installation/) to get Docker running on your server.


### Available on Docker Hub (prebuilt) or built from source

```
docker pull grocy/grocy-docker
```

Or build from source

```
docker-compose build
```

Anyhow, to run using docker just do the following:

```
> docker-compose up
```

And grocy should be accessible via `http(s)://localhost/`. The https option will work. However, since the certificate is self-signed, most browsers will complain.

## Additional Information

The docker images build are based on [Alpine](https://hub.docker.com/_/alpine/), with an extremelly low footprint (less than 10 MB for nginx, and less than 70MB for grocy with php-fm. That number is eventually bumped up to 353MB after all the dependencies are downloaded, however). 

## License
The MIT License (MIT)