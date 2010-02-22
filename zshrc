# Shell constants
export PROMPT="$(print '%{\e[0;32m%}(%~)%{\e[0;33m%}\u2192 %{\e[0m%}')"
export EDITOR="nano -w"
export CLICOLOR='true'
export LSCOLORS='GxFxCxDxBxEGEDABAGACAD'
export LC_CTYPE="en_US.UTF-8"
export LD_LIBRARY_PATH=/usr/local/lib

PATH="/opt/local/apache2/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/X11R6/bin:/usr/local/scripts:/opt/local/bin:/usr/local/games:/Users/james/.gem/ruby/1.8/bin:/usr/local/rubinius/bin:$PATH"

export EDITOR='vim'
export PAGER=less
export ACK_PAGER_COLOR='less -R'

# Aliases
alias ri='RI="${RI} -f ansi" LESS="${LESS} -f -R" ri'
alias finder='open -a Finder "$@"'
alias Firefox='open -a Firefox "$@"'
alias Safari='open -a Safari "$@"'
alias ls="ls -G"
alias gvim='mvim "$@"'
alias ss='ruby script/server --debug'
alias cons='ruby script/console'
alias v8='rlwrap v8'
alias node-repl='rlwrap node-repl'

# Git aliases

autoload colors ; colors
autoload -U compinit
autoload zmv
compinit

## Private ZSH Stuff
if [[ -f ~/.private.zsh ]]; then . ~/.private.zsh fi

## RVM
if [[ -s /Users/james/.rvm/scripts/rvm ]] ; then source /Users/james/.rvm/scripts/rvm ; fi
