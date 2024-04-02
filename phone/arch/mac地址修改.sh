#!/usr/bin/bash
sudo ip link set wlan0 down
sudo systemctl stop NetworkManager
sudo ip link set wlan1 down
# sudo macchanger -m cc:cc:cc:cc:cc:dd wlan1
sudo macchanger -r wlan1
sudo systemctl start NetworkManager
