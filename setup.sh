#!/bin/bash

set -e

SCRIPT_HOME="$( dirname "${0}" )"
ANSIBLE_HOME="${SCRIPT_HOME}/ansible"
ANSIBLE_VERSION="${ANSIBLE_VERSION:-"2.7.10"}"

export ANSIBLE_NOCOWS=1

display_help() {
  echo
  echo "Configure developers environment"
  echo "Usage:"
  echo "  -i --inventory        Path to inventory to play with"
  echo "  -h --help             Display help message"
  echo
}

handle_args() {
  INVENTORY="${ANSIBLE_HOME}/inventory.ini"

  while [[ "${#}" -gt 0 ]]; do
    case "${1}" in
      -i|--inventory) INVENTORY="${2}"; shift 2;;
      -h|--help) display_help; exit 1;;
    esac
  done

  if [[ ! -f "${INVENTORY}" ]]; then
    echo "ERROR: Please provide valid inventory!"
    echo "ERROR: Provided inventory: ${INVENTORY}"
    exit 1
  fi
}

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

  ansible-playbook \
  -i "${INVENTORY}" \
  "${ANSIBLE_HOME}/install.yml"
}

main() {
  handle_args "${@}"
  check_prerequsites
  check_ansible
  setup_environment
}

main "${@}"
