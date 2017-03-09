#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Terminal\n\n"

execute "defaults write com.apple.Terminal ShowLineMarks -int 0" \
    "Hide line marks"

execute "defaults write com.apple.terminal StringEncodings -array 4" \
    "Only use UTF-8"

execute "./set_terminal_theme.applescript" \
    "Set custom terminal theme"
