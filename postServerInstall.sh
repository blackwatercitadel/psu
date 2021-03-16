#!/bin/bash

# Add to any script to prommpt if NOT running as root (sudo)
# if [[ $EUID -ne 0 ]]; then
#   echo "This script must be run as root" 1>&2
#   exit 1
# fi

# Automatically runs this file as root (sudo)
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

# 5 second wait
function pause() {
    sleep 5
}

# create an empty cloud-init.disabled file
function cloud-init() {
    touch /etc/cloud/cloud-init.disabled
}

# change time
function timezone()
{
  timedatectl set-timezone America/New_York
}

# update and upgrade system
function update() {
    apt update && pause && apt full-upgrade -y && pause && apt autoremove -y && pause && apt clean -y && pause && apt autoclean -y
}

# install net-tools
function net-tools() {
    apt install ifupdown net-tools
}

# disable UFW
function ufw-disable() {
    ufw disable && ufw --force reset
}

# Block all incoming traffic
function ufw-deny-incoming() {
    ufw default deny incoming
}

# Allow all outgoing traffic
function ufw-allow-outgoing() {
    ufw default allow outgoing
}

# Allow Incoming SSH from Specific IP Address
# sudo ufw allow from 192.168.1.1 to any port 22 proto tcp
# Allow Incoming SSH from Specific IP Subnet (change to match current subnet)
function ufw-allow-ssh() {
    ufw allow from 192.168.1.0/24 to any port 22 proto tcp
}

# Enable UFW
function ufw-enable() {
    echo "y" | ufw enable
}

# Disable PermitRootLogin in /etc/ssh/sshd_config
function ssh-disable-root-login() {
    sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
}

# Deny the root user in etc/ssh/sshd_config
function ssh-deny-users-root() {
    echo "DenyUsers root" >> /etc/ssh/sshd_config
}

# Restart the ssh service
function ssh-restart() {
    systemctl restart sshd
}

# reboot the system
function reboot()
{
  shutdown --reboot 1
}

echo -e "\e[31;43m***** DISABLING CLOUD-INIT *****\e[0m"
cloud-init
pause
echo ""

echo -e "\e[31;43m***** CHANGING TIMEZONE *****\e[0m"
timezone
pause
echo ""

echo -e "\e[31;43m***** UPDATING SYSTEM *****\e[0m"
update
pause
echo ""

echo -e "\e[31;43m***** INSTALLING NET-TOOLS *****\e[0m"
net-tools
pause
echo ""

echo -e "\e[31;43m***** DISABLING UFW *****\e[0m"
ufw-disable
pause
echo ""

echo -e "\e[31;43m***** UFW DENY ALL INCOMING *****\e[0m"
ufw-deny-incoming
pause
echo ""

echo -e "\e[31;43m***** UFW ALLOW ALL OUTGOING *****\e[0m"
ufw-allow-outgoing
pause
echo ""

echo -e "\e[31;43m***** UFW ALLOW SSH *****\e[0m"
ufw-allow-ssh
pause
echo ""

echo -e "\e[31;43m***** ENABLING UFW *****\e[0m"
ufw-enable
pause
echo ""

echo -e "\e[31;43m***** SSH DISABLE ROOT LOGIN *****\e[0m"
ssh-disable-root-login
pause
echo ""

echo -e "\e[31;43m***** SSH DENY USERS ROOT *****\e[0m"
ssh-deny-users-root
pause
echo ""

echo -e "\e[31;43m***** RESTARTING SSH SERVICE *****\e[0m"
ssh-restart
pause
echo ""

echo -e "\e[31;43m***** REBOOTING SYSTEM *****\e[0m"
reboot