IMAGE_COMMIT := $(shell git rev-parse --short HEAD)

.grocy:
	buildah bud -f Dockerfile-grocy -t grocy:${IMAGE_COMMIT} --build-arg GITHUB_API_TOKEN=${GITHUB_API_TOKEN} .

.grocy_nginx:
	buildah bud -f Dockerfile-grocy-nginx -t grocy-nginx:${IMAGE_COMMIT} .

pod: .grocy .grocy_nginx
	podman pod rm -f grocy-pod || true
	podman pod create --name grocy-pod
	podman run --read-only --pod grocy-pod -dt --name grocy grocy:${IMAGE_COMMIT}
	podman run ---read-only -read-only --pod grocy-pod -dt --name grocy-nginx grocy-nginx:${IMAGE_COMMIT}
