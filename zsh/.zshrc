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
  fzf
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
alias nf="neofetch"
alias cd1="cd ../ && ls"
alias cd2="cd ../../ && ls"
alias cd3="cd ../../../ && ls"
alias cd4="cd ../../../../ && ls"
alias setkb-us="setxkbmap -model abnt2 -layout us -variant intl -option caps:ctrl_modifier shift:both_capslock_cancel"
alias setkb-br="setxkbmap -model abnt2 -layout br -variant abnt2 -option caps:ctrl_modifier shift:both_capslock_cancel"
alias clima="curl pt-br.wttr.in"
# Work
alias apb='ansible-playbook'
alias v='nvim'
alias lv='lvim'
alias cpid="cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard"
alias open-android="android-studio src-cordova/platforms/android > /dev/null 2>&1 &"
alias wgup="sudo wg-quick up wg0"
alias wgs="sudo wg show wg0"
alias clfy="clockify-cli"
alias week-hours="clockify-cli report this-week | awk -F '|' '{ if (\$5) { print \$5 } }' | awk 'ENDFILE { print \$0 }'"
alias last-week-hours="clockify-cli report last-week | awk -F '|' '{ if (\$5) { print \$5 } }' | awk 'ENDFILE { print \$0 }'"
# Mullvad
alias ml="mullvad"
alias mlc="mullvad connect && sleep 1 && mullvad status"
alias mld="mullvad disconnect && sleep 1 && mullvad status"
alias mls="mullvad status"

# Loads nvm, rvm and fzf
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
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
# iFut
export dionysus="ec2-user@3.238.114.88"
export athena="ec2-user@3.236.123.194"
export staging="ec2-user@3.85.89.193"
export services="root@3.238.33.119"
# Android
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=$PATH:/opt/gradle/gradle-7.0/bin
# Java
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
export JAVAC_HOME=$JAVA_HOME/bin/javac
export PATH=${PATH}:/usr/lib64/openjdk-8/jre/bin
export PATH=${PATH}:/usr/lib64/openjdk-8/bin
# Others
export STARSHIP_CONFIG=~/.config/starship/config.toml
export GPG_TTY=$(tty)
export CLOUDSDK_PYTHON=python2
export oldssh=~/Documentos/.stuff/id_ed25519

# Should run everytime
# cat ~/.cache/wal/sequences 2>/dev/null 2&>1
(cat ~/.cache/wal/sequences &)
eval $(thefuck --alias)
eval "$(starship init zsh)"
