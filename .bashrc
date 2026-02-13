# Bash Prompt
export PS1="\n\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\n\[$(tput setaf 7)\]\\[$(tput sgr0)\]_ "

# Shopt
shopt -s autocd
shopt -s cdspell

# Coolers
alias ls="ls -hN --color=auto --group-directories-first"
alias l="ls -lah --color=auto --group-directories-first"
# alias ll="eza -lah --git --group-directories-first"
alias grep="grep --color=auto -i"
alias diff="diff --color=auto"

# Verbosity
alias cp="cp -riv"
alias mv="mv -iv"
alias rm="rm -vI"
alias rsync="rsync -ah --info=progress2"
alias yt="yt-dlp -f 'bv[height=720]+ba/best[height=720]' --merge-output-format webm"
alias yta="yt-dlp --extract-audio --audio-format opus --audio-quality 0 --add-metadata"

# Abbreviate
alias search="apt search"
alias update="sudo apt update -y && sudo apt upgrade -y"
alias install="sudo apt install"
alias remove="sudo apt purge"
alias sc="sc-im"
alias ai="ollama run llama3.2:1b"
alias po="sudo shutdown now"
alias rs="sudo reboot"
alias c="xclip -sel clip"
alias p="xclip -o -sel clip"
alias vim="nvim"
alias pdf="zathura"
alias javap="javac -d . -sourcepath src src/main/*.java && java main.Main"
alias optjpgs="mogrify -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace sRGB -resize 400 -path "min" *.jpg"

# Git
alias g="git"
alias gs="git status"
alias glog="git log --graph --decorate --oneline"

# Change default shell
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Log out and log back in for change to take effect.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Log out and log back in for change to take effect.'"

# Shell Integrations
eval "$(zoxide init bash --cmd cd)"
eval "$(fzf --bash)"
source /usr/share/bash-completion/bash_completion
# source /usr/share/doc/fzf/examples/key-bindings.bash

# ASCII Art
#neofetch
#figlet -t F-c -f ANSIShadow "welcome"
#fortune | cowsay -f tux
# fastfetch -c ~/.config/fastfetch/minimal.jsonc
task

# Optimize image for the web
optimg() {
	magick $1 -sampling-factor 4:2:0 -strip -quality 85 -interlace Plane -colorspace sRGB -resize $2 $3
}

optvid() {
	ffmpeg -i $1 -vcodec libx265 -crf 28 $2
}

opt4miyoo() {
	ffmpeg -i $1 -vf "scale=720:540" -c:v libx265 -crf 28 -c:a copy $2
}

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
			*.7z) 7z e x $1 ;;
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
