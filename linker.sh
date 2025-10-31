#!/usr/bin/env bash

link() {
  echo "$PWD/$1" "->" "$2"
  ln -s "$PWD/$1" "$2" 2> /dev/null
}

link niri       ~/.config
link kitty      ~/.config
link helix      ~/.config
link waybar     ~/.config
link alacritty  ~/.config
link fuzzel     ~/.config
link .oh-my-zsh ~
link .zshrc     ~
link .zen.toml  ~
