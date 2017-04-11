#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_rbenv() {
    if [ "$(get_os)" == "macos" ]; then
        . "../macos/utils.sh"
        brew_install "rbenv" "rbenv"
    else
        . "../ubuntu/utils.sh"
        install_package "rbenv" "rbenv"
        install_package "libssl" "libssl-dev"
        install_package "libreadline" "libreadline-dev"
        install_package "zlib" "zlib1g-dev"
    fi
    eval "$(rbenv init -)"
    execute "git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build" \
        "ruby-build"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Ruby\n\n"

install_rbenv
execute "rbenv install 2.4.0 && rbenv global 2.4.0" "Ruby 2.4.0"
execute "gem install rails" "Rails"
