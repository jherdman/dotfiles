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

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

UNAMESTR=`uname`

if [[ $UNAMESTR == 'Darwin' ]]; then
  echo "Installing packages for OS X..."

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install neovim/neovim/neovim
  brew install tmux tmux-pasteboard reattach-to-user-namespace ripgrep
elif [[ $UNAMESTR == 'Linux' ]]; then
  echo "Installing packages for Linux..."

  sudo apt-get install software-properties-common

  # Install NeoVim
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod u+x nvim.appimage
  sudo mv nvim.appimage /usr/local/bin/nvim

  # https://gist.github.com/P7h/91e14096374075f5316e
  TMUX_VERSION=2.8
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
  sudo mv tmux-${TMUX_VERSION} /usr/local/src

  # Install ripgrep
  RIPGREP_VERSION="0.10.0"
  RIPGREP_FILE_NAME="ripgrep-${RIPGREP_VERSION}-amd64.deb"
  cd $HOME
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/${RIPGREP_FILE_NAME}.tar.gz
  tar xvzf ${RIPGREP_FILE_NAME}.tar.gz
  sudo dpkg -i $RIPGREP_FILE_NAME

  # Install hub
  HUB_VERSION="2.7.0"
  HUB_FILE_NAME="hub-linux-amd64-${HUB_VERSION}"
  cd $HOME
  curl -LO https://github.com/github/hub/releases/download/v${HUB_VERSION}/${HUB_FILE_NAME}.tgz
  tar xvzf ${HUB_FILE_NAME}.tgz
  sudo bash ${HUB_FILE_NAME}/install
else
  echo "Unknown platform ${UNAMESTR}! Packages not installed."
fi

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
