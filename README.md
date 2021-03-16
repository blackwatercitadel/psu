# psu

PostServer update tested on Ubuntu 20.04.

This script will perform some post install tasks in just a few seconds.

# Usage
First, download the script and make it executable:

curl -O https://raw.githubusercontent.com/nicholasgraffagnino/psu/main/postServerInstall.sh</br>
chmod +x postServerInstall.sh

Then run it:

./postServerInstall.sh

When launched the script will automatically elevate to root (sudo).

DISABLE CLOUD-INIT</br>
CHANGE TIMEZONE to America/New_York</br>
COMPLETE SYSTEM UPDATE</br>
INSTALL IFUPDOWN & NET-TOOLS</br>
DISABLE & RESET UFW</br>
DENY ALL INCOMING UFW</br>
ALLOW ALL OUTGOING UFW</br>
ALLOW SSH PORT 22 ONLY FROM 192.168.1.0/24</br>
ENABLE UFW</br>
DISABLE SSH ROOT LOGIN</br>
ADD ROOT TO DENY USERS IN SSHD.CONFIG</br>
RESTART SSH SERVICE</br>
REBOOT SYSTEM
