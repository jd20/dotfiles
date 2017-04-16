#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# When we create symbolic links, we try to pull in local config
# from the user's ~/Dropbox/dotfiles folder, so we need to set that
# up before doing anything else.

../dropbox/install.sh
../git/install.sh
