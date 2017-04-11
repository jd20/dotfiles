#!/bin/sh
export PATH="$HOME/.pyenv/bin:$PATH"

if [ -z $__pyenv_started ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  __pyenv_started="x"
fi
