# Must Install 1st
```
sudo apt install  unclutter kitty slock scrot htop neofetch zathura nsxiv mpv neovim cmus zoxide fzf tldr thefuck gparted ncdu qrencode xclip stow tmux eza
```

# Install Font
1. Install fonts from "https://www.nerdfonts.com/"
2. Extract the zip file
```
unzip fontname.zip -d fontname
```
3. Copy the font folder move to `~/.local/share/fonts/`
```
cp fontfoldername ~/.local/share/fonts/
```

# Install Zsh
1. Install zsh
```
sudo apt install zsh
```
2. Change shell
```
chsh -s /bin/zsh "username"
chsh -s /bin/zsh root
```

# Git Timer
```
git config --global credential.helper 'cache --timeout=10800'
```

# Manage Dotfiles
1. Go inside the dotfiles directory
```
cd .dotfiles
```
2. Symlink the files with stow
```
stow .
```
3. If there's a conflicting files, use adopt flag (commit first before adopting)
```
stow --adopt .
```
4. Now that the files has been overwritten. It's a good idea to restore from the commiting files
```
git diff .
git status
git restore .
```

# Firefox Customization
## Firefox user.js
1. Downloads or copy Betterfox user.js file
```
git clone https://github.com/yokoffing/Betterfox.git
```
2. Move the user.js file into Firefox's about:profiles
## Firefox css theme
1. Copy some else userChrome.css to make your Firefox looks cool.
```
git clone https://github.com/ericmurphyxyz/userChrome.css.git
```

# Figlet Fonts
1. Copy from "https://raw.githubusercontent.com/xero/figlet-fonts/master/ANSI%20Shadow.flf"
2. Save it as "ANSIShadow.flf"
3. Install files to /usr/share/figlet/ or /usr/share/figlet/fonts/

# Winetricks
```
winetricks d3dx10 d3dx9 dotnet35 dotnet40 dotnet45 dotnet48 dxvk vcrun2008 vcrun2010 vcrun2012 vcrun2019 vcrun6sp6
```

# Cool Programs
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
