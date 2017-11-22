#!/usr/bin/env bash
##
# Based on https://github.com/michaeljsmalley/dotfiles/blob/892e310cb4ef0e334ab838c27d644d40d690b678/makesymlinks.sh
##

# This directory, no matter what
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
THIS=${0##*/} # http://stackoverflow.com/questions/192319/how-do-i-know-the-script-file-name-in-a-bash-script

for file in $DIR/*
do
  if [[ -f $file ]] && [[ $file != *"${THIS}" ]]; then
    bn=`basename $file`
    ln -sfv $file "${HOME}/.${bn}"
  elif [[ -d $file ]] && [[ $file != *"${THIS}" ]]; then
    bn=`basename $file`
    ln -sfv $file "${HOME}/.${bn}"
  fi
done

#curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

UNAMESTR=`uname`

if [[ $UNAMESTR == 'Darwin' ]]; then
  echo "Installing packages for OS X..."

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install neovim/neovim/neovim
  brew install tmux tmux-pasteboard reattach-to-user-namespace ripgrep
elif [[ $UNAMESTR == 'Linux' ]]; then
  echo "Installing packages for Linux..."

  sudo apt-get install software-properties-common
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo add-apt-repository -y ppa:pi-rho/dev
  sudo apt-get update
  sudo apt-get install neovim

  # https://gist.github.com/P7h/91e14096374075f5316e
  TMUX_VERSION=2.6
  sudo apt-get -y remove tmux
  sudo apt-get -y install wget tar libevent-dev libncurses-dev
  wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
  tar xf tmux-${TMUX_VERSION}.tar.gz
  rm -f tmux-${TMUX_VERSION}.tar.gz
  cd tmux-${TMUX_VERSION}
  ./configure
  make
  sudo make install
  cd -
  sudo rm -rf /usr/local/src/tmux-*
  sudo mv tmux-${TMUX_VERSION} /usr/local/sr

  # Install ripgrep
  RIPGREP_VERSION="0.7.1"
  RIPGREP_FILE_NAME="ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl"
  cd $HOME
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/${RIPGREP_FILE_NAME}.tar.gz
  tar xvzf ${RIPGREP_FILE_NAME}.tar.gz
  sudo mv ${RIPGREP_FILE_NAME}/rg /usr/local/bin/
else
  echo "Unknown platform ${UNAMESTR}! Packages not installed."
fi

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
