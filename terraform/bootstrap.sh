#!/bin/bash

# Update system and install required packages
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y shadowsocks-libev

# Configure iptables to allow port 8388
sudo iptables -I INPUT -p tcp --dport 8388 -j ACCEPT
sudo iptables -I INPUT -p udp --dport 8388 -j ACCEPT
# drop below lines
# sudo iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited
# sudo iptables -D FORWARD -j REJECT --reject-with icmp-host-prohibited


# Save iptables rules
sudo netfilter-persistent save
sudo netfilter-persistent reload
sudo iptables-restore < /etc/iptables/rules.v4

# Create Shadowsocks configuration file
cat <<EOF | sudo tee /etc/shadowsocks-libev/config.json
{
    "server": "0.0.0.0",
    "mode":"tcp_and_udp",
    "server_port": 8388,
    "password": "${shadowsocks_password}",
    "timeout": 18000,
    "method":"chacha20-ietf-poly1305"
}
EOF

# Start Shadowsocks-libev service
sudo systemctl enable shadowsocks-libev
sudo systemctl start shadowsocks-libev

# Confirm service is running
sudo systemctl status shadowsocks-libev

# !!! restart after iptable runs 
sudo systemctl restart shadowsocks-libev

# Print success message
echo "Shadowsocks-libev installed and started successfully with password: ${shadowsocks_password}."

