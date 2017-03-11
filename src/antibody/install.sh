#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_antibody() {
    if which brew >/dev/null 2>&1; then
        brew install getantibody/tap/antibody || brew upgrade antibody
    else
        curl -sL https://git.io/antibody | sh -s
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Antibody\n\n"

execute "install_antibody" \
    "Install antibody"

execute "antibody bundle < bundles.txt > ~/.zsh-bundles.sh" \
    "Create static cache of bundles"
