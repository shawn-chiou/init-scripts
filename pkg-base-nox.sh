#!/bin/bash
echo "Installing basic packages... "
sudo apt-get -y install vim-nox tmux

echo "Installing internet packages... "
#sudo apt-get -y install sshfs cifs-utils curl
sudo apt-get -y install curl

echo "Installing development packages... "
sudo apt-get -y install git git-flow make cmake

echo "Removing unnecessary packages... "
sudo apt-get -y autoremove
