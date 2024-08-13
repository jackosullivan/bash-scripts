#!/bin/bash

# Imports
DOMAINS="https://gist.githubusercontent.com/jackosullivan/271f2ab07bbfc81fbfa3aa737624c53f/raw/2e38efa8623a9c399c233a598716bd94c97acf0a/domainlist"

# Install Nginx
apt update
apt install nginx -y

# Set firewall rule
ufw allow 'Nginx Full'

