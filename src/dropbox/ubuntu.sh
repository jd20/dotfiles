#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../ubuntu/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_dropbox() {

    # Download and install Dropbox

    if ! is_dropbox_configured; then

        declare -r DROPBOX_URL="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb"
        wget $DROPBOX_URL -qO /tmp/pkg.deb && xdg-open /tmp/pkg.deb

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the Dropbox folder is present

    until is_dropbox_configured; do
        sleep 2
    done

}

is_dropbox_configured() {

    [ -n "$(get_dropbox_folder)" ]

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute "install_dropbox" "Install Dropbox"
