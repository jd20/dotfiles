#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "utils.sh"

require_ubuntu

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./apt.sh
./apps.sh
./zsh.sh
