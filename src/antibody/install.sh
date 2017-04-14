#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_antibody() {
    if [ "$(get_os)" == "macos" ]; then
        brew install antibody
    else
        . "../ubuntuy/utils.sh"
        install_package "cURL" "curl"
        wget -qO - https://git.io/antibody | bash -s
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Antibody\n\n"

execute "install_antibody" \
    "Install antibody"

execute "antibody bundle < bundles.txt > ~/.zsh-bundles.sh" \
    "Create static cache of bundles"
