# Shell constants
#export PROMPT="$(print '%{\e[0;33m%}$:%{\e[0;32m%}(%~)%{\e[0m%}') "
export PROMPT="$(print '%{\e[1;34m%}%m:%{\e[1;32m%}%~%{\e[0;33m%}$%{\e[0m%}') "
export EDITOR="nano -w"
export CLICOLOR='true'
export LSCOLORS='GxFxCxDxBxEGEDABAGACAD'
export LC_CTYPE="en_US.UTF-8"
export LD_LIBRARY_PATH=/usr/local/lib

PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/X11R6/bin:/usr/local/scripts:/opt/local/bin:/usr/local/games:/usr/local/ruby1.9/bin:/opt/local/lib/postgresql83/bin:/opt/local/libexec/git-core:$PATH"

MANPATH=/usr/local/pgsql/man:$MANPATH
export MANPATH

export EDITOR=vim
export PAGER=less
export HEWITT_PROXY='http://proxycacheF.hewitt.com:3128'
export HEWITT_SVNURL='svn://10.212.100.90/svn'

# Aliases
alias ri='RI="${RI} -f ansi" LESS="${LESS} -f -R" ri'
alias finder='open -a Finder "$@"'
alias Firefox='open -a Firefox "$@"'
alias Camino='open -a Camino "$@"'
alias Safari='open -a Safari "$@"'
alias qlf='qlmanage -p "$@" >& /dev/null'
alias ls="ls -G"
alias gvim='mvim "$@"'
alias emacsclient='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient "$@"'
alias clemacs='/usr/bin/emacs "$@"'
alias emacs='open -a Emacs "$@"'

# Git aliases

alias gst='git status "$@"'
alias gb='git branch "$@"'

# Auto-pushd. This pushes any directory you visit to the stack
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups

# ZSH specific declarations

function authme {
  ssh $* 'cat >>.ssh/authorized_keys' <~/.ssh/id_dsa.pub
}

autoload colors ; colors
autoload -U compinit
compinit
