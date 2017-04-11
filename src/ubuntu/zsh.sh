#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   ZSH\n\n"

install_package "ZSH" "zsh"
chsh -s "$(which zsh)" &> /dev/null
print_result $? "ZSH (use latest version)"
