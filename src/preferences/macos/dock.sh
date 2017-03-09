#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../../script/helper/utils.sh"

arrange_dock() {

    dockutil --remove 'Siri' --no-restart
    dockutil --remove 'Launchpad' --no-restart
    dockutil --remove 'Contacts' --no-restart
    dockutil --remove 'Maps' --no-restart
    dockutil --remove 'FaceTime' --no-restart
    dockutil --remove 'Pages' --no-restart
    dockutil --remove 'Numbers' --no-restart
    dockutil --remove 'Keynote' --no-restart
    dockutil --remove 'iBooks' --no-restart
    dockutil --remove 'App Store' --no-restart
    
    dockutil --add '/Applications/Atom.app' --before 'System Preferences' --no-restart
    dockutil --add '/Applications/Xcode.app' --before 'System Preferences' --no-restart
    dockutil --add '/Applications/Dash.app' --before 'System Preferences' --no-restart
    dockutil --add '/Applications/Utilities/Terminal.app' --before 'System Preferences' --no-restart

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Dock\n\n"

brew_install "dckutil" "dockutil"

execute arrange_dock \
    "Arrange dock icons"

execute "defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true" \
    "Enable spring loading for all Dock items"

execute "defaults write com.apple.dock expose-group-by-app -bool false" \
    "Do not group windows by application in Mission Control"

execute "defaults write com.apple.dock mineffect -string 'scale'" \
    "Change minimize/maximize window effect"

execute "defaults write com.apple.dock minimize-to-application -bool true" \
    "Reduce clutter by minimizing windows into their application icons"

execute "defaults write com.apple.dock mru-spaces -bool false" \
    "Do not automatically rearrange spaces based on most recent use"

execute "defaults write com.apple.dock showhidden -bool true" \
    "Make icons of hidden applications translucent"

killall "Dock" &> /dev/null

