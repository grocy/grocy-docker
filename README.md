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
docker-compose pull
docker-compose up
```

This will retrieve and start the most recent container images corresponding to the version tag found in [docker-compose.yml](docker-compose.yml).

The grocy application should now be accessible locally to the server:

 - [http://localhost:8080](http://localhost:8080)

### Configuration

The grocy application reads configuration settings from environment variables prefixed by `GROCY_`.

Runtime environment variables are read by `docker-compose` from the [grocy.env](grocy.env) file in this directory.

The default login credentials are username `admin` and password `admin`; please change these before providing end-user access to your deployment.

#### Demo Mode

To run the container in demo mode, override the `GROCY_MODE` environment variable at application run-time:

```sh
GROCY_MODE=demo docker-compose up
```

#### Upgrades

The Grocy application is [stateful](https://en.wikipedia.org/wiki/State_(computer_science)), and stores data within a containerized filesystem under the `/var/www/data/` path.

Although most of the container's filesystem is read-only, Docker provides long-term storage to Grocy using [volumes](https://docs.docker.com/storage/volumes/), including a volume named `app-db` that holds the contents of `/var/www/data/`.

During an upgrade of containerized Grocy, it's recommended to follow these steps:

1. Logout of the Grocy application, to pause write activity

2. Stop the application's containers

```sh
docker-compose stop
```

3. Take a [backup](https://docs.docker.com/storage/volumes/#back-up-restore-or-migrate-data-volumes) of the Grocy application data (`app-db` volume)

4. Update the contents of this repository (`grocy-docker`) to the latest version

```sh
git pull
```

5. Retrieve container images corresponding to the versions listed in `docker-compose.yml`

```sh
docker-compose pull
```

6. Start the application's containers

```sh
docker-compose up
```

#### Image Versioning

Container images published by this repository currently have a human-readable format that begins with the Grocy application version number and includes an incremental integer suffix to indicate the image-build revision.

When a container image is published (for example, one tagged as `v3.3.1-6` using this version scheme), a "prefix-only" tag is also attached to the release (`v3.3.1`, to continue the example).  This allows users who are comfortable with a given version of Grocy to update to the latest container for that version without having to discover a specific revision number.

Each published image also has a corresponding `git` tag.  This is to allow anyone running, inspecting, or planning to upgrade containers to retrieve and compare the build instructions for published containers (although this does not, in itself, provide a complete view of the contents of the relevant containers -- something that can vary depending on the time and environment in which they are built).

Revisions are necessary to allow the structure of the container to change.  For example, we may upgrade the operating system components of the container to improve performance, functionality and security.  This doesn't require any change to the Grocy application code, so the prefix remains the same.

Since maintenance and testing are volunteer-led and time-limited, we do not currently backport changes to earlier released application versions.  In other words: fixes are generally applied only to the most-recent released version of the container image.

This versioning policy could and should evolve over time.

### Build

#### Docker Images

```sh
docker-compose build
```

#### OCI Images

Optional support for building [opencontainer](https://www.opencontainers.org/) images is available via the [Makefile](Makefile) provided.
