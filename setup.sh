#!/bin/bash

set -eu

SCRIPT_HOME="$( dirname "${0}" )"
ANSIBLE_VERSION="${ANSIBLE_VERSION:-"2.7.10"}"
export ANSIBLE_NOCOWS=1

check_prerequsites() {
  echo "INFO: Checking prerequisites"

  local prerequisites=(
    python
  )

  local total_status=0

  for prerequisite in "${prerequisites[@]}"; do
    local status="$( which "${prerequisite}" )"

    if [[ "${status}" == "" ]]; then
      echo "ERROR: No such prerequisite: ${prerequisite}"
      let total_status+=1
    fi
  done

  if [[ "${total_status}" != 0 ]]; then
    echo "ERROR: Prerequisites were not met"
    exit 1
  fi
}

check_ansible() {
  ansible_existance=$( which ansible )
  if [[ "${ansible_existance}" == "" ]]; then
    echo "WARNING: Ansible was not installed"
    echo "INFO: Installing Ansible version: ${ANSIBLE_VERSION}"
    pip install -U pip \
    && pip install "ansible==${ANSIBLE_VERSION}"
  fi
}

setup_environment() {
  echo "INFO: Setting up environment"

  ansible_home="${SCRIPT_HOME}/ansible"

  ansible-playbook \
  -i "${ansible_home}/inventory.ini" \
  "${ansible_home}/install.yml"
}

main() {
  check_prerequsites
  check_ansible
  setup_environment
}

main
