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

plugins=(tmux mix-fast)

source $ZSH/oh-my-zsh.sh

# Because sometimes things suck
unamestr=`uname`

if [[ "$unamestr" == 'Linux' ]]; then
  alias ls="ls -G --color=auto"
  alias cat='batcat'
  alias ccat='/usr/bin/cat'
elif [[ "$unamestr" == 'Darwin' ]]; then
  alias ls="ls -G"
  alias cat='bat'
  alias ccat='/usr/bin/cat'
fi

# Customize to your needs...

export LC_CTYPE="en_US.UTF-8"
export PAGER=less
export EDITOR=nvim

export PATH="/usr/local/bin:/usr/local/sbin:$HOME/.ansible-env/bin:$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin:$HOME/bin"

alias curl='noglob curl'
alias vim='nvim'

## Opts
unsetopt extended_glob

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

bindkey "^R" history-incremental-search-backward

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

# Enable history in IEX
export ERL_AFLAGS="-kernel shell_history enabled"

export ZSH_AUTOSUGGEST_USE_ASYNC=1

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

eval "$(jump shell zsh)"
