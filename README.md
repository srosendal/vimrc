# vimrc
personal vimrc file for use with Win, Linux and RPi

# Vundle Install Instructions
For Vundle Install Instructions https://github.com/VundleVim/Vundle.vim

## Linux Install
1. clone Vundle.vim into vim
2. git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
3. use personal vimrc file that initializes Vundle and have plugins, place it here:
4. destination: /etc/vim/vimrc
5. replace vimrc file, for example: sudo mv home/pi/foldername/vimrc /etc/vim/vimrc
6. for Ubuntu: sudo mv /home/sro/etc/vim/vimrc/vimrc /usr/share/vim/vimfiles/vimrc
7. Make sure rtp is correct in vimrc
8. for Ubuntu: set rtp+=~/.vim/bundle/Vundle.vim
9. Launch vim and run :PluginInstall
10. or Install Vim Plugins from Command Line
11. vim +PluginInstall +qall

## Windows gVimPortable
1. Place GVimPortable in C:/
2. Install Vundle using git into c:/gVimPortable/data/settings/.vim/
3. path will be c:/gVimPortable/data/settings/.vim/bundle/all_packages
4. Run as administrator
5. Make sure rtp is correct in vimrc
6. Run :PluginInstall in Vim
