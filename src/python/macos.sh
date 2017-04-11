#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../macos/utils.sh"

brew_install "pyenv", "pyenv"
brew_install "pyenv-virtualenv", "pyenv-virtualenv"
