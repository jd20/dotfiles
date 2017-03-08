#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

require_macos

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./xcode.sh
./homebrew.sh
./zsh.sh
./misc.sh
