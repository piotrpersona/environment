#!/bin/bash
deploy_environment() {
  ansible-playbook \
  -i ansible/invetory \
  ansible/setup_environment.yml
}

main() {
  pushd "$(dirname "${0}")" > /dev/null

  deploy_environment
  local exit_code="${?}"

  popd > /dev/null 2>&1
  exit "${exit_code}"
}

main "${@}"
