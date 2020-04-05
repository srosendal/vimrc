#!/bin/bash

# Make sure this file is executable with: chmod u+x vi_setup.sh
# Run this file with ./vimrc_update.sh

echo "************************"
echo " Update vimrc for VI ..."
echo "************************"
date

# Download the latest vimrc file from github
wget https://raw.githubusercontent.com/srosendal/vimrc/master/vimrc

# Replace vimrc file
echo "Replacing original vimrc with personal vimrc"
sudo mv vimrc /etc/vim/vimrc
echo "All Done !"
