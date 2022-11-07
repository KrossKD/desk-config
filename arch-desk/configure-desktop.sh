#!/bin/bash
#This script does the following:
#Installs all applications listed in a file on GitHub 
#Installs QTile and downloads custom configuration from GitHub
#Installs the sxhkd and downloads custom configuration

#This is meant to run on a clean Arch installation

pwd=$(pwd)
echo "Creating temporary folders"
mkdir config-temp && cd config-temp

echo "Cloning configuration repository"
git clone https://github.com/KrossKD/desk-config.git

#Update System before installation
echo "Updating system"
#sudo pacman -Su

#Installing Apps
echo "Fetching required applications list"
#cat desk-config/arch-desk/req-apps.txt
appslist="desk-config/arch-desk/req-apps.txt"
echo "Installing applications"
#while read line; 
#do echo "Installing: $line";
#sudo pacman -Sq $line; 
#done < $appslist

#Check if Qtile has been installed
echo "Checking for qtile package"
if !(sudo pacman -Qi qtile > /dev/null); then
echo "DISABLED Installing QTile because it's not in app list.";
#sudo pacman -Su qtile
fi

echo "Updating qtile configuration"
qtileconf="desk-config/arch-desk/qtile-config.py"
cp $qtileconf ~/.config/qtile/config1.py

echo "Updating autostart script"
qtileauto="desk-config/arch-desk/qtile-autostart.sh"
cp $qtileauto ~/.config/qtile/scripts/autostart1.sh

#Check if sxhkd has been installed
echo "Checking for sxhkd (Hotkey Daemon) package"
if !(sudo pacman -Qi sxhkd > /dev/null); then
echo "DISABLED Installing sxhkd because it's not in app list.";
#sudo pacman -Su sxhkd
fi

echo "Updating sxhkd configuration"
sxhkdconf="desk-config/arch-desk/sxhkd-config.txt"
cp $sxhkdconf ~/.config/qtile/sxhkd/sxhkdrc1

#cleaning up
echo "Cleaning and removing temporary folders"
cd "$pwd"
rm -rf config-temp
exit 0

