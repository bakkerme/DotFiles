#!/usr/bin/env bash
swaymsg 'output LVDS-1 disable'
swaymsg 'output DP-1 resolution 2560x1440 position 0,0'
swaymsg 'output DP-1 bg ~/Pictures/fatherlight1_single_2560x1440.jpg fill'
