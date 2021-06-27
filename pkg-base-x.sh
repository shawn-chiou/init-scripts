#!/bin/bash
echo "Installing basic X packages... "
#sudo apt-get -y install xfonts-terminus lxterminal pcmanfm suckless-tools blueman p7zip-rar
#sudo apt-get -y install xfonts-terminus pcmanfm suckless-tools guake
sudo apt-get -y install xfonts-terminus yakuake

#echo "Installing internet packages... "
#sudo apt-get -y install filezilla

echo "Installing multimedia packages... "
#sudo apt-get -y install gpicview guvcview audacious
sudo apt-get -y install gpicview guvcview

echo "Installing remote connect client packages... "
sudo apt-get -y install xtightvncviewer rdesktop

echo "Removing unnecessary packages... "
sudo apt-get -y autoremove
