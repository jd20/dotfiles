#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    #install_package "debconf-utils" "debconf-utils"
    #add_ppa "webupd8team/java"
    #add_ppa "paolorotolo/android-studio"

    add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub"
    add_to_source_list "[arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" "google-chrome.list"
    apt_update

    install_package "libindicator / libappindicator" "libindicator7 libappindicator1"
    #install_package "Ubuntu Make" "ubuntu-make"
    #execute "umake android --accept-license" "Android Studio"
    install_package "Build Essential" "build-essential"
    install_package "GnuPG archive keys" "debian-archive-keyring"
    install_package "Chrome" "google-chrome-stable"
    install_package "cURL" "curl"
    #execute "umake go \"$HOME/.local/share/umake/go/go-lang\"" "Go"
    install_package "NodeJS" "nodejs"
    install_package "nVidia Drivers" "nvidia-367"
    install_deb "Hyper", "https://hyper-updates.now.sh/download/linux_deb"
    #echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
    #install_package "Oracle Java 8", "oracle-java8-installer"
    install_package "ShellCheck" "shellcheck"
    install_package "tmux" "tmux"
    install_package "Transmission" "transmission"
    install_package "VLC" "vlc"
    install_package "xclip" "xclip"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Installing Apps\n\n"

main() {

    install_apps
    autoremove

}

main
