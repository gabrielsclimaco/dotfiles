# Oh my ZSH config and plugins
export ZSH="/home/coffee/.oh-my-zsh"
ZSH_THEME="jnrowe"

plugins=(
  adb
  ansible
  aws
  bgnotify
  dnf
  docker-compose
  git
  systemd
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
alias sc="sudo systemctl"
alias attc="awmtt start -C $1"
alias attr="awmtt restart"
alias atts="awmtt stop"
alias shut="shutdown -h now"
alias btl="bluetoothctl"
alias bton="bluetoothctl power on"
alias pf="pfetch"
alias cd1="cd ../ && ls"
alias cd2="cd ../../ && ls"
alias cd3="cd ../../../ && ls"
alias cd4="cd ../../../../ && ls"
alias setkb="setxkbmap -model abnt2 -layout us -variant intl -option caps:ctrl_modifier shift:both_capslock_cancel"
alias clima="curl pt-br.wttr.in"
# Work
alias apb='ansible-playbook'
alias v='nvim'
alias lv='lvim'
alias cpid="cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard"
alias open-android="android-studio src-cordova/platforms/android > /dev/null 2>&1 &"
# Nord
alias nv="nordvpn"
alias nvc="nordvpn connect"
alias nvcs="nordvpn connect && nordvpn status"
alias nvd="nordvpn disconnect"
alias nvds="nordvpn status && nordvpn disconnect"
alias nvs="nordvpn status"

# Loads nvm, rvm and fzf
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Env Vars
# Defaults
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export TERM="xterm-256color"
# Path
export PATH=${PATH}:$HOME/.local/bin
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/scripts"
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
# cat ~/.cache/wal/sequences 2>/dev/null 2&>1
(cat ~/.cache/wal/sequences &)
eval $(thefuck --alias)
eval "$(starship init zsh)"
