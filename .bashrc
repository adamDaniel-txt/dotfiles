# Exports
export BROWSER='w3m'
export EDITOR='nvim'
export VISUAL='nvim'
export TERM='kitty'

# Bash Prompt
export PS1="\n\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\n\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# Shopt
shopt -s autocd
shopt -s cdspell

# Ignore upper and lowercase when TAB completion
#bind "set completion-ignore-case on"

## Vim Mode
#set -o vi
#bind -m vi-command 'Control-l: clear-screen'
#bind -m vi-insert 'Control-l: clear-screen'

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='eza -lah --git --group-directories-first'
alias grep='grep --color=auto'
alias c='xclip -sel clip'
alias p='xclip -o -sel clip'
alias v='nvim'
alias pdf='zathura'
alias yta='yt-dlp --extract-audio --audio-format m4a --audio-quality 0 --add-metadata'
alias cp='cp -riv'
alias mv='mv -iv'
alias df='df -h'
alias po='sudo shutdown now'
alias rs='sudo reboot'

# Git
alias gs='git status'
alias glog='git log --graph --decorate --oneline'

# Change your default USER shell
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Log out and log back in for change to take effect.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Log out and log back in for change to take effect.'"

# Shell Integrations
eval "$(zoxide init bash)"
eval "$(thefuck --alias)"
export PATH="$PATH:/opt/nvim-linux64/bin"

# ASCII Art
#neofetch
#figlet -t F-c -f ANSIShadow "welcome"
#fortune | cowsay -f tux
fastfetch -c ~/.config/fastfetch/minimal.jsonc

# Compile and Run C prog file
crun() {
  gcc -o "${1%.*}" "$1" -lm && ./"${1%.*}"
}
crun11() {
  gcc -std=c++11 -o "${1%.*}" "$1" -lm && ./"${1%.*}"
}

# Archive Extract
ex() {
  if [ -f $1 ]; then
    case $1 in
    *.tar.bz2) tar xjf $1 ;;
    *.tar.gz) tar xzf $1 ;;
    *.bz2) bunzip2 $1 ;;
    *.rar) unrar x $1 ;;
    *.gz) gunzip $1 ;;
    *.tar) tar xf $1 ;;
    *.tbz2) tar xjf $1 ;;
    *.tgz) tar xzf $1 ;;
    *.zip) unzip $1 ;;
    *.Z) uncompress $1 ;;
    *.7z) 7za e x $1 ;;
    *.deb) ar x $1 ;;
    *.tar.xz) tar xf $1 ;;
    *.tar.zst) unzstd $1 ;;
    *) echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Hastebin
hb() {
  if [ $# -eq 0 ]; then
    echo "No file path specified."
    return
  elif [ ! -f "$1" ]; then
    echo "File path does not exist."
    return
  fi

  uri="http://bin.christitus.com/documents"
  response=$(curl -s -X POST -d "$(cat "$1")" "$uri")
  if [ $? -eq 0 ]; then
    hasteKey=$(echo $response | jq -r '.key')
    echo "http://bin.christitus.com/$hasteKey"
  else
    echo "Failed to upload the document."
  fi
}

# Qrclip
qr() {
  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    # Wayland environment
    qrencode -t PNG -s 16 -o /tmp/tmp.png $(wl-paste)
  else
    # X11 environment
    qrencode -t PNG -s 16 -o /tmp/tmp.png $(xclip -o -sel)
  fi

  nsxiv /tmp/tmp.png
}
qrrr() {
  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    # Wayland environment
    qrencode -t PNG -s 16 -o /tmp/tmp.png "https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUXbmV2ZXIgZ29ubmEgZ2l2ZSB5b3UgdXA%3D"
  else
    # X11 environment
    qrencode -t PNG -s 16 -o /tmp/tmp.png "https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUXbmV2ZXIgZ29ubmEgZ2l2ZSB5b3UgdXA%3D"

  fi

  nsxiv /tmp/tmp.png
}

# PipX
#export PATH="$PATH:/home/fdan/.dotfiles/.local/bin"

. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
