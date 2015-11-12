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
    ln -sf $file "${HOME}/.${bn}"
  fi
done

CONFIG_DIR="${HOME}/.config"

mkdir -p $CONFIG_DIR/nvim
ln -sf .vim $CONFIG_DIR/nvim
ln -sf .vimrc $CONFIG_DIR/nvim/init.vim

#curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

UNAMESTR=`uname`

if [[ "UNAMESTR" == 'Darwin' ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install neovim/neovim/neovim
elif [[ "UNAMESTR" == 'Linux' ]]; then
  sudo apt-get install software-properties-common
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt-get update
  sudo apt-get install neovim
fi
