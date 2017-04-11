#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_antibody() {
    if [ "$(get_os)" == "macos" ]; then
        brew_install "Install antibody" "antibody"
    else
        execute "curl -sL https://git.io/antibody | sh -s" \
            "Install antibody"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Antibody\n\n"

install_antibody

execute "antibody bundle < bundles.txt > ~/.zsh-bundles.sh" \
    "Create static cache of bundles"
