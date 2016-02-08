# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="kolo"

# We need to know this before oh-my-zsh goes to town

plugins=(brew colored-man tmux)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export LC_CTYPE="en_US.UTF-8"
export PAGER=less
export EDITOR=nvim

export NODE_PATH="/usr/local/lib/node_modules:$HOME/.npm-global"
export PATH="/usr/local/bin:/usr/local/share/npm/bin:$HOME/.lein/bin:/usr/local/sbin:./node_modules/.bin:$HOME/.ansible-env/bin:$PATH"

alias ls="ls -G"
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

BASE16_SHELL="$HOME/.config/base16-shell/base16-monokai.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag -g ""'
