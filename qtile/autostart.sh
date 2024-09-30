#!/bin/bash

setxkbmap -model abnt3 -layout us -variant intl -option caps:ctrl_modifier shift:both_capslock_cancel
~/.config/scripts/poly &
greenclip daemon &
