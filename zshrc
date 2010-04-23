bindkey -v

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="james"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# We need to know this before oh-my-zsh goes to town
export EDITOR='vim'

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export LC_CTYPE="en_US.UTF-8"
export LD_LIBRARY_PATH=/usr/local/lib
export PAGER=less
export ACK_PAGER_COLOR='less -R'
export LSCOLORS='GxFxCxDxBxEGEDABAGACAD'

PATH="/opt/local/lib/postgresql83/bin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/X11R6/bin:/usr/local/scripts:/opt/local/bin:/usr/local/games:/Users/james/.gem/ruby/1.8/bin:$PATH"

## Aliases
alias ri='RI="${RI} -f ansi" LESS="${LESS} -f -R" ri'
alias finder='open -a Finder "$@"'
alias ls="ls -G"
alias gvim='mvim "$@"'
alias ss='ruby script/server --debug'
alias cons='ruby script/console'
alias v8-repl='rlwrap v8'
alias nirb='rlwrap node-repl'
alias cuke=cucumber

## RVM
if [[ -s /Users/james/.rvm/scripts/rvm ]] ; then source /Users/james/.rvm/scripts/rvm ; fi
