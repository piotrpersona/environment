pushd "$(dirname "${0}")" > /dev/null

USERNAME=user
DOCKER_IMAGE_TAG=latest
DOCKER_IMAGE_NAME=env_setup
DOCKER_CONTAINER_NAME="${DOCKER_IMAGE_NAME}_image"

docker build -t "${DOCKER_IMAGE_NAME}" . \
&& docker run --rm \
    -e USERNAME="${USERNAME}" \
    --name "${DOCKER_CONTAINER_NAME}" \
    -it "${DOCKER_IMAGE_NAME}" tmux \
&& docker rmi --force "${DOCKER_IMAGE_NAME}"

popd > /dev/null 2>&1
