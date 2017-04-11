#!/bin/sh

if [ -z $__pyenv_started ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  __pyenv_started="x"
fi
