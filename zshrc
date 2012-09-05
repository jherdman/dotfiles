# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="mine"

# We need to know this before oh-my-zsh goes to town

plugins=(vi-mode brew)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export LC_CTYPE="en_US.UTF-8"
export PAGER=less
export ACK_PAGER_COLOR='less -R'
export EDITOR=vim

export PATH="/usr/local/bin:/usr/local/share/npm/bin:/Users/james/.lein/bin:/usr/local/sbin:$PATH"
export NODE_PATH="/usr/local/lib/node_modules"

## Aliases
alias ri='RI="${RI} -f ansi" LESS="${LESS} -f -R" ri'
alias ls="ls -G"
alias vim='vim -p'
alias cuke=cucumber
alias tmux='TERM=screen-256color-bce tmux'
alias be='bundle exec'
alias ctags="`brew --prefix`/bin/ctags"
alias curl='noglob curl'
alias rake='noglob rake'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tl='tmux ls'
alias v='vagrant'

## RVM
unsetopt auto_name_dirs
if [[ -s /Users/james/.rvm/scripts/rvm ]] ; then source /Users/james/.rvm/scripts/rvm ; fi

## Opts
unsetopt extended_glob

## zmv util
autoload -U zmv

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

      # Add the following to your ~/.bashrc or ~/.zshrc
      hitch() {
        command hitch "$@"
        if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
      }
      alias unhitch='hitch -u'
      # Uncomment to persist pair info between terminal instances
      # hitch

