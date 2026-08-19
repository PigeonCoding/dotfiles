#!/usr/bin/env bash

link() {
  echo "$PWD/$1" "->" "$2"
  ln -s "$PWD/$1" "$2" 2> /dev/null
}

link konsave    ~/.config
link kitty      ~/.config
link helix      ~/.config
link .zshrc     ~
