# my dotfiles

## installation
On debian based linux distro, run the following as root:
```
git clone https://codeberg.org/somting-fishy/dotfiles .dotfiles
cd .dotfiles
./install.sh
```

## after installation

### set git timer
```
git config --global credential.helper 'cache --timeout=10800'
```

## rules for ufw
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

## enable tap2click & naturalScrolling
* add this in /usr/share/X11/xorg.conf.d/
```
Option "Tapping" "on"
Option "NaturalScrolling" "true"
```

## minimal grub boot
* add this in /etc/default/grub
```
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX=""
GRUB_TERMINAL=console
```

## other software i like
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
