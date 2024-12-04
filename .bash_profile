# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

# default apps
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="firefox"

# default folders
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"
#export BASH_ENV="$XDG_CONFIG_HOME/shell/bashrc"
export ZDOTDIR="$HOME/.config/zsh"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm"
export W3M_DIR="$XDG_STATE_HOME/w3m"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
