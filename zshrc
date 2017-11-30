# Path to your oh-my-zsh configuration.
if [[ -d $HOME/.oh-my-zsh ]] ; then
  export ZSH=$HOME/.oh-my-zsh
else
  export ZSH=/usr/local/share/ohmyzsh
fi

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="kolo"

# We need to know this before oh-my-zsh goes to town

plugins=(brew colored-man tmux mix-fast)

source $ZSH/oh-my-zsh.sh

# Because sometimes things suck
platform='unknown'
unamestr=`uname`

if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'

  alias ls="ls -G --color=auto"
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'

  alias ls="ls -G"
fi

# Customize to your needs...

export LC_CTYPE="en_US.UTF-8"
export PAGER=less
export EDITOR=nvim

export NODE_PATH="/usr/local/lib/node_modules:$HOME/.npm-global"
export PATH="/usr/local/bin:/usr/local/share/npm/bin:/usr/local/sbin:./node_modules/.bin:$HOME/.ansible-env/bin:$PATH:$HOME/.npm-global/bin::/Applications/Postgres.app/Contents/Versions/latest/bin"

alias curl='noglob curl'
alias v='vagrant'
alias peek='sips -g pixelWidth -g pixelHeight -g format'
alias mt='file --mime-type -b'
alias vim='nvim'
alias nom="rm -rf node_modules && npm cache clear && npm i"
alias bom="rm -rf bower_components && bower cache clean && bower install"
alias nombom="nom && bom"

## Opts
unsetopt extended_glob

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

bindkey "^R" history-incremental-search-backward

autoload zmv

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
