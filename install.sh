#!/bin/bash

# this script only works on debian sid for now. I think..

set -eu -o pipefail # fail on error and report it, debug all lines

# sudo -n true
# test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

USER="fdan" # change to your username
HOME="/home/$USER"

mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/share/themes
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/qutebrowser

sudo apt update && sudo apt upgrade

echo "Installing the necessary"
sudo apt install -y git vim zip unzip curl playerctl dunst lf duf pamixer unclutter kitty suckless-tools scrot htop zathura nsxiv mpv neovim cmus zoxide fzf tealdeer gparted ncdu qrencode xclip stow tmux xwallpaper pipewire redshift picom cron fastfetch qutebrowser preload libnotify-bin

echo "Linking dotfiles"
cd $HOME/.dotfiles/
stow --adopt .
git restore .

echo "Installing suckless software"
sudo apt install -y xorg build-essential dbus-x11 libx11-dev libxft-dev libxinerama-dev libx11-xcb-dev libxcb-res0-dev libharfbuzz-dev libjpeg-dev

cd $HOME/.config/suckless/dwm/
sudo make clean install
cd $HOME/.config/suckless/st/
sudo make clean install
cd $HOME/.config/suckless/dmenu/
sudo make clean install
cd $HOME/.config/suckless/farbfeld/
sudo make clean install
cd $HOME/.config/suckless/sent/
sudo make clean install

echo "Installing fonts"
sudo apt install -y fonts-liberation fonts-inconsolata fonts-noto-color-emoji fonts-bebas-neue

# cd $HOME
# sudo chown -R $USER:$USER .

echo
echo "Installation Finish"
echo
read -p "Do you want to Reboot? (y/n) :: " yn
case $yn in
	[yY]) echo "Rebooting..." && sudo reboot;;
	[nN]) echo "Exiting...";;
	*) echo "invalid response. do nothing...";;
esac
