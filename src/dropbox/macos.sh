#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../macos/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_dropbox() {

    brew_install "Dropbox" "dropbox" "caskroom/cask" "cask"

}

configure_dropbox() {

    # If necessary, prompt the user to configure Dropbox

    if ! is_dropbox_configured; then
        open "/Applications/Dropbox.app"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the Dropbox folder is present

    execute \
        "until is_dropbox_configured; do \
            sleep 2; \
         done" \
        "Configure Dropbox.app"

}

is_dropbox_configured() {

    [ -n "$(get_dropbox_folder)" ]

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    install_dropbox
    configure_dropbox

}

main
