# Don't run if OS is not supported
if [ get_os != 'macos' ]
then
  warn "macOS installer detected unsupported OS: $(get_os)"
  exit 0
fi

# Start by installing software updates
echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a

# Display custom lost message at login screen
if [ -n "$STRAP_GIT_NAME" ] && [ -n "$STRAP_GIT_EMAIL" ]; then
  sudo defaults write /Library/Preferences/com.apple.loginwindow \
    LoginwindowText \
    "Found this computer? Please contact $STRAP_GIT_NAME at $STRAP_GIT_EMAIL."
fi

#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi

fi

# Upgrade homebrew
echo "› brew update"
brew update

# Run Homebrew through the Brewfile
echo "› brew bundle"
brew bundle


# Setup Homebrew directory and permissions.
logn "Installing Homebrew:"
HOMEBREW_PREFIX="$(brew --prefix 2>/dev/null || true)"
[ -n "$HOMEBREW_PREFIX" ] || HOMEBREW_PREFIX="/usr/local"
[ -d "$HOMEBREW_PREFIX" ] || sudo mkdir -p "$HOMEBREW_PREFIX"
sudo chown "root:wheel" "$HOMEBREW_PREFIX"
(
  cd "$HOMEBREW_PREFIX"
  sudo mkdir -p               Cellar Frameworks bin etc include lib opt sbin share var
  sudo chown -R "$USER:admin" Cellar Frameworks bin etc include lib opt sbin share var
)

HOMEBREW_REPOSITORY="$(brew --repository 2>/dev/null || true)"
[ -n "$HOMEBREW_REPOSITORY" ] || HOMEBREW_REPOSITORY="/usr/local/Homebrew"
[ -d "$HOMEBREW_REPOSITORY" ] || sudo mkdir -p "$HOMEBREW_REPOSITORY"
sudo chown -R "$USER:admin" "$HOMEBREW_REPOSITORY"

if [ $HOMEBREW_PREFIX != $HOMEBREW_REPOSITORY ]
then
  ln -sf "$HOMEBREW_REPOSITORY/bin/brew" "$HOMEBREW_PREFIX/bin/brew"
fi

# Download Homebrew.
export GIT_DIR="$HOMEBREW_REPOSITORY/.git" GIT_WORK_TREE="$HOMEBREW_REPOSITORY"
[ -d "$GIT_DIR" ] && HOMEBREW_EXISTING="1"
git init $Q
git config remote.origin.url "https://github.com/Homebrew/brew"
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
if [ -n "$HOMEBREW_EXISTING" ]
then
  git fetch $Q
else
  git fetch $Q --no-tags --depth=1 --force --update-shallow
fi
git reset $Q --hard origin/master
unset GIT_DIR GIT_WORK_TREE HOMEBREW_EXISTING
logk

# Update Homebrew.
export PATH="$HOMEBREW_PREFIX/bin:$PATH"
log "Updating Homebrew:"
brew update
logk

# Install Homebrew Bundle, Cask, Services and Versions tap.
log "Installing Homebrew taps and extensions:"
brew bundle --file=- <<EOF
tap 'caskroom/cask'
tap 'homebrew/core'
tap 'homebrew/services'
tap 'homebrew/versions'
EOF
logk

# Check and install any remaining software updates.
logn "Checking for software updates:"
if softwareupdate -l 2>&1 | grep $Q "No new software available."; then
  logk
else
  echo
  log "Installing software updates:"
  if [ -z "$STRAP_CI" ]; then
    sudo softwareupdate --install --all
    xcode_license
  else
    echo "Skipping software updates for CI"
  fi
  logk
fi



# Setup Brewfile
if [ -n "$STRAP_GITHUB_USER" ] && ! [ -f "$HOME/.Brewfile" ]; then
  HOMEBREW_BREWFILE_URL="https://github.com/$STRAP_GITHUB_USER/homebrew-brewfile"

  if git ls-remote "$HOMEBREW_BREWFILE_URL" &>/dev/null; then
    log "Fetching $STRAP_GITHUB_USER/homebrew-brewfile from GitHub:"
    if [ ! -d "$HOME/.homebrew-brewfile" ]; then
      log "Cloning to ~/.homebrew-brewfile:"
      git clone $Q "$HOMEBREW_BREWFILE_URL" ~/.homebrew-brewfile
      logk
    else
      (
        cd ~/.homebrew-brewfile
        git pull $Q
      )
    fi
    ln -sf ~/.homebrew-brewfile/Brewfile ~/.Brewfile
    logk
  fi
fi

# Install from local Brewfile
if [ -f "$HOME/.Brewfile" ]; then
  log "Installing from user Brewfile on GitHub:"
  brew bundle --global
  logk
fi



exit 0
