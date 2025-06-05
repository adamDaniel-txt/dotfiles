#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

pkg_install="apt install"
HOME="/home/fdan"

mkdir -p $HOME/.local/bin
if [ -d "$HOME/.config" ]; then
	echo ".config directory exists."
else
	echo ".config directory does not exist."
	echo "making .config directory"
	mkdir $HOME/.config
fi

echo "Installing the necessary pre-requisites"
sudo $pkg_install git vim zip unzip curl playerctl dunst lf duf pamixer unclutter kitty slock scrot htop zathura nsxiv mpv neovim cmus zoxide fzf tealdeer gparted ncdu qrencode xclip stow tmux xwallpaper pipewire redshift xcompmgr cron acpi elogind

echo "Linking dotfiles"
cd $HOME/.dotfiles/
stow --adopt .
git restore .

echo "Installing suckless software"
sudo $pkg_install xorg build-essential dbus-x11 libx11-dev libxft-dev libxinerama-dev libx11-xcb-dev libxcb-res0-dev libharfbuzz-dev libjpeg-dev

cd $HOME/.config/suckless/dwm/
make clean install
cd $HOME/.config/suckless/st/
make clean install
cd $HOME/.config/suckless/dmenu/
make clean install
cd $HOME/.config/suckless/farbfeld/
make clean install
cd $HOME/.config/suckless/sent/
make clean install

echo "\nInstallation Finish"
