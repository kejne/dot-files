#!/bin/bash

sudo sh -c 'cat xkb/us >> /usr/share/X11/xkb/symbols/us'
setxkbmap -layout us
