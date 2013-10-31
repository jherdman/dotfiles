# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="kolo"

# We need to know this before oh-my-zsh goes to town

plugins=(vi-mode brew)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export LC_CTYPE="en_US.UTF-8"
export PAGER=less
export EDITOR=vim

export PATH="/usr/local/bin:/usr/local/share/npm/bin:/Users/james/.lein/bin:/usr/local/sbin:$PATH"
export NODE_PATH="/usr/local/lib/node_modules"

alias ls="ls -G"
alias be='bundle exec'
alias curl='noglob curl'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tl='tmux ls'
alias v='vagrant'
alias vbox-restart='/Library/StartupItems/VirtualBox/VirtualBox restart'

## RVM
unsetopt auto_name_dirs
if [[ -s /Users/james/.rvm/scripts/rvm ]] ; then source /Users/james/.rvm/scripts/rvm ; fi

## Opts
unsetopt extended_glob

## zmv util
autoload -U zmv

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

bindkey "^R" history-incremental-search-backward

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
