#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

link_file() {

    # Note: Be sure to set the *_all flags in the parent, like this:
    #
    # local overwrite_all=false backup_all=false skip_all=false

    local sourceFile=$1 targetFile=$2

    local overwrite= backup= skip=
    local action=

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ ! -e "$targetFile" -a ! -L "$targetfile" ] || \
        [ "$(readlink $targetFile)" == "$sourceFile" ]; then

        # Either the target doesn't exist, or is already the way we
        # want, so just proceed normally.

        overwrite=true

    elif ! $overwrite_all && ! $backup_all && ! $skip_all; then

        # A conflict exists; if behavior is not yet set, ask the user what
        # we should do in this case (or for all conflicts).

        print_question "File already exists: $targetFile\n \
      [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all? "
        read -n 1 action
        printf "\n"

        case "$action" in
            o )
                overwrite=true;;
            O )
                overwrite_all=true;;
            b )
                backup=true;;
            B )
                backup_all=true;;
            s )
                skip=true;;
            S )
                skip_all=true;;
            * )
                ;;
        esac

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Determine course of action

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    # If ln -fs would fail because the target isn't a symlink, be
    # safe and do a backup instead.

    if $overwrite && [ -e "$targetFile" ] && [ ! -L "$targetFile" ]; then

        print_warning "$targetFile: Cannot overwrite a non-symlink, backing up instead"
        overwrite=false
        backup=true

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Create the symlink according to the plan we've chosen

    if $overwrite; then

        execute \
            "ln -fs \"$sourceFile\" \"$targetFile\"" \
            "$targetFile → $sourceFile"

    elif $backup; then

        # Choose a unique backup name

        backupFile="${targetFile}.backup"
        if [ -e "$backupFile" -o -L "$backupFile" ]; then
            i=2
            while [ -e "$backupFile-$i" -o -L "$backupFile-$i" ]; do
                let i++
            done
            backupFile="$backupFile-$i"
        fi

        # Do the backup and link in a single call

        execute \
            "mv \"$targetFile\" \"$backupFile\" && ln -fs \"$sourceFile\" \"$targetFile\"" \
            "$targetFile → $sourceFile (moved original to: $backupFile)"

    elif $skip; then

        print_warning "skipping: $targetFile → $sourceFile"

    fi

}

find_dotfiles() {

    local -r dotfilesDirectory=$1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Execute two find commands, this one will find files:

    findFiles="find $dotfilesDirectory -name \"*~\" -prune -o $(find_ignore_dirs)"
    findFiles="$findFiles -type f $(find_ignore_files) -maxdepth 2 -print"
    eval "$findFiles"

    # And this one will find directories (ending with ~):

    findDirs="find $dotfilesDirectory -path \"./*~/*\" -prune -o $(find_ignore_dirs)"
    findDirs="$findDirs -type d -name \"*~\" -maxdepth 2 -print"
    eval "$findDirs"

}

install_dotfiles() {

    local overwrite_all=false backup_all=false skip_all=false
    local -r dotfilesDirectory=$1
    shift

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && overwrite_all=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Capture the list of dotfiles into an array

    IFS=$'\n' found=($(find_dotfiles "$dotfilesDirectory"))

    # Iterate through each file that was found

    for i in "${found[@]}"; do

        # Strip the trailing ~ for directories, and link the file
        [ -d "$i" ] && suffix="~" || suffix=""
        link_file "$i" "$HOME/.$(basename "$i" "$suffix")"

    done

}

install_dropbox_dotfiles() {

    local -r dropbox="$(get_dropbox_folder)"
    local -r dropboxDotfiles="$dropbox/dotfiles"

    # Ensure the dropbox folder exists

    if [ ! -d "$dropbox" ]; then
        print_warning "Dropbox was not detected on this system, skipping"
        return
    fi

    # Install dotfiles if a dotfiles folder exists

    if [ -d "$dropboxDotfiles" ]; then
        install_dotfiles "$dropboxDotfiles" "$@"
    else
        print_warning "Dropbox folder did not contain any dotfiles, skipping"
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Link local config files from Dropbox\n\n"
    install_dropbox_dotfiles

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_purple "\n • Link dotfiles from repo\n\n"
    install_dotfiles "$(cd ../../../src && pwd)" "$@"

}

main "$@"
