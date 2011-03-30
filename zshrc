# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="james"

# We need to know this before oh-my-zsh goes to town

plugins=(vi-mode brew)
fpath=(~/.zsh/Completion $fpath)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export LC_CTYPE="en_US.UTF-8"
export LD_LIBRARY_PATH=/usr/local/lib
export PAGER=less
export ACK_PAGER_COLOR='less -R'

export PATH="/usr/local/bin:/usr/local/sbin:/Users/james/.gem/ruby/1.8/bin:/Users/james/.dotfiles/bin:/usr/local/share/npm/bin:/Users/james/.lein/bin:$PATH"
export NODE_PATH="/usr/local/lib/node"

## Aliases
alias ri='RI="${RI} -f ansi" LESS="${LESS} -f -R" ri'
alias finder='open -a Finder "$@"'
alias ls="ls -G"
alias gvim='mvim -p "$@"'
alias vim='vim -p'
alias cuke=cucumber
alias be='bundle exec "$@"'

## RVM
unsetopt auto_name_dirs
if [[ -s /Users/james/.rvm/scripts/rvm ]] ; then source /Users/james/.rvm/scripts/rvm ; fi

## Opts
unsetopt extended_glob

## Hitch shit

hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'
