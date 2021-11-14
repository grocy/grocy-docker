.PHONY: build run pod manifest manifest-create %-backend %-frontend

GROCY_VERSION = v3.1.3
COMPOSER_VERSION = 2.1.5
COMPOSER_CHECKSUM = be95557cc36eeb82da0f4340a469bad56b57f742d2891892dcb2f8b0179790ec
IMAGE_TAG ?= $(shell git describe --tags --match 'v*' --dirty)

IMAGE_PREFIX ?= docker.io/grocy
PLATFORM ?= linux/386 linux/amd64 linux/arm/v6 linux/arm/v7 linux/arm64/v8 linux/ppc64le linux/s390x

build: manifest

create: pod
	podman create \
        --env-file grocy.env \
        --name backend \
        --pod grocy-pod \
        --read-only \
        --volume /var/log/php8 \
        --volume app-db:/var/www/data \
        ${IMAGE_PREFIX}/backend:${IMAGE_TAG}
	podman create \
        --add-host backend:127.0.0.1 \
        --name frontend \
        --pod grocy-pod \
        --read-only \
        --tmpfs /tmp \
        --volume /var/log/nginx \
        ${IMAGE_PREFIX}/frontend:${IMAGE_TAG}

run: create
	podman pod start grocy-pod

pod:
	podman pod rm -f grocy-pod || true
	podman pod create --name grocy-pod --publish 127.0.0.1:8080:8080

manifest: manifest-create $(PLATFORM)

manifest-create:
	buildah rmi -f ${IMAGE_PREFIX}/backend:${IMAGE_TAG} || true
	buildah rmi -f ${IMAGE_PREFIX}/frontend:${IMAGE_TAG} || true
	buildah manifest create ${IMAGE_PREFIX}/backend:${IMAGE_TAG}
	buildah manifest create ${IMAGE_PREFIX}/frontend:${IMAGE_TAG}

$(PLATFORM): %: %-backend %-frontend

%-backend: GROCY_IMAGE = $(shell buildah bud --build-arg GROCY_VERSION=${GROCY_VERSION} --build-arg COMPOSER_VERSION=${COMPOSER_VERSION} --build-arg COMPOSER_CHECKSUM=${COMPOSER_CHECKSUM} --build-arg PLATFORM=$* --file Dockerfile-grocy-backend --platform $* --quiet --tag ${IMAGE_PREFIX}/backend/$*:${IMAGE_TAG})
%-backend:
	buildah manifest add ${IMAGE_PREFIX}/backend:${IMAGE_TAG} ${GROCY_IMAGE}

%-frontend: NGINX_IMAGE = $(shell buildah bud --build-arg GROCY_VERSION=${GROCY_VERSION} --build-arg COMPOSER_VERSION=${COMPOSER_VERSION} --build-arg COMPOSER_CHECKSUM=${COMPOSER_CHECKSUM} --build-arg PLATFORM=$* --file Dockerfile-grocy-frontend --platform $* --quiet --tag ${IMAGE_PREFIX}/frontend/$*:${IMAGE_TAG})
%-frontend:
	buildah manifest add ${IMAGE_PREFIX}/frontend:${IMAGE_TAG} ${NGINX_IMAGE}
