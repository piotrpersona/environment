#!/bin/bash

ANSIBLE_HOME=../ansible

deploy_environment() {
  ansible-playbook \
  -i "${ANSIBLE_HOME}/inventory.ini" \
  "${ANSIBLE_HOME}/deploy_environment.yml"
}

main() {
  pushd "$(dirname "${0}")" > /dev/null

  deploy_environment
  local exit_code="${?}"

  popd > /dev/null 2>&1
  exit "${exit_code}"
}

main "${@}"
