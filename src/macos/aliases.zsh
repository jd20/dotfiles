
#Simulator shortcuts.

alias ios="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias watchos="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator\ \(Watch\).app"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Lock screen.

alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Clear DNS cache.

alias clear-dns-cache="sudo dscacheutil -flushcache; \
                       sudo killall -HUP mDNSResponder"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Get local IP.

alias local-ip="ipconfig getifaddr en0 && ipconfig getifaddr en1"
