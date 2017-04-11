#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

populate_dropbox_folder() {

    local -r dropboxFolder="$(get_dropbox_folder)"
    local -r dropboxDotfiles="$dropboxFolder/dotfiles"
    local -r lsCmd="ls -A \"$dropboxDotfiles\""

    # Wait up to 2 minutes for the dropbox dotfiles folder to
    # appear (this is because it may take a little while to sync)

    for (( i=1; i<=40; i++ )); do

        [ -d $dropboxDotfiles ] && \
            [ -n "$(eval $lsCmd)" ] && \
            break
        sleep 3

    done

    # Wait another 30 seconds, for the contents of the dotfiles
    # folder to populate

    sleep 60

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Dropbox\n\n"

main() {

    # If Dropbox is already installed, do nothing
    if [ -n "$(get_dropbox_folder)" ]; then
        print_success "Dropbox"
        return
    fi

    # Now install Dropbox
    "./$(get_os).sh"

    # Wait until we can reasonably believe the Dropbox folder
    # has had time to sync
    execute "Waiting for Dropbox to sync" \
        "populate_dropbox_folder"

}

main
