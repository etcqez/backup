pkill clash
sudo systemctl start v2raya
#sudo sed -i '$csocks5 127.0.0.1 20170' /etc/proxychains.conf
sudo sed -i '/^socks/csocks5 127.0.0.1 20170' /etc/proxychains.conf
