#!/usr/bin/env bash

notify-send "select a color"
niri msg pick-color | grep '#' | sed 's/Hex: //' | cliphist store -
notify-send "color copied to clipboard"
