# ~/.bash_profile

# [[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
# add bin to PATH
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
# add .local/bin to PATH
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# default apps
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="w3m"

# default folders
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export ZDOTDIR="$HOME/.config/zsh"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm"
export W3M_DIR="$XDG_STATE_HOME/w3m"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# use vim to open manpage
export MANPAGER="nvim +Man!"

# add Flatpak apps to PATH
if [ -d "/var/lib/flatpak/exports/bin" ]; then
    PATH="/var/lib/flatpak/exports/bin:$PATH"
fi

if [ -d "$HOME/.local/share/flatpak/exports/bin" ]; then
     PATH="$HOME/.local/share/flatpak/exports/bin:$PATH"
fi

# Start graphical server on user's current tty if not already running.
[[ $(ps -e | grep startx) = '' ]] && startx
