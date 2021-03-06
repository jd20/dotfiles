#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_repos() {
    install_package "debconf-utils" "debconf-utils"
    add_ppa "webupd8team/java"
    #add_ppa "paolorotolo/android-studio"
    add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub"
    add_to_source_list "[arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" "google-chrome.list"
    add_ppa "jonathonf/python-3.6"
    add_to_source_list "[arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" "bazel.list"
    add_key "https://bazel.build/bazel-release.pub.gpg"
}

install_java() {

    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
    install_package "Oracle Java 8" "oracle-java8-installer"

}

install_packages() {

    install_package "Bazel" "bazel"
    install_package "Build Essential" "build-essential"
    install_package "Chrome" "google-chrome-stable"
    install_package "cURL" "curl"
    install_package "GnuPG archive keys" "debian-archive-keyring"
    install_deb "Hyper" "https://hyper-updates.now.sh/download/linux_deb"
    install_package "libbz2" "libbz2-dev"
    install_package "libindicator / libappindicator" "libindicator7 libappindicator1"
    install_package "libssl" "libssl-dev"
    install_package "libreadline" "libreadline-dev"
    install_package "Linux headers" "linux-headers-$(uname -r)"
    install_package "NodeJS" "nodejs"
    if nvidia_gpu_present; then
        install_package "nVidia Drivers" "nvidia-367"
    fi
    install_package "Python Development Headers" "python2.7-dev python3.6-dev"
    install_package "ShellCheck" "shellcheck"
    install_package "sqlite3" "libsqlite3-dev"
    install_package "tmux" "tmux"
    install_package "Transmission" "transmission"
    install_package "Ubuntu Make" "ubuntu-make"
    install_package "VLC" "vlc"
    install_package "xclip" "xclip"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Installing Packages\n\n"

main() {

    setup_repos
    apt_update
    apt_upgrade
    install_java
    install_packages
    autoremove

}

main
