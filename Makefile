.PHONY: build grocy-pod grocy-app grocy-nginx

IMAGE_COMMIT := $(shell git rev-parse --short HEAD)
IMAGE_TAG := $(strip $(if $(shell git status --porcelain --untracked-files=no), "${IMAGE_COMMIT}-dirty", "${IMAGE_COMMIT}"))

build: grocy-pod grocy-app grocy-nginx
	podman run --detach --env-file grocy-app.env --name grocy-app --pod grocy --read-only grocy-app:${IMAGE_TAG}
	podman run --detach --name grocy-nginx --pod grocy --read-only --tmpfs /run/nginx --tmpfs /var/lib/nginx/tmp --volumes-from grocy-app:ro grocy-nginx:${IMAGE_TAG}

grocy-pod:
	podman pod rm -f grocy || true
	podman pod create --name grocy --publish 8000:80

grocy-app:
	podman image exists $@:${IMAGE_TAG} || buildah bud --build-arg GITHUB_API_TOKEN=${GITHUB_API_TOKEN} -f Dockerfile-grocy -t $@:${IMAGE_TAG} .
	podman tag $@:${IMAGE_TAG} $@:latest

grocy-nginx:
	podman image exists $@:${IMAGE_TAG} || buildah bud -f Dockerfile-grocy-nginx -t $@:${IMAGE_TAG} .
	podman tag $@:${IMAGE_TAG} $@:latest
