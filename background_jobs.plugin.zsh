#!/usr/bin/env zsh

TMOUT=3

TRAPALRM() {
  for fn in $background_functions; do
    $fn
  done
  zle && zle reset-prompt
}

