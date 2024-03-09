# grocy-docker

> [!NOTE]
> This project (grocy-docker, not [Grocy](https://github.com/grocy/grocy) itself) is currently unmaintained and looking for a new maintainer.
>
> If you're interested in taking that role, please familiarize yourself with the current release automation (issue [#109](https://github.com/grocy/grocy-docker/issues/109)), and contact @jayaddison and @berrnd to register your interest in issue thread [#127](https://github.com/grocy/grocy-docker/issues/127).

ERP beyond your fridge - now containerized!

This repository includes container build infrastructure for [grocy](https://github.com/grocy/grocy).

[![Docker Pulls](https://img.shields.io/docker/pulls/grocy/backend.svg)](https://hub.docker.com/r/grocy/backend/)
[![Docker Stars](https://img.shields.io/docker/stars/grocy/backend.svg)](https://hub.docker.com/r/grocy/backend/)

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

The Grocy application is [stateful](https://en.wikipedia.org/wiki/State_(computer_science)), and stores data within a containerized filesystem under the `/var/www/data/` directory.

Although most of the container's filesystem is read-only, Docker provides long-term storage to Grocy using [volumes](https://docs.docker.com/storage/volumes/). The contents of the `/var/www/data` directory are held in a volume named `app-db`.

During an upgrade of containerized Grocy, it's recommended to follow these steps:

1. Log all users out of the Grocy application, to pause write activity

2. Stop the application's containers

```sh
docker-compose stop
```

3. Take a [backup](https://docs.docker.com/storage/volumes/#back-up-restore-or-migrate-data-volumes) of the Grocy application data (`app-db` volume)

4. Update the contents of this repository (`grocy-docker`) to the latest version

```sh
git pull
```

5. Download the container images corresponding to the versions listed in `docker-compose.yml`

```sh
docker-compose pull
```

6. Start the application's containers

```sh
docker-compose up --detach
```

7. Log back in to Grocy, to check that the system is working

#### Image Versioning

Each container image published by this repository is associated with a human-readable version number that begins with the Grocy application version number (`v3.3.1`, for example), followed by an integer suffix (revision number) that starts from zero.

When a container image is published (for example, one tagged as `v3.3.1-6` using this version scheme), a plain Grocy version tag is also attached to the release (`v3.3.1`, to continue the example).  This allows users who are comfortable with a given version of Grocy to update to the latest container for that version without having to choose a specific revision number.

Each published image also corresponds to a `git` tag in the `grocy-docker` repository.  This is to allow anyone running, inspecting, or planning to upgrade `grocy-docker` containers to retrieve and compare the build instructions for specific versions.  Reading the build instructions does not, by itself, provide a complete view of the published contents of the containers -- something that can vary depending on the time and environment in which the containers are built.

The integer revision numbers (suffixes) are necessary to allow the structure of the container to change even if the version of Grocy running within them does not.  For example, we may upgrade the operating system components of the container to improve performance, functionality and security.  This doesn't require any change to the Grocy application code, so the prefix remains the same.

Since maintenance and testing are volunteer-led and time-limited, we generally do not apply changes to previously-released versions of the containers (a process known as 'backporting').  In other words: fixes are generally applied only to the most-recent released version of the container image.

This versioning policy could and should evolve over time.

### Build

#### Docker Images

```sh
docker-compose build
```

#### OCI Images

Optional support for building [opencontainer](https://www.opencontainers.org/) images is available via the [Makefile](Makefile) provided.
