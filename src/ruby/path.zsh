#!/bin/sh
export PATH="$PATH:$HOME/.rbenv/bin"

if [ -z $__rbenv_started ]; then
  eval "$(rbenv init -)"
  __rbenv_started="x"
fi
