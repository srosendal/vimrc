#!/bin/bash

# 1. Clone this repository using
# git clone https://github.com/srosendal/vimrc.git /home/pi/vimsettings/

# 2. Make sure all paths in this file are correct, ie. /home/pi/ <-
# Also that paths in the donwloaded vimrc are correct, for Vundle: rtp

# 3. Make sure this file is executable with: chmod u+x vi_setup.sh

# 4. Run this file with ./vi_setup.sh

# 5. Run VI

echo "*******************************"
echo " Create New Settings for VI ..."
echo "*******************************"
date

echo "Remove Vim-Tiny"
sudo apt-get remove --auto-remove vim-tiny
echo "Done !"

echo "Install VIM"
sudo apt-get install vim -y
echo "Done !"

echo "Download personal vimrc repository into /home/pi/vimsettings/"
git clone https://github.com/srosendal/vimrc.git /home/pi/vimsettings/
echo "Done !"

# Or download just the vimrc file using wget
# https://raw.githubusercontent.com/srosendal/vimrc/master/vimrc

echo "Cloning Vundle.vim into vim ..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Done !"

echo "Replacing original vimrc with personal vimrc"
sudo mv /home/pi/vimsettings/vimrc /etc/vim/vimrc
echo "Done !"

#For Ubuntu: sudo mv /home/sro/etc/vim/vimrc/vimrc /usr/share/vim/vimfiles/vimrc

# Make sure rtp is correct in vimrc, for Ubuntu, set rtp to:
# rtp+=~/.vim/bundle/Vundle.vim

echo "Install Plugins"
vim +PluginInstall +qall
echo "Done !"

echo "Clean folders"
sudo rm -rf /home/pi/vimsettings
echo "All Done !"
