# Oh my ZSH config and plugins
export ZSH="/home/coffee/.oh-my-zsh"
ZSH_THEME="jnrowe"

plugins=(
	adb
	ansible
	aws
	bgnotify
	docker-compose
	git
	terraform
	thefuck
	vagrant
	wd
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Aliases
# Utils
alias s="startx"
alias pac="sudo pacman"
alias copy="xclip -selection clipboard"
alias t="touch"
# Coding
alias apb='ansible-playbook'
alias v='nvim'
# Nord
alias nv="nordvpn"
alias nvc="nordvpn connect"
alias nvcs="nordvpn connect && nordvpn status"
alias nvd="nordvpn disconnect"
alias nvds="nordvpn status && nordvpn disconnect"
alias nvs="nordvpn status"

# Loads NVM and RVM
[[ -s "$HOME/.rvm/s/rvm" ]] && source "$HOME/.rvm/s/rvm"
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

# Env Vars
# Defaults
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export TERM="xterm-256color"
# Path
export PATH=${PATH}:$HOME/.local/bin
export PATH="$PATH:$HOME/.rvm/bin"
# Android
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=$PATH:/opt/gradle/gradle-7.0/bin
# Java
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:jre/bin/java::")
export JAVAC_HOME=$JAVA_HOME/bin/javac
export PATH=${PATH}:/usr/lib64/openjdk-8/jre/bin
export PATH=${PATH}:/usr/lib64/openjdk-8/bin
# Others
export STARSHIP_CONFIG=~/.config/starship/config.toml
export GPG_TTY=$(tty)
export CLOUDSDK_PYTHON=python2

# Should run everytime
cat ~/.cache/wal/sequences 2>/dev/null 2&>1
eval $(thefuck --alias)
eval "$(starship init zsh)"
