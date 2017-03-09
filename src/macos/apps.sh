#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_packages() {

    brew_install "AWS Command Line Interface" "awscli"
    brew_install "FFmpeg" "ffmpeg"
    brew_install "Git" "git"
    brew_install "Go" "go"
    #brew_install "GPG Agent" "gpg-agent"
    #brew_install "GPG" "gpg"
    brew_install "GStreamer" "gstreamer"
    brew_install "Heroku" "heroku"
    brew_install "htop" "htop"
    brew_install "Node" "node"
    #brew_install "Pinentry" "pinentry-mac"
    execute "npm install -g react-native-cli" "React Native"
    brew_install "ShellCheck" "shellcheck"
    brew_install "SQLite" "sqlite"
    brew_install "Vim" "vim --with-override-system-vi"
    brew_install "Watchman" "watchman"
    brew_install "Waltr" "waltr"
    brew_install "wget" "wget"
    brew_install "XLD" "xld"
    brew_install "Yarn" "yarn"

}

install_apps() {

    cask_install "0xED" "0xed"
    mas_install "1Password" "443987910"
    cask_install "Adobe Creative Cloud" "adobe-creative-cloud"
    cask_install "Atom" "atom"
    cask_install "Audio Hijack" "audio-hijack"
    mas_install "Blackmagic Disk Speed Test" "425264550"
    cask_install "Charles" "charles"
    cask_install "Chrome" "google-chrome"
    cask_install "CUDA" "cuda"
    cask_install "Dash" "dash"
    cask_install "Disk Inventory X" "disk-inventory-x"
    cask_install "Evernote" "evernote"
    cask_install "Handbrake" "handbrake"
    mas_install "iFlicks 2" "731062389"
    cask_install "JollysFastVNC" "jollysfastvnc"
    cask_install "Keka" "keka"
    cask_install "Logitech MyHarmony" "logitech-myharmony"
    cask_install "Mactracker" "mactracker"
    cask_install "Microsoft Office" "microsoft-office"
    mas_install "Reeder" "880001334"
    cask_install "Rocket" "rocket"
    cask_install "Sequel Pro" "sequel-pro"
    cask_install "Silverlight" "silverlight"
    mas_install "SiteSucker" "442168834"
    cask_install "Slack" "slack"
    cask_install "Steam" "steam"
    cask_install "Subler" "subler"
    cask_install "Subtitles" "subtitles"
    cask_install "Transmission" "transmission"
    cask_install "Vagrant" "vagrant"
    cask_install "VirtualBox" "virtualbox"
    cask_install "Visual Studio Code" "visual-studio-code"
    cask_install "VLC" "vlc"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Installing Packages\n\n"
    install_packages

    print_in_purple "\n   Installing Apps\n\n"
    install_apps

    printf "\n"
    brew_cleanup

}

main
