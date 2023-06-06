#!/bin/bash
function has_command() {
  command -v $1 >/dev/null
}

# CustomOutput
function customOutput {
  figlet -f banner -kc $1 | lolcat
}

# When no figlet and lolcat
# colors
CDEF=" \033[0m"      # default color
CCIN=" \033[0;36m"   # info color
CGSC=" \033[0;32m"   # success color
CRER=" \033[0;31m"   # error color
CWAR=" \033[0;33m"   # warning color
b_CDEF=" \033[1;37m" # bold default color
b_CCIN=" \033[1;36m" # bold info color
b_CGSC=" \033[1;32m" # bold success color
b_CRER=" \033[1;31m" # bold error color
b_CWAR=" \033[1;33m"
# echo like ...  with  flag type  and display message  colors
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

if has_command figlet && has_command lolcat; then
  customOutput "Install flathub repo"
fi
prompt -i "Installing flathub repo..."

OSID=$(cat /etc/os-release | egrep ^ID= | tr -d ID=\")
if [[ "$OSID" == "ubuntu" || "$OSID" == "debain" ]]; then
  sudo apt install flatpak
  sudo apt install gnome-software-plugin-flatpak
fi
if [[ "$OSID" == "rhel" || "$OSID" == "rocky" || "$OSID" == "centos" || "$OSID" == "almalinux" ]]; then
  sudo dnf install flatpak
fi

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

prompt -s "Flathub repo installed..."
