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
    customOutput "Add Microsoft repo"
fi
prompt -i "Adding Microsoft repo..."
prompt -i "Addin GPG key..."
OSID=$(cat /etc/os-release | egrep ^ID= | tr -d ID=\")
if [[ "$OSID" == "ubuntu" || "$OSID" == "debain" ]]; then
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
fi
prompt -s "GPG key added!"
OSID=$(cat /etc/os-release | egrep ^ID= | tr -d ID=\")
if [[ "$OSID" == "ubuntu" || "$OSID" == "debain" ]]; then
    sudo apt-add-repository "https://packages.microsoft.com/$OSID/$(lsb_release -a | egrep ^Release: | tr -d Release:)/prod"
fi
if [[ "$OSID" == "rhel" || "$OSID" == "rocky" || "$OSID" == "centos" || "$OSID" == "almalinux" ]]; then
    if [[ "$OSID" == "rhel" && "$(rpm -E %rhel)" == 9 ]]; then
        sudo dnf install "https://packages.microsoft.com/config/$OSID/9/packages-microsoft-prod.rpm"
    else
        sudo yum install "https://packages.microsoft.com/config/$OSID/$(rpm -E %rhel)/packages-microsoft-prod.rpm"
    fi
fi
prompt -s "Microsoft repo added!"
