#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't ask ssh password all the time

setup_credentials() {
    if [ "$(get_os)" == "macos" ]; then
        git config --global credential.helper osxkeychain
    else
        git config --global credential.helper cache
    fi
}

# better diffs

setup_diff_tool() {
    if which diff-so-fancy > /dev/null 2>&1; then
        git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Git\n\n"

main() {

    # If Ubuntu, git needs to be installed first
    if [ "$(get_os)" == "ubuntu" ]; then
        . "../ubuntu/utils.sh"
        install_package "Git" "git"
    fi

    execute "setup_credentials" \
        "Setup credential helper"

    execute "setup_diff_tool" \
        "Setup diff tool"

}

main
