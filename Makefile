.PHONY: build pod manifest manifest-create %-backend %-frontend

GROCY_VERSION = v3.0.1
IMAGE_COMMIT := $(shell git rev-parse --short HEAD)
IMAGE_TAG := $(strip $(if $(shell git status --porcelain --untracked-files=no), "${IMAGE_COMMIT}-dirty", "${IMAGE_COMMIT}"))

PLATFORM ?= linux/386 linux/amd64 linux/arm/v6 linux/arm/v7 linux/arm64/v8 linux/ppc64le linux/s390x

build: pod manifest
	podman run \
        --add-host grocy:127.0.0.1 \
        --detach \
        --env-file grocy.env \
        --name backend \
        --pod grocy-pod \
        --read-only \
        --volume /var/log/php7 \
        --volume app-db:/var/www/data \
        backend:${IMAGE_TAG}
	podman run \
        --add-host grocy:127.0.0.1 \
        --detach \
        --name frontend \
        --pod grocy-pod \
        --read-only \
        --tmpfs /tmp \
        --volume /var/log/nginx \
        frontend:${IMAGE_TAG}

pod:
	podman pod rm -f grocy-pod || true
	podman pod create --name grocy-pod --publish 127.0.0.1:8080:8080

manifest: manifest-create $(PLATFORM)

manifest-create:
	buildah rmi -f backend:${IMAGE_TAG} || true
	buildah rmi -f frontend:${IMAGE_TAG} || true
	buildah manifest create backend:${IMAGE_TAG}
	buildah manifest create frontend:${IMAGE_TAG}

$(PLATFORM): %: %-backend %-frontend

%-backend: GROCY_IMAGE = $(shell buildah bud --build-arg GROCY_VERSION=${GROCY_VERSION} --build-arg PLATFORM=$* --file Dockerfile-grocy-backend --platform $* --quiet --tag backend/$*:${IMAGE_TAG})
%-backend:
	buildah manifest add backend:${IMAGE_TAG} ${GROCY_IMAGE}

%-frontend: NGINX_IMAGE = $(shell buildah bud --build-arg GROCY_VERSION=${GROCY_VERSION} --build-arg PLATFORM=$* --file Dockerfile-grocy-frontend --platform $* --quiet --tag frontend/$*:${IMAGE_TAG})
%-frontend:
	buildah manifest add frontend:${IMAGE_TAG} ${NGINX_IMAGE}
