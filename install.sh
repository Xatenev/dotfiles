#!/bin/bash

#Install VimPlug (Dependency Manager)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#Install vimrc
wget https://raw.githubusercontent.com/Xatenev/x-settings/master/.vimrc;

#Move vimrc into the correct folder
mv .vimrc ~/.vimrc;

#Install vim plugins
vim +PlugInstall

