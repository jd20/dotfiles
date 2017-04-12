#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_localrc() {

    # Create a .localrc if it doesn't exist, and set the ZSH variable
    # to point to the dotfiles repo (so we can source *.zsh files
    # properly.

    declare -r filePath="$HOME/.localrc"
    declare -r dotfiles="DOTFILES=\"$(cd ../../.. && pwd)\""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If needed, add the necessary configs in the
    # local shell configuration file.

    configs="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# shortcut to this dotfiles path is \$DOTFILES
export $dotfiles
"

    if [ ! -e "$filePath" ]; then

        printf "" '$configs' >> "$filePath"
        execute \
            "printf '# Place your local configuration here\n%s' \
            '$configs' >> $filePath" \
            "$filePath"

    elif ! grep "$dotfiles" < "$filePath" &> /dev/null; then

        execute \
            "printf '%s' '$configs' >> $filePath" \
            "$filePath"

    fi

}

create_gitconfig_local() {

    declare -r filePath="$HOME/.gitconfig.local"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ ! -e "$filePath" ]; then

        printf "%s\n" \
"[commit]

    # Sign commits using GPG.
    # https://help.github.com/articles/signing-commits-using-gpg/

    # gpgsign = true


[user]

    name =
    email =
    # signingkey =" \
        >> "$filePath"
    fi

    print_result $? "$filePath"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Create local config files\n\n"
    create_localrc
    create_gitconfig_local

}

main "$@"
