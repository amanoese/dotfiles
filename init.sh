#/bin/bash

set -euC

ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.gvimrc ~/.gvimrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.vim/vimSwap ~/.vim/vimBackUp ~/.vim/undo

if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then \
  bash ./wsl_init.sh
fi
