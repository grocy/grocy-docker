.PHONY: grocy-app grocy-nginx

IMAGE_COMMIT := $(shell git rev-parse --short HEAD)
IMAGE_TAG := $(strip $(if $(shell git status --porcelain --untracked-files=no), "${IMAGE_COMMIT}-dirty", "${IMAGE_COMMIT}"))

grocy-app:
	buildah bud -f Dockerfile-grocy -t grocy-app:${IMAGE_TAG} --build-arg GITHUB_API_TOKEN=${GITHUB_API_TOKEN} .

grocy-nginx:
	buildah bud -f Dockerfile-grocy-nginx -t grocy-nginx:${IMAGE_TAG} .

pod: grocy-app grocy-nginx
	podman pod rm -f grocy || true
	podman pod create --name grocy --publish 8000:80
	podman run --detach --name grocy-app --pod grocy --read-only grocy-app:${IMAGE_TAG}
	podman run --detach --name grocy-nginx --pod grocy --read-only-tmpfs grocy-nginx:${IMAGE_TAG}
