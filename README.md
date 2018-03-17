# vimrc
personal vimrc file
for use with Win, Linux and RPi

# Vundle Install Instructions
For Vundle Install Instructions https://github.com/VundleVim/Vundle.vim

## Linux Install
clone Vundle.vim into vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
use personal vimrc file that initializes Vundle and have plugins, place it here:
[destination]: /etc/vim/vimrc
for example: sudo mv home/pi/foldername/vimrc /etc/vim/vimrc
Make sure rtp is correct in vimrc
Launch vim and run :PluginInstall
or Install Vim Plugins from Command Line
vim +PluginInstall +qall

## Windows gVimPortable
Place GVimPortable in C:/
Install Vundle using git into c:/gVimPortable/data/settings/.vim/
(so path will be c:/gVimPortable/data/settings/.vim/bundle/all_packages)
Run as administrator
Make sure rtp is correct in vimrc
Run :PluginInstall in Vim
