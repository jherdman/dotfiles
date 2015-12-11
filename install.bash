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
  brew install tmux the_silver_searcher tmux-pasteboard reattach-to-user-namespace
elif [[ $UNAMESTR == 'Linux' ]]; then
  echo "Installing packages for Linux..."

  sudo apt-get install software-properties-common
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo add-apt-repository -y ppa:pi-rho/dev
  sudo apt-get update
  sudo apt-get install neovim silversearcher-ag tmux
else
  echo "Unknown platform ${UNAMESTR}! Packages not installed."
fi

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
