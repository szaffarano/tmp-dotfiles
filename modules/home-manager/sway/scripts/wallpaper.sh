#!/usr/bin/env bash

KEEP_LATESTS=50

wallpapers="${XDG_PICTURES_DIR:-$HOME/Pictures}/wallpapers"

[ -d "$wallpapers" ] || mkdir -p "$wallpapers"

img=$(curl 'https://unsplash.it/1920/1080/?random' \
  -LJO -s --output-dir "$wallpapers" --write-out '%{filename_effective}')

find "$wallpapers" -maxdepth 1 -type f | head -n -$KEEP_LATESTS | xargs -I {} rm "$wallpapers"/{}

echo -n "$(realpath "$img")"
