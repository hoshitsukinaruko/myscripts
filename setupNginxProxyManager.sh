#!/bin/bash
echo "Setting up Podman"
sudo dnf install podman podman-compose -y
if grep -Fxq "net.ipv4.ip_unprivileged_port_start=80" /etc/sysctl.conf
then
    echo "Podman setup complete"
    echo "Setting up Nginx Proxy Manager"
    mkdir -p /opt/nginx-proxy-manager
    cd /opt/nginx-proxy-manager
    curl https://raw.githubusercontent.com/naruko-hstk/my-scripts/master/nginx-proxy-manager/docker-compose.yml -o docker-compose.yml
    podman-compose up -d
    echo "Nginx Proxy Manager setup complete"
    echo "Setting up automatic startup when system boot"
    podman generate systemd --new --name npm_app_1 -f
    mv container-npm_app_1.service ~/.config/systemd/user/
    systemctl --user daemon-reload
    systemctl --user enable SERVICE_NAME.service
    echo "Automatic startup setup complete"
    echo "Now you can restart system and check your proxy manager at http://localhost:81"
else
    echo "net.ipv4.ip_unprivileged_port_start=80" >> /etc/sysctl.conf
    echo "Please restart system and run this script again"
fi

