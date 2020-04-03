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

### Environment variables:

As of grocy v1.24.1, grocy will read configuration settings from environment variables as long as they are prefixed by `GROCY_`. Some key items are included in  `grocy.env`. The shipped version of this file sets `GROCY_MODE=demo`, which will load some sample entries into the database, and doesn't require authentication. Set `GROCY_MODE=production` to put the application in production mode and require login. 

For example, to change the language from English to French, you can modify

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

## License
The MIT License (MIT)
