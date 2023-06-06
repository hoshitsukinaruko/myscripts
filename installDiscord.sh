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
    customOutput "Install Discord"
fi
prompt -i "Installing Discord..."

prompt -i "Installing dependencies..."
OSID=$(cat /etc/os-release | egrep ^ID= | tr -d ID=\")
if [[ "$OSID" == "ubuntu" || "$OSID" == "debain" ]]; then
    apt install -y libc6
    apt install -y libasound2
    apt install -y libatomic1
    apt install -y libgconf-2-4
    apt install -y libnotify4
    apt install -y libnspr4
    apt install -y libnss3
    apt install -y libstdc++6
    apt install -y libxss1
    apt install -y libxtst6
    apt install -y libappindicator1
    apt install -y libc++1
    prompt -s "Dependencies installed..."
    curl -sLo discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
    apt install -y ./discord.deb
    rm discord.deb
fi

if [[ "$OSID" == "rhel" || "$OSID" == "rocky" || "$OSID" == "centos" || "$OSID" == "almalinux" ]]; then
    dnf install -y libatomic
    dnf install -y glibc
    dnf install -y alsa-lib
    dnf install -y GConf2
    dnf install -y libnotify
    dnf install -y nspr
    dnf install -y nss
    dnf install -y libstdc++
    dnf install -y libX11
    dnf install -y libXtst
    dnf install -y libappindicator
    dnf install -y libcxx
    dnf install -y libXScrnSaver
    prompt -s "Dependencies installed..."
    curl -sLo discord.tar.gz "https://discordapp.com/api/download?platform=linux&format=tar.gz"
    tar -xvzf discord.tar.gz -C /opt
    mkdir -p /usr/share/discord
    ln -sf /opt/Discord/Discord /usr/share/discord/Discord
    sed -i -e "s/^Icon=discord/Icon=discord.png/" /opt/Discord/discord.desktop
    cp -r /opt/Discord/discord.desktop /usr/share/applications
    rm discord.tar.gz
fi

prompt -s "Discord installed!"
