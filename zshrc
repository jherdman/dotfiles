bindkey -v

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="james"

# We need to know this before oh-my-zsh goes to town
export EDITOR='vim'

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export LC_CTYPE="en_US.UTF-8"
export LD_LIBRARY_PATH=/usr/local/lib
export PAGER=less
export ACK_PAGER_COLOR='less -R'

PATH="/opt/local/lib/postgresql83/bin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/scripts:/Users/james/.gem/ruby/1.8/bin:/Users/james/.dotfiles/bin:$PATH"

## Aliases
alias ri='RI="${RI} -f ansi" LESS="${LESS} -f -R" ri'
alias finder='open -a Finder "$@"'
alias ls="ls -G"
alias gvim='mvim "$@"'
alias v8-repl='rlwrap v8'
alias nirb='rlwrap node-repl'
alias cuke=cucumber
alias src=screen

## Rails Aliases
alias ss='ruby script/server --debug'
alias cons='ruby script/console'
alias sg='ruby script/generate'

## RVM
if [[ -s /Users/james/.rvm/scripts/rvm ]] ; then source /Users/james/.rvm/scripts/rvm ; fi
