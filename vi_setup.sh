#!/bin/bash

# 1. Clone this repository. Make sure the path is correct, for example:
git clone https://github.com/srosendal/vimrc.git ~/vimsettings/
# git clone https://github.com/srosendal/vimrc.git /home/pi/vimsettings/
# git clone https://github.com/srosendal/vimrc.git /home/ubuntu/vimsettings/

# 2. Make sure all paths in this ./vi_setup.sh file are correct, ie. /home/pi/ <-

# 3. Make sure all paths in vimrc are correct for Vundle plugin path: rtp

# 4. Make sure this file is executable with: chmod u+x vi_setup.sh

# 5. Run this file with ./vi_setup.sh

# 6. Run VI

echo "*******************************"
echo " Create New Settings for VI ..."
echo "*******************************"
date

echo "updating ..."
sudo apt-get update

echo "upgrading ..."
sudo apt-get upgrade -y

echo "Remove Vim-Tiny"
sudo apt-get remove --auto-remove vim-tiny
echo "Done !"

echo "Remove Vim-Tiny"
sudo apt-get remove --auto-remove vim
echo "Done !"

echo "Re-Install VIM"
sudo apt install vim-gtk -y
# sudo apt-get install vim -y
echo "Done !"

echo "Download personal vimrc repository into ~/vimsettings/"
git clone https://github.com/srosendal/vimrc.git ~/vimsettings/
echo "Done !"

# Or download just the vimrc file using wget
# wget https://raw.githubusercontent.com/srosendal/vimrc/master/vimrc

echo "Cloning Vundle.vim into vim ..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Done !"

echo "Replacing original vimrc with personal vimrc"
sudo mv ~/vimsettings/vimrc /etc/vim/vimrc
echo "Done !"

# Alternatively, for Ubuntu: sudo mv /home/sro/etc/vim/vimrc/vimrc /usr/share/vim/vimfiles/vimrc

# Make sure rtp is correct in vimrc, for Ubuntu, set rtp to:
# rtp+=~/.vim/bundle/Vundle.vim

echo "Installing Plugins"
vim +PluginInstall +qall
echo "Done !"

echo "Cleaning folders"
sudo rm -rf ~/vimsettings
echo "All Done !"
