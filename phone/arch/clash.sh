pkill clash
sudo systemctl stop v2raya
clash &
sudo sed -i '$c socks5 127.0.0.1 7891' /etc/proxychains.conf
