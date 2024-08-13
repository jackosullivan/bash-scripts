#!/bin/bash

# Install Nginx
apt update
apt install nginx -y

# Set firewall rule
ufw allow 'Nginx Full'
