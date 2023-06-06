#!/bin/bash
# colors
CDEF=" \033[0m" # default color
CCIN=" \033[0;36m" # info color
CGSC=" \033[0;32m" # success color
CRER=" \033[0;31m" # error color
CWAR=" \033[0;33m" # warning color
b_CDEF=" \033[1;37m" # bold default color
b_CCIN=" \033[1;36m" # bold info color
b_CGSC=" \033[1;32m" # bold success color
b_CRER=" \033[1;31m" # bold error color
b_CWAR=" \033[1;33m"
# echo like ... with flag type	and display message	colors
prompt() {
		case ${1} in
	"-s" | "--success")
		echo -e "${b_CGSC}${@/-s/}${CDEF}"
		;; # print success message
	"-e" | "--error")
		echo -e "${b_CRER}${@/-e/}${CDEF}"
		;; # print error message
	"-w" | "--warning")
		echo -e "${b_CWAR}${@/-w/}${CDEF}"
		;; # print warning message
	"-i" | "--info")
		echo -e "${b_CCIN}${@/-i/}${CDEF}"
		;; # print info message
	*)
		echo -e "$@"
		;;
	esac
}

prompt -i "Checking os version..."

if [ "$(rpm -E %rhel)" == 8 ]; then
	OSID=$(cat /etc/os-release | egrep ^ID= | tr -d ID=\")
	if [[ "$OSID" == "rhel" ]]; then
		prompt -i "Need to enable codeready"
		subscription-manager repos --enable "codeready-builder-for-rhel-8-$(uname -m)-rpms"
	else
		prompt -i "Need to enable powertools"
		dnf config-manager --enable PowerTools
	fi
else
	OSID=$(cat /etc/os-release | egrep ^ID= | tr -d ID=\")
	if [[ "$OSID" == "rhel" ]]; then
		prompt -i "Need to enable codeready"
		subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
	else
		prompt -i "Need to enable crb"
		dnf config-manager --set-enabled crb
	fi
fi
prompt -s "os checked!"
if [ $(cat /etc/os-release | egrep ^NAME= | tr -d NAME=\") == "CentOS Stream" ]; then
	prompt -i "Installing EPEL Next"
	dnf install --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-$(rpm -E %rhel).noarch.rpm -y
	prompt -s "EPEL Next installed"
fi
prompt -i "Installing EPEL"
dnf install --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm -y
prompt -s "EPEL installed"
prompt -i "Installing RPM Fusion"
dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm -y
prompt -s "RPM Fusion installed"
