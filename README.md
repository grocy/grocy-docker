# grocy-docker

ERP beyond your fridge - now containerized!

This repository includes container build infrastructure for [grocy](https://github.com/grocy/grocy).

[![Docker Pulls](https://img.shields.io/docker/pulls/grocy/grocy.svg)](https://hub.docker.com/r/grocy/grocy/)
[![Docker Stars](https://img.shields.io/docker/stars/grocy/grocy.svg)](https://hub.docker.com/r/grocy/grocy/)

## Prerequisites

Follow [these instructions](https://docs.docker.com/install/) to get Docker running on your server.

## Quickstart

To get started using pre-built [Docker Hub grocy images](https://hub.docker.com/u/grocy), run the following commands:

```sh
export GROCY_IMAGE_TAG=v3.0.1-11
docker-compose pull
docker-compose up
```

The grocy application should now be accessible locally to the server:

 - [http://localhost](http://localhost)
 - [https://localhost](https://localhost)

Since the images contain self-signed certificates, your browser may display a warning when visiting the HTTPS URL.

### Configuration

The grocy application reads configuration settings from environment variables prefixed by `GROCY_`.

Runtime environment variables are read by `docker-compose` from the [grocy.env](grocy.env) file in this directory.

The default login credentials are username `admin` and password `admin`; please change these before providing end-user access to your deployment.

#### Demo Mode

To run the container in demo mode, override the `GROCY_MODE` environment variable at application run-time:

```sh
GROCY_MODE=demo docker-compose up
```

### Build

#### Docker Images

```sh
docker-compose build
```

### Vulnerability Scans

Support is provided for running image vulnerability scans using the [snyk](https://www.npmjs.com/package/snyk) CLI tool.

This requires authentication with [Snyk](https://snyk.io/) during the vulnerability scanning process.

You can read more about Snyk's vulnerability database [here](https://support.snyk.io/hc/en-us/articles/360003968978-How-efficient-is-our-Vulnerability-Database-).

To perform a vulnerability scan, use the following command:

```sh
npm run test
```

#### OCI Images

Optional support for building [opencontainer](https://www.opencontainers.org/) images is available via the [Makefile](Makefile) provided.
