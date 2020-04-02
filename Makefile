.PHONY: build pod grocy nginx

IMAGE_COMMIT := $(shell git rev-parse --short HEAD)
IMAGE_TAG := $(strip $(if $(shell git status --porcelain --untracked-files=no), "${IMAGE_COMMIT}-dirty", "${IMAGE_COMMIT}"))

build: pod grocy nginx
	podman run \
        --detach \
        --env-file grocy.env \
        --name grocy \
        --pod grocy-pod \
        --read-only-tmpfs \
        --volume database:/var/www/data \
        grocy:${IMAGE_TAG}
	podman run \
        --detach \
        --name nginx \
        --pod grocy-pod \
        --read-only-tmpfs \
        --volumes-from grocy:ro \
        nginx:${IMAGE_TAG}

pod:
	podman pod rm -f grocy-pod || true
	podman pod create --name grocy-pod --publish 8080

grocy:
	podman image exists $@:${IMAGE_TAG} || buildah bud --build-arg GITHUB_API_TOKEN=${GITHUB_API_TOKEN} --build-arg GROCY_VERSION=${GROCY_VERSION} -f Dockerfile-grocy -t $@:${IMAGE_TAG} .
	podman tag $@:${IMAGE_TAG} $@:latest

nginx:
	podman image exists $@:${IMAGE_TAG} || buildah bud -f Dockerfile-grocy-nginx -t $@:${IMAGE_TAG} .
	podman tag $@:${IMAGE_TAG} $@:latest
