#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   System\n\n"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText \
    \"Found this computer? Please contact $(git config user.name) at $(git config user.email)." \
    "Add a message to the login screen"

execute "sudo systemsetup -setrestartfreeze on" \
    "Restart automatically if the computer freezes"

execute "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true" \
    "Prevent Time Machine from prompting to use new hard drives as backup volume"

execute "hash tmutil &> /dev/null && sudo tmutil disablelocal" \
    "Disable local Time Machine backups"
