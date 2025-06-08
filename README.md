# My Dotfiles

## Installation
On debian based linux distro, run the following as root:
```
git clone https://codeberg.org/somting-fishy/dotfiles .dotfiles
cd .dotfiles
./install.sh
```

## After Installation

### Set Git Timer
```
git config --global credential.helper 'cache --timeout=10800'
```

## Rules for ufw
```
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 53317/tcp
sudo ufw allow 53317/udp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
```

## Other Software I like
- bottom
- auto-cpufreq
- forge
- VsCodium
- fastfetch
- cpufetch
- lutris
- ferdium
- bastet
- flatseal
- bottles
- keepasxc
- qbittorent
- inkscape
- gufw
- Proton VPN
- Mullvad VPN
- pika backup
- kdenlive
- veracrypt
- qemu/kvm
- picard
- virtualbox
- obsidian
- signal
- keepassxc
- okular
- ani-cli
- eza
- dust
- atuin
- cava
- mupdf
- kando
- goofcord
