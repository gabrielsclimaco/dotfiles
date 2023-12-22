# Oh my ZSH config and plugins
export ZSH="/home/coffee/.oh-my-zsh"
ZSH_THEME="jnrowe"

plugins=(
  adb
  ansible
  aws
  bgnotify
  dnf
  docker
  docker-compose
  fzf
  gcloud
  git
  kubectl
  systemd
  terraform
  thefuck
  tmux
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
alias f="ranger"
alias sc="sudo systemctl"
alias ls='lsd'
# alias attc="awmtt start -C $1"
# alias attr="awmtt restart"
# alias atts="awmtt stop"
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
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias zshconfig="lvim ~/.config/zsh/.zshrc"
alias zshapply="source ~/.config/zsh/.zshrc"
# Work
alias dps='docker ps'
alias dit='docker exec -it'
alias tfw='terraform workspace'
alias apb='ansible-playbook'
alias v='nvim'
alias lv='lvim'
alias py='python'
alias cpid="cat ~/.ssh/id_ed25519.pub | awk -F ' ' '{print \$1 \" \" \$2}' | xclip -selection clipboard"
alias open-android="android-studio src-cordova/platforms/android > /dev/null 2>&1 &"
alias wgup="sudo wg-quick up wg0"
alias wgs="sudo wg show wg0"
alias clfy="clockify-cli"
alias week-hours="clockify-cli report this-week | awk -F '|' '{ if (\$5) { print \$5 } }' | awk 'ENDFILE { print \$0 }'"
alias last-week-hours="clockify-cli report last-week | awk -F '|' '{ if (\$5) { print \$5 } }' | awk 'ENDFILE { print \$0 }'"
alias pomowork='sleep 1500 && notify-send "break"'
alias pomobreak='sleep 300 && notify-send "work"'
# Pulumi
alias pl="pulumi"
alias plp="pulumi preview"
alias plpd="pulumi preview --diff"
alias plup="pulumi up"
alias plupd="pulumi up --diff"
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
export EDITOR="lvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export TERM="xterm-256color"
# Path
export PATH=${PATH}:$HOME/.local/bin
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/scripts"
export PATH="$PATH:$HOME/.pulumi/bin"
export FLYCTL_INSTALL="/home/coffee/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
# iFut
export hermes="ec2-user@hermes.ifut.com.br"
export zagreus="ec2-user@zagreus.ifut.com.br"
export services="root@metabase.ifut.com.br"
# Android
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=$PATH:/opt/gradle/gradle-7.4.2/bin
# Java
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
export JAVAC_HOME=$JAVA_HOME/bin/javac
export PATH=${PATH}:/usr/lib64/openjdk-8/jre/bin
export PATH=${PATH}:/usr/lib64/openjdk-8/bin
# Others
export STARSHIP_CONFIG=~/.config/starship/config.toml
export GPG_TTY=$(tty)
export CLOUDSDK_PYTHON=python3
export oldssh=~/Documentos/.stuff/id_ed25519

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/2.3.0/gems/vagrant-2.3.0/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)

# Should run everytime
cat ~/.cache/wal/sequences 2>/dev/null 2&>1
# (cat ~/.cache/wal/sequences &)
eval $(thefuck --alias)
eval "$(starship init zsh)"
