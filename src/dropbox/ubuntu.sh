#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../ubuntu/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_dropbox() {

    # Download and install Dropbox

    if ! is_dropbox_configured; then
        install_deb "Dropbox", "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the Dropbox folder is present

    execute \
        "until is_dropbox_configured; do \
            sleep 2; \
         done" \
        "Install Dropbox"

}

is_dropbox_configured() {

    [ -n "$(get_dropbox_folder)" ]

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_dropbox
