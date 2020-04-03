# grocy-docker

ERP beyond your fridge - now containerized!

This repository includes container build infrastructure for [grocy](https://github.com/grocy/grocy).

[![Docker Pulls](https://img.shields.io/docker/pulls/grocy/grocy-docker.svg)](https://hub.docker.com/r/grocy/grocy/)
[![Docker Stars](https://img.shields.io/docker/stars/grocy/grocy-docker.svg)](https://hub.docker.com/r/grocy/grocy/)

## Prerequisites

Follow [these instructions](https://docs.docker.com/install/) to get Docker running on your server.

## Quickstart

To get started using pre-built [Docker Hub grocy images](https://hub.docker.com/u/grocy), run the following commands:

```sh
docker-compose pull
docker-compose up
```

The grocy application should now be accessible on your host:

 - [http://localhost](http://localhost)
 - [https://localhost](https://localhost)

Since the images contain self-signed certificates, your browser may display a warning when visiting the HTTPS URL.

### Configuration

The grocy application reads configuration settings from environment variables prefixed by `GROCY_`.

Some key settings are included in [grocy.env](grocy.env). The included version of this file sets `GROCY_MODE=demo`; this disables authentication and loads sample database entries.

#### Production Mode

To run the container in production mode, set `GROCY_MODE=production` in your environment and bring up the application:

```sh
GROCY_MODE=production docker-compose up
```

### Build

```sh
docker-compose build
```

Note: if you experience build failures as a result of GitHub API [rate limiting](https://developer.github.com/v3/#rate-limiting), you may optionally provide a GitHub API key (preferably restricted to `read:packages` scope) at build-time:

```sh
GITHUB_API_TOKEN='your-token-here' docker-compose build
```
