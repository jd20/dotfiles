#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   System\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

func create_lost_message() {

    # Make sure we have the user's name and e-mail for the lost message

    local userName=$(git config user.name)
    local userEmail=$(git config user.email)
    while [ -z userName ]; do
        ask "Please provide your name for the lost message: "
        userName="$(get_answer)"
    done
    while [ -z userEmail ]; do
        ask "Please provide an e-mail for the lost message: "
        userEmail="$(get_answer)"
    done

    # Set the login window text

    message="Found this computer? Please contact $(userName) at $(userEmail)."
    execute "sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText \"$(message)\"" \
        "Add a message to the login screen"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_lost_message

execute "sudo systemsetup -setrestartfreeze on" \
    "Restart automatically if the computer freezes"

execute "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true" \
    "Prevent Time Machine from prompting to use new hard drives as backup volume"

execute "hash tmutil &> /dev/null && sudo tmutil disablelocal" \
    "Disable local Time Machine backups"
