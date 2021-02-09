.PHONY: build pod manifest manifest-create %-grocy %-nginx

GROCY_VERSION = v3.0.1
IMAGE_COMMIT := $(shell git rev-parse --short HEAD)
IMAGE_TAG := $(strip $(if $(shell git status --porcelain --untracked-files=no), "${IMAGE_COMMIT}-dirty", "${IMAGE_COMMIT}"))

PLATFORM ?= linux/386 linux/amd64 linux/arm/v6 linux/arm/v7 linux/arm64/v8 linux/ppc64le linux/s390x

build: pod manifest
	podman run \
        --add-host grocy:127.0.0.1 \
        --detach \
        --env-file grocy.env \
        --name grocy \
        --pod grocy-pod \
        --read-only \
        --volume /var/log/php7 \
        --volume app-db:/var/www/data \
        grocy:${IMAGE_TAG}
	podman run \
        --add-host grocy:127.0.0.1 \
        --detach \
        --name nginx \
        --pod grocy-pod \
        --read-only \
        --tmpfs /tmp \
        --volume /var/log/nginx \
        nginx:${IMAGE_TAG}

pod:
	podman pod rm -f grocy-pod || true
	podman pod create --name grocy-pod --publish 127.0.0.1:8080:8080

manifest: manifest-create $(PLATFORM)

manifest-create:
	buildah rmi -f grocy:${IMAGE_TAG} || true
	buildah rmi -f nginx:${IMAGE_TAG} || true
	buildah manifest create grocy:${IMAGE_TAG}
	buildah manifest create nginx:${IMAGE_TAG}

$(PLATFORM): %: %-grocy %-nginx

%-grocy: GROCY_IMAGE = $(shell buildah bud --build-arg GROCY_VERSION=${GROCY_VERSION} --build-arg PLATFORM=$* --file Dockerfile-grocy --platform $* --quiet --tag grocy/$*:${IMAGE_TAG})
%-grocy:
	buildah manifest add grocy:${IMAGE_TAG} ${GROCY_IMAGE}

%-nginx: NGINX_IMAGE = $(shell buildah bud --build-arg GROCY_VERSION=${GROCY_VERSION} --build-arg PLATFORM=$* --file Dockerfile-grocy-nginx --platform $* --quiet --tag nginx/$*:${IMAGE_TAG})
%-nginx:
	buildah manifest add nginx:${IMAGE_TAG} ${NGINX_IMAGE}
