#!/bin/bash

# Imports
PUBKEYS="https://gist.github.com/jackosullivan/fe8e65e71003b1ea0e1c1dc04a411b22/raw/7ed12facce13640ff974646a6b83a1272a464461/authorized_keys"

# Create sudo user
useradd -m -d /home/glassportals -s /bin/bash glassportals
usermod -aG sudo glassportals

# Import pubkeys
mkdir -p /home/glassportals/.ssh
curl $PUBKEYS -o /home/glassportals/.ssh/authorized_keys
chown -R glassportals:glassportals /home/glassportals/.ssh

# Configure and enable firewall
ufw allow OpenSSH
ufw enable

# Update ubuntu
apt update
apt upgrade -y
apt autoremove -y
apt clean -y
