#!/usr/bin/env bash

set -eu

PROJECT_ROOT="$( git rev-parse --show-toplevel )"
SCRIPT_PATH="${PROJECT_ROOT}/tests"
DISTROS=( $( ls "${SCRIPT_PATH}/docker" ) )

handle_args() {
    IDEMPOTENCY=0

    while [[ "${#}" -gt 0 ]]; do
        case "${1}" in
            -i|--idempotency) IDEMPOTENCY=1; shift 1;;
        esac
    done
}

build_distro_image() {
    local distro="${1}"
    local distro_image="${2}"

    local distro_docker="${SCRIPT_PATH}/docker/${distro}"

    docker build \
        -t "${distro_image}" \
        -f "${distro_docker}/Dockerfile" \
        "${distro_docker}"

    echo "${distro_image}"
}

run_tests() {
    local image="${1}"

    container_name="$(
        docker run -d -t -v "${PROJECT_ROOT}:/project:ro" "${image}"
    )"

    docker exec -it "${container_name}" sh -c '/project/setup.sh'

    if [[ "${IDEMPOTENCY}" -eq 1 ]]; then
        # local temp_out_file="/tmp/${container_name}.log"
        # docker exec -it "${container_name}" sh -c '/project/setup.sh' \
        #     > 2>&1 | tee "${temp_out_file}"

        # changed="( tail -10 "${temp_out}" \
        #     | gsed -n 's/.*changed\=\([0-9]\+\).*/\1/p'
        # echo "$changed"
    fi
}

main() {
    handle_args "${@}"

    for distro in "${DISTROS[@]}"; do
        distro_image="${distro}-environment"
        build_distro_image "${distro}" "${distro_image}"
        run_tests "${distro_image}"
    done
}

main "${@}"
