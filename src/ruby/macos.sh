#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

execute 'brew install rbenv && eval "$(rbenv init -)"' "rbenv"
execute "rbenv install 2.4.0 && rbenv global 2.4.0" "Ruby 2.4.0"
