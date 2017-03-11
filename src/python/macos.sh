#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../macos/utils.sh"

brew_install "Python 2.x" "python"
brew_install "Python 3.x" "python3"
execute "sudo easy_install pip" "pip"
execute "sudo pip install --upgrade virtualenv" "virtualenv"
