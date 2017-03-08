#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

change_default_shell() {

    declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.zshrc"

    local configs=""
    local pathConfig=""

    local newShellPath=""
    local brewPrefix=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `ZSH`
    # version installed through `Homebrew`.

    brewPrefix="$(brew_prefix)" \
        || return 1

    pathConfig="PATH=\"$brewPrefix/bin:\$PATH\""
    zshPath="ZSH=\"$(cd .. && pwd)\""
    configs="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

$pathConfig
$zshPath

export PATH
"

    newShellPath="$brewPrefix/bin/zsh" \

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add the path of the `Bash` version installed through `Homebrew`
    # to the list of login shells from the `/etc/shelqls` file.
    #
    # This needs to be done because applications use this file to
    # determine whether a shell is valid (e.g.: `chsh` consults the
    # `/etc/shells` to determine whether an unprivileged user may
    # change the login shell for her own account).
    #
    # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

    if ! grep "$newShellPath" < /etc/shells &> /dev/null; then
        execute \
            "printf '%s\n' '$newShellPath' | sudo tee -a /etc/shells" \
            "ZSH (add '$newShellPath' in '/etc/shells')" \
        || return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set latest version of `Bash` as the default
    # (macOS uses by default an older version of `Bash`).

    chsh -s "$newShellPath" &> /dev/null
    print_result $? "ZSH (use latest version)"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If needed, add the necessary configs in the
    # local shell configuration file.

    if ! grep "^$pathConfig" < "$LOCAL_SHELL_CONFIG_FILE" &> /dev/null; then
        execute \
            "printf '%s' '$configs' >> $LOCAL_SHELL_CONFIG_FILE \
                && . $LOCAL_SHELL_CONFIG_FILE" \
            "ZSH (update $LOCAL_SHELL_CONFIG_FILE)"
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   ZSH\n\n"

    brew_install "ZSH" "zsh" \
        && change_default_shell

}

main
