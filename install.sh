#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

# check package manager
if [[ -f /etc/os-release ]]; then
	pkg_install="xbps-install"
	echo "This is Void. Using xbps-install"
elif [[ -f /etc/debian_version ]]; then
	pkg_install="apt install"
	echo "This is Debian. Using apt"
fi

echo "Installing Git"
$pkg_install git
echo "Git installed!"

echo "Installing the necessary pre-requisites"
while read -r p ; do sudo $pkg_install -y $p ; done < <(cat << "EOF"
	zip unzip
	curl
	playerctl
	curl
	dunst
	lf
	duf
	ripgrep
	pamixer
	unclutter
	kitty
	slock
	scrot
	htop
	neofetch
	zathura
	nsxiv
	mpv
	neovim
	cmus
	zoxide
	fzf
	tldr
	gparted
	ncdu
	qrencode
	xclip
	stow
	tmux
	eza
EOF
)

echo "Linking dotfiles"
cd ~/.dotfiles/
stow --adopt .
git restore .

echo "Compiling suckless software"
while read -r p ; do sudo $pkg_install -y $p ; done < <(cat << "EOF"
	base-devel
	libX11-devel
	libXft-devel
	libXinerama-devel
	freetype-devel
	fontconfig-devel
	harfbuzz-devel
EOF
)

cd ~/.config/suckless/dwm/
sudo make clean install
cd ~/.config/suckless/st/
sudo make clean install
cd ~/.config/suckless/dmenu/
sudo make clean install
cd ~/.config/suckless/farbfeld/
sudo make clean install
cd ~/.config/suckless/sent/
sudo make clean install
