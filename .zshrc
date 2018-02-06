ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ajcrites"
plugins=(git vi-mode z colored-man history-substring-search hub docker docker-compose aws)

source $ZSH/oh-my-zsh.sh
source $HOME/.bash_aliases
source $HOME/.bash_functions

set +o HIST_VERIFY
set +o HIST_FIND_NO_DUPS
set +o HIST_IGNORE_ALL_DUPS
export EDITOR=nvim

# My own scripts
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Smartcase tab completion
zstyle ':completion:*' matcher-list 'm:{a-z0-9}={A-Z0-9}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

bindkey -M viins 'ij' vi-cmd-mode
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export GOPATH=$HOME/projects/personal/gopath
alias vim=nvim

export N_PREFIX=$HOME/.n

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.n/bin:$PATH"

export ANDROID_HOME=/Users/acrites/Library/Android/sdk
export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH=$PATH:$GOPATH/bin

export JAVA_HOME="$(/usr/libexec/java_home)"

compdef gilt=git
