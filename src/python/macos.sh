#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"
    && . "../macos/utils.sh"

brew_install "python" "Python 2.x"
brew_install "python3" "Python 3.x"
execute "sudo easy_install pip" "pip"
execute "sudo pip install --upgrade virtualenv" "virtualenv"
