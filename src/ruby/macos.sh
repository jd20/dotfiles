#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

execute 'brew install rbenv && eval "$(rbenv init -)"' "rbenv"
