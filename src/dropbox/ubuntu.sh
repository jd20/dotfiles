#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../ubuntu/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_dropbox() {

    # Download and install Dropbox

    if ! is_dropbox_configured; then

        add_to_source_list "[arch=amd64] http://linux.dropbox.com/ubuntu stable main" "dropbox.list"
        sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
        sudo apt update -y
        sudo apt install -y dropbox python-gpgme
        dropbox start -i

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
