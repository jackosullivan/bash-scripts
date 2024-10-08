#!/bin/bash

# Imports
PUBKEYS="https://gist.github.com/jackosullivan/fe8e65e71003b1ea0e1c1dc04a411b22/raw/7ed12facce13640ff974646a6b83a1272a464461/authorized_keys"

# Create sudo user
useradd -m -d /home/glassportals -s /bin/bash glassportals
usermod -aG sudo glassportals
passwd -d glassportals

# Import pubkeys
mkdir -p /home/glassportals/.ssh
curl -L $PUBKEYS -o /home/glassportals/.ssh/authorized_keys
chown -R glassportals:glassportals /home/glassportals/.ssh

# Disable SSH root login & disable SSH password authentication
sed -i '/^PermitRootLogin[ \t]\+\w\+$/{ s//PermitRootLogin no/g; }' /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Configure and enable firewall
ufw allow OpenSSH
ufw --force enable

# Update ubuntu
apt update
apt upgrade -y
apt autoremove -y
apt clean -y

# Pull down bash-scripts repo
sudo -u glassportals sh -c "git clone https://github.com/jackosullivan/bash-scripts.git /home/glassportals/scripts"