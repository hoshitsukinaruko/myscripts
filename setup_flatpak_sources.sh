#!/bin/bash
OSID=$(cat /etc/os-release | egrep ^ID= | tr -d ID=\")
if [[ "$OSID" == "ubuntu" or "$OSID" == "debain" ]]; then
	sudo apt install flatpak
	sudo apt install gnome-software-plugin-flatpak
fi

if [[ "$OSID" == "rhel" or "$OSID" == "rocky" or "$OSID" == "centos" or "$OSID" == "almalinux" ]]; then
	sudo dnf install flatpak
fi

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
