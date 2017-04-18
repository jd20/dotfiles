#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_pyenv() {
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
    export PATH="$HOME/.pyenv/bin:$PATH"
}

venv() {
    pyenv virtualenv 3.6.1 "$1" &> /dev/null || pyenv activate -q "$1"
}

install_python() {
    declare -r PYTHON_PATH="$HOME/.pyenv/versions/3.6.1"
    if [ -e $PYTHON_PATH ]; then
        print_success "Python 3.6.1"
    else
        execute "pyenv install 3.6.1" "Python 3.6.1"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Python\n\n"

    # Install and load pyenv
    execute "install_pyenv" "pyenv"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    # Update to Python 3.6
    install_python

}

main
