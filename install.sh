#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

pkg_install="apt install"

mkdir /home/fdan/.local/bin/
mkdir /home/fdan/"$HOME/desk"
mkdir /home/fdan/"$HOME/dl"
mkdir /home/fdan/"$HOME/dox"
mkdir /home/fdan/"$HOME/mus"
mkdir /home/fdan/"$HOME/sync"
mkdir /home/fdan/"$HOME/pix"
mkdir /home/fdan/"$HOME/vids"

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
EOF
)

echo "Linking dotfiles"
cd $HOME/.dotfiles/
stow --adopt .
git restore .

echo "Installing suckless software"
while read -r p ; do sudo $pkg_install -y $p ; done < <(cat << "EOF"
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
