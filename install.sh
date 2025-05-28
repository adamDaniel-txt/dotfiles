#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

pkg_install="apt install"
HOME="/home/fdan"

mkdir -p $HOME/.local/bin
mkdir $HOME/.config
mkdir $HOME/desk
mkdir $HOME/dl
mkdir $HOME/dox
mkdir $HOME/mus
mkdir $HOME/sync
mkdir $HOME/pix
mkdir $HOME/vids

echo "Installing the necessary pre-requisites"
while read -r p ; do sudo $pkg_install -y $p ; done < <(cat << "EOF"
	git
	vim
	zip unzip
	curl
	playerctl
	dunst
	lf
	duf
	pamixer
	unclutter
	kitty
	slock
	scrot
	htop
	fastfetch
	zathura
	nsxiv
	mpv
	neovim
	cmus
	zoxide
	fzf
	tealdeer
	gparted
	ncdu
	qrencode
	xclip
	stow
	tmux
	eza
	xwallpaper
	pipewire
	redshift
	xcompmgr
	cron
	acpi
	mpd
	ncmpcpp
EOF
)

echo "Linking dotfiles"
cd $HOME/.dotfiles/
stow --adopt .
git restore .

echo "Installing suckless software"
while read -r p ; do sudo $pkg_install -y $p ; done < <(cat << "EOF"
	xorg
	build-essential
	dbus-x11
	libx11-dev
	libxft-dev
	libxinerama-dev
	libx11-xcb-dev
	libxcb-res0-dev
	libharfbuzz-dev
	libjpeg-dev
EOF
)

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

echo "Installation Finish"
