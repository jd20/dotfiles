#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../ubuntu/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_dropbox() {

    # Download and install Dropbox

    if ! is_dropbox_configured; then

        echo "Add to source list..."
        add_to_source_list "[arch=i386,amd64] http://linux.dropbox.com/ubuntu xenial main" "dropbox.list"
        echo "Add key..."
        sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
        echo "apt update"
        sudo apt update -y
        echo "install dropbox and python-gpgme"
        sudo apt install -y dropbox python-gpgme
        echo "start dropbox finally"
        dropbox start

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

install_dropbox
#execute "install_dropbox" "Install Dropbox"
