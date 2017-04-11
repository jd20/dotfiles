#!/bin/sh
export PATH="$HOME/.rbenv/bin:$PATH"

if [ -z $__rbenv_started ]; then
  eval "$(rbenv init -)"
  __rbenv_started="x"
fi
