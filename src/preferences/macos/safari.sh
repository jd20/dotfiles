#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Safari\n\n"

execute "defaults write com.apple.Safari AutoOpenSafeDownloads -bool false" \
    "Disable opening 'safe' files automatically"

execute "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true" \
    "Set backspace key to go to the previous page in history"

execute "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
         defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
         defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true" \
    "Enable the 'Develop' menu and the 'Web Inspector'"

execute "defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false" \
    "Set search type to 'Contains' instead of 'Starts With'"

execute "defaults write com.apple.Safari ShowFavoritesBar -bool true" \
    "Show bookmarks bar by default"

execute "defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true" \
    "Show the full URL in the address bar"

execute "defaults write -g WebKitDeveloperExtras -bool true" \
    "Add a context menu item for showing the 'Web Inspector' in web views"

execute "defaults write com.apple.Safari CanPromptForPushNotifications -bool false" \
    "Disable prompts for website push notifications"

killall "Safari" &> /dev/null
