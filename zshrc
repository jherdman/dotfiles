# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="mine"

# We need to know this before oh-my-zsh goes to town

plugins=(vi-mode brew git-flow)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export LC_CTYPE="en_US.UTF-8"
export LD_LIBRARY_PATH=/usr/local/lib
export PAGER=less
export ACK_PAGER_COLOR='less -R'
export EDITOR=vim

export PATH="/usr/local/bin:/usr/local/share/npm/bin:/Users/james/.lein/bin:/Users/james/Library/Haskell/bin:$PATH"
export NODE_PATH="/usr/local/lib/node_modules"

## Aliases
alias ri='RI="${RI} -f ansi" LESS="${LESS} -f -R" ri'
alias ls="ls -G"
alias gvim='mvim -p'
alias vim='vim -p'
alias cuke=cucumber
alias tmux="TERM=xterm-256color tmux"
alias be='bundle exec'
alias ctags="`brew --prefix`/bin/ctags"
alias mtags='ctags -R --exclude=.git --exclude=log --exclude=coverage --exclude=tmp --exclude=vendor --exclude=doc --exclude=db --exclude=config --exclude=bin --exclude=node_modules *'
alias curl='noglob curl'
alias rake='noglob rake'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tl='tmux ls'

## RVM
unsetopt auto_name_dirs
if [[ -s /Users/james/.rvm/scripts/rvm ]] ; then source /Users/james/.rvm/scripts/rvm ; fi

## Opts
unsetopt extended_glob

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
