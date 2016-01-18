#!/bin/bash

## firstboot.sh
## Install necessary packages and scripts for new Raspbian installations.

echo -e "Running raspi-firstboot\nUpgrading system..."


echo "Installing utilities..."

packages = weavedconnectd x11vnc vim fbi sendmail


sudo weavedinstaller

echo "Disabling X Server"

echo "Adding Administrative User"
sudo adduser nicole
sudo passwd nicole
sudo echo "nicole ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

echo "Disabling \"pi\" User from remote access"
sudo echo "DenyUsers pi" >> /etc/ssh/sshd_config
sudo service sshd restart

## The following tools are specific for the slideshow utility most of my raspi units will be running 24/7
echo "Installing slideshow utility"
mkdir -vp /home/pi/Pictures/slides
echo "alias slideshow='sudo killall fbi && sudo /usr/bin/fbi -T 1 -a -noverbose -u -t 25 /home/pi/Pictures/slides/*'" >> /home/nicole/.bashrc
sudo echo '@reboot sudo /usr/bin/fbi -T 1 -a -noverbose -u -t 25 /home/pi/Pictures/slides/*' >> /var/spool/cron/crontabs/pi 
sudo service cron restart

echo -e "Done!\n\nRebooting in 5 seconds..."
sleep 5
sudo reboot
