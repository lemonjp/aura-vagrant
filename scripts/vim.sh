#!/usr/bin/env bash

# Set up Vim environment
echo "dotfile install"
cd ~/
git clone https://github.com/lemonjp/dotfiles.git
sh -x ./dotfiles/setup.sh
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo "set up vim env"
vim +BundleInstall +qall
cd ~/.vim/bundle/vimproc/
make -f make_unix.mak
cd ~/.vim/bundle/nerdtree/nerdtree_plugin
wget https://gist.github.com/lemonjp/2558f5cc63bcd347024b/raw/9e4f07818da3e9f98797710a9e78fd0d08ad79dc/grep_menuitem.vim

