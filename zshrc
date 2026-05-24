export ZSH_THEME="kolo"
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Customize to your needs...

export PATH="/opt/homebrew/bin:/usr/local/sbin:$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin:$HOME/bin"

plugins=(asdf gitfast tmux mix-fast)

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

alias yeet="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --write-thumbnail -o \"%(title)s-%(id)s.%(ext)s\""
