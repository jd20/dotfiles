#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../$(get_os)/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_rbenv() {

    # Install rbenv
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

    # Install ruby-build
    declare -r RUBY_BUILD_PATH="$HOME/.rbenv/plugins/ruby-build"
    if [ -e $RUBY_BUILD_PATH ]; then
        print_success "ruby-build"
    else
        execute "git clone https://github.com/rbenv/ruby-build.git $RUBY_BUILD_PATH" \
            "ruby-build"
    fi

}

install_ruby() {
    declare -r RUBY_PATH="$HOME/.rbenv/versions/2.4.0"
    if [ -e $RUBY_PATH ]; then
        print_success "Ruby 2.4.0"
    else
        execute "rbenv install 2.4.0 && rbenv global 2.4.0" "Ruby 2.4.0"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Ruby\n\n"

    install_rbenv
    install_ruby
    execute "gem install rails" "Rails"

}

main
