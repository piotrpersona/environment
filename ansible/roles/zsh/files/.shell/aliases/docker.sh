function docker_remove_images() {
  docker rmi --force $( docker images -q -a )
}
