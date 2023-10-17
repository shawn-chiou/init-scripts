#!/usr/bin/bash

echo "update repo & upgrade installed packages..."
pamac update --no-confirm && pamac upgrade --no-confirm

echo "install packages for base / minimal purpose..."
pamac install --no-confirm vim git make cmake cscope ctags

echo "install packages for openvpn"
pamac install --no-confirm networkmanager-openvpn

echo "install packages for desktop purpose..."
pamac install --no-confirm rdesktop chromium telegram-desktop signal-desktop \
	wqy-zenhei wqy-bitmapfont ttf-arphic-uming ttf-arphic-ukai ttf-font-awesome \
	fcitx5-table-extra fcitx5-qt fcitx5-gtk fcitx5-chinese-addons fcitx5-configtool \

echo "install & initialize for docker..."
pamac install --no-confirm docker docker-compose
systemctl enable docker.service && systemctl start docker.service
usermod -aG docker $USER 

#echo "install & initialize for QEMU/KVM..."
#pamac install --no-confirm virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat
#systemctl enable libvirtd.service && \
#	systemctl start libvirted.service && \
#	virsh net-autostart --network default && \
#	virsh net-start default
#usermod -aG libvirtd $USER 
