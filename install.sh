#!/usr/bin/env bash

install_ansible() {
    ./ansible/install.sh
}

install_nvim() {
    ./nvim/install.sh
}

main() {
   install_ansible 
   install_nvim
}

main "${@}"

