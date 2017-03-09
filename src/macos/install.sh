#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "./utils.sh"

require_macos

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./homebrew.sh
./xcode.sh
./apps.sh
./zsh.sh
