#!/bin/bash

echo "************************"
echo " Update vimrc for VI ..."
echo "************************"
date

# Download the vimrc file
wget https://raw.githubusercontent.com/srosendal/vimrc/master/vimrc

echo "Replacing original vimrc with personal vimrc"
sudo mv vimrc /etc/vim/vimrc
echo "All Done !"
