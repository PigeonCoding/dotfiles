#!/usr/bin/env bash

cliphist list | fuzzel --dmenu | cliphist decode | wl-copy
