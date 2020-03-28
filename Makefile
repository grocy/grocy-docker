IMAGE_COMMIT := $(shell git rev-parse --short HEAD)

.grocy:
	buildah bud -f Dockerfile-grocy -t grocy-app:${IMAGE_COMMIT} --build-arg GITHUB_API_TOKEN=${GITHUB_API_TOKEN} .

.grocy_nginx:
	buildah bud -f Dockerfile-grocy-nginx -t grocy-nginx:${IMAGE_COMMIT} .

pod: .grocy .grocy_nginx
	podman pod rm -f grocy || true
	podman pod create --name grocy --publish 8000:80
	podman run -dt --name grocy-app --pod grocy --read-only grocy-app:${IMAGE_COMMIT}
	podman run -dt --name grocy-nginx --pod grocy --read-only-tmpfs grocy-nginx:${IMAGE_COMMIT}
