#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

require_macos

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./homebrew.sh
./xcode.sh
./misc.sh
./zsh.sh
