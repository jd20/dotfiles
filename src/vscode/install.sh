#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_modules() {
    if test "$(which code)"; then
        #if [ "$(uname -s)" = "Darwin" ]; then
        #    VSCODE_HOME="$HOME/Library/Application Support/Code"
        #else
        #    VSCODE_HOME="$HOME/.config/Code"
        #fi

        #ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
        #ln -sf "$DOTFILES/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"

        # from `code --list-extensions`
        modules="
            Borke.puppet
            DotJoshJohnson.xml
            EditorConfig.EditorConfig
            Kasik96.swift
            PeterJausovec.vscode-docker
            WakaTime.vscode-wakatime
            be5invis.toml
            donjayamanne.python
            haaaad.ansible
            ipedrazas.kubernetes-snippets
            lukehoban.Go
            mattn.Runner
            mauve.terraform
            ms-vscode.cpptools
            rebornix.Ruby
        "
        
        for module in $modules; do
            code --install-extension "$module" &> /dev/null
        done
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   VS Code\n\n"

execute "install_modules" \
    "Installing modules"
