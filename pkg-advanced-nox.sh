#!/bin/bash
echo "Installing advanced packages... "
#sudo apt-get -y install aptitude p7zip-rar firmware-linux-nonfree
#sudo apt-get -y install p7zip-rar firmware-linux-nonfree
sudo apt-get -y install p7zip-rar

#echo "Installing windows fs packages... "
#sudo apt-get -y ntfs-3g ntfs-config dosfsutils

#echo "Installing smart card packages... "
sudo apt-get -y install smartmontools pcsc-tools
