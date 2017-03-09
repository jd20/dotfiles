#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Mail\n\n"

execute "defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false" \
    "Copy email addresses as bare e-mail without name"

execute "defaults write com.apple.mail SpellCheckingBehavior -string \"NoSpellCheckingEnabled\"" \
    "Disable automatic spell checking"

killall "Mail" &> /dev/null
