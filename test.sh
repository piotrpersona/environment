#!/bin/bash
TARGET_IMAGE=philm/ansible_target:latest
TEST_INVENTORY=/tmp/test_inventory.ini
ANSIBLE_HOME=ansible

handle_arguments() {
  local arguments="${@}"
}

build_target() {
  docker pull "${TARGET_IMAGE}"
}

stop_target() {
  docker rm --force "${1}"
}

remove_target() {
  docker rmi --force "${TARGET_IMAGE}"
}

run_target() {
  docker_target_id=$(docker run -d -p 2222:22 -v ~/.ssh/id_rsa.pub:/home/ubuntu/.ssh/authorized_keys "${TARGET_IMAGE}")
  echo "${docker_target_id}"
}

run_example_playbook() {
  echo "Running playbook inside: ${1:0:8} container"
  local docker_container_id="${1}"
  local playbook="${ANSIBLE_HOME}/deploy_environment.yml"
  printf "[environment]\n${docker_container_id} ansible_connection=docker" >> "${TEST_INVENTORY}"
  ansible-playbook \
    -i "${TEST_INVENTORY}" \
    "${playbook}"
}

remove_test_inventory() {
  rm "${TEST_INVENTORY}"
}

display_connection_command() {
  echo "In order to connect to container run:"
  echo "docker exec -it ${1} /bin/bash"
}

display_rm_container_command() {
  echo "In order to stop container run:"
  echo "docker rm -f ${1}"
}

display_tips() {
  echo "************************************************"
  echo "TIPS"
  echo "************************************************"
  local docker_container_id="${1:0:8}"
  display_connection_command "${docker_container_id}"
  display_rm_container_command "${docker_container_id}"
}

main() {
  pushd "$(dirname "${0}")" > /dev/null

  build_target
  local docker_target_id="$(run_target)"

  display_tips "${docker_target_id}"
  run_example_playbook "${docker_target_id}"
  local exit_code="${?}"
  remove_test_inventory
  stop_target "${docker_target_id}"
  display_tips "${docker_target_id}"

  exit "${exit_code}"
  popd > /dev/null 2>&1
}

main "${@}"
