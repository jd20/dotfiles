#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../ubuntu/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_dropbox_source() {

    add_to_source_list "[arch=amd64] http://linux.dropbox.com/ubuntu stable main" "dropbox.list"
    sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E

}

install_dropbox() {

    # Download and install Dropbox

    sudo apt install -y dropbox python-gpgme
    dropbox start -i

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

func main() {

    if ! is_dropbox_configured; then

        execute "add_dropbox_source" "Add Dropbox to source list"
        apt_update
        apt_upgrade
        execute "install_dropbox" "Install Dropbox"

    fi

}

main
