export ZSH_THEME="kolo"
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Customize to your needs...

export PATH="/usr/local/bin:/usr/local/sbin:$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin:$HOME/bin"

# ASDF
# ----
#
# I install to a weird location
export ASDF_DIR=$HOME/tools/asdf

plugins=(asdf tmux mix-fast)

# Path to your oh-my-zsh configuration.
if [[ -d $HOME/.oh-my-zsh ]] ; then
  export ZSH=$HOME/.oh-my-zsh
else
  export ZSH=/usr/local/share/ohmyzsh
fi

export LC_CTYPE="en_US.UTF-8"
export PAGER=less
export EDITOR=nvim

source $ZSH/oh-my-zsh.sh

# BASE16
# ------

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Erlang/Elixir
# -------------
#
# Enable history in IEX
export ERL_AFLAGS="-kernel shell_history enabled"

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

# JUMP
# ----
eval "$(jump shell zsh)"

# FZF
# ---

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

# Because sometimes things suck
# -----------------------------
unamestr=`uname`

if [[ "$unamestr" == 'Linux' ]]; then
  alias ls="ls -G --color=auto"
  alias cat='batcat'
  alias ccat='/usr/bin/cat'

  export BROWSER=/usr/bin/firefox
elif [[ "$unamestr" == 'Darwin' ]]; then
  alias ls="ls -G"
  alias cat='bat'
  alias ccat='/bin/cat'
fi

# iTerm2 Integration
# ------------------

[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
