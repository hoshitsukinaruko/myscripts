#!/bin/bash
OSID=$(cat /etc/os-release | egrep ^ID= | tr -d ID=\")
if [ "$OSID" == "ubuntu" || "$OSID" == "debain" ]
	sudo apt install flatpak
	sudo apt install gnome-software-plugin-flatpak
fi

if [ "$OSID" == "rhel" || "$OSID" == "rocky" || "$OSID" == "centos" || "$OSID" == "almalinux" ]
	sudo dnf install flatpak
fi

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
