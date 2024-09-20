# Must Install 1st
```
sudo pkg install kitty htop neofetch mupdf sxiv mpv neovim cmus zoxide fzf tldr thefuck gparted ncdu qrencode xclip stow
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
sudo pkg install zsh
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

# My .bashrc config
```
# Bash Prompt
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\n\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# Vim Mode
set -o vi

# Exports
export BROWSER='firefox'
export EDITOR='nvim'
export VISUAL='nvim'

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias c='xclip -sel clip'
alias p='xclip -o -sel clip'
alias vim='nvim'

# Shell Integrations
eval "$(zoxide init bash)"
eval "$(thefuck --alias)"
export PATH="$PATH:/opt/nvim-linux64/bin"

# ASCII Art
#neofetch
#figlet -t F-c -f ANSIShadow "welcome"
#fortune | cowsay -f tux
fastfetch -c ~/.config/fastfetch/minimal.jsonc

# PipX
#export PATH="$PATH:/home/fdan/.dotfiles/.local/bin"
```

# Winetricks
```
winetricks d3dx10 d3dx9 dotnet35 dotnet40 dotnet45 dotnet48 dxvk vcrun2008 vcrun2010 vcrun2012 vcrun2019 vcrun6sp6
```

# Applications 2 Install (optional)
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
- musicbrain
- virtualbox
- obsidian
- signal
- keepassxc
- okular
- ani-cli
- eza
- dust
- atuin
