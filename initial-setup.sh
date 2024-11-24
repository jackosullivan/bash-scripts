#!/bin/bash

# Imports
PUBKEYS="https://gist.githubusercontent.com/jackosullivan/fe8e65e71003b1ea0e1c1dc04a411b22/raw/a10c897668ee58b04f5c0e51cc811284eed5415d/authorized_keys"
USER="jackosullivan" # This is an example user, never use this.
# Create sudo user
useradd -m -d /home/$USER -s /bin/bash $USER
usermod -aG sudo $USER
passwd -d $USER

# Import pubkeys
mkdir -p /home/$USER/.ssh
curl -L $PUBKEYS -o /home/$USER/.ssh/authorized_keys
chown -R $USER:$USER /home/$USER/.ssh

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
sudo -u $USER sh -c "git clone https://github.com/jackosullivan/bash-scripts.git /home/$USER/scripts"
