# Shell constants
export PROMPT="$(print '%{\e[0;32m%}(%~)%{\e[0;33m%}\u2192 %{\e[0m%}')"
export EDITOR="nano -w"
export CLICOLOR='true'
export LSCOLORS='GxFxCxDxBxEGEDABAGACAD'
export LC_CTYPE="en_US.UTF-8"
export LD_LIBRARY_PATH=/usr/local/lib

PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/X11R6/bin:/usr/local/scripts:/opt/local/bin:/usr/local/games:/usr/local/ruby1.9/bin:/opt/local/lib/postgresql83/bin:$PATH"

MANPATH=/usr/local/pgsql/man:$MANPATH
export MANPATH

export EDITOR='vim'
export PAGER=less
export HEWITT_PROXY='http://proxycacheF.hewitt.com:3128'

# Aliases
alias ri='RI="${RI} -f ansi" LESS="${LESS} -f -R" ri'
alias finder='open -a Finder "$@"'
alias Firefox='open -a Firefox "$@"'
alias Camino='open -a Camino "$@"'
alias Safari='open -a Safari "$@"'
alias qlf='qlmanage -p "$@" >& /dev/null'
alias ls="ls -G"
alias gvim='mvim "$@"'
alias sjruby='jruby -S "$@"'
alias emacsclient='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient --no-wait "$@"'

# Git aliases

alias gst='git status "$@"'
alias gb='git branch "$@"'

autoload colors ; colors
autoload -U compinit
compinit
