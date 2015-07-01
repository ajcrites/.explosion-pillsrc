# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ajcrites"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow node npm supervisor mongo django vi-mode z colored-man github heroku gem rails rake rvm rbenv vagrant virtualenv brew tmux bundler go history-substring-search knife pip mvn postgres python scala redis-cli web-search mercurial hub karma)

source $ZSH/oh-my-zsh.sh
source $HOME/.bash_aliases
source $HOME/.bash_functions

set +o HIST_VERIFY
export EDITOR=vim

# global node modules -- give these priority on the path
export PATH="$HOME/.npm/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"

# Smartcase tab completion
zstyle ':completion:*' matcher-list 'm:{a-z0-9}={A-Z0-9}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

bindkey -M viins 'ij' vi-cmd-mode
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh" # This loads nvm
