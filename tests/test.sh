#!/usr/bin/env bash

set -eu

PROJECT_ROOT="$( git rev-parse --show-toplevel )"
SCRIPT_PATH="${PROJECT_ROOT}/tests"
DISTROS=( $( ls "${SCRIPT_PATH}/docker" ) )

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

    # local temp_out_file="/tmp/${container_name}.log"
    # docker exec -it "${container_name}" sh -c '/project/setup.sh' \
    # 2>&1 "${temp_out_file}" | tee "${temp_out_file}"

    # local changed="$( tail -10 "${temp_out_file}" | \
    #     grep -Po '(?<=changed=)[0-9]+' )"

    # echo "***************************** "
    # [[ "${changed}" -ne "0" ]] \
    #     && echo "NOT IDEMPOTENT" \
    #     || echo "IDEMPOTENT"
    # echo "***************************** "

    docker rm -f "${container_name}"
}

main() {
    for distro in "${DISTROS[@]}"; do
        distro_image="${distro}-environment"
        build_distro_image "${distro}" "${distro_image}"
        run_tests "${distro_image}"
    done
}

main
