#!/bin/sh

setxkbmap -option "caps:swapescape"
#feh --bg-fill ~/Pictures/Wallpapers/void.png
xwallpaper --zoom ~/Pictures/Wallpapers/cloud-hill-anime.jpg
redshift -l 3.14:101.69 &
pipewire &
syncthing -no-browser &
dunst &
#dwmblocks &
bash ~/.local/bin/bar.sh &

exec dwm
