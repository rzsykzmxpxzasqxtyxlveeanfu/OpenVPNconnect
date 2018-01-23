# OpenVPNconnect

By default, a VPN is conenction is opened from a client to a server and the connection remains. With this script I want to obfuscate online behaviour using the many servers VPN providers offer. This script automatically, periodically connects to a VPN server by randomly selecting a .ovpn file from a directory.

# Context

This script is one several measures to protect online privacy. Other measures I use include blocking of ads, trackers, malware, social media, using [Pi-hole](https://pi-hole.net/), the use of [DD-WRT](http://dd-wrt.com/) on routers, several browser plugins, [obfuscation](https://github.com/rzsykzmxpxzasqxtyxlveeanfu/Obfuscator/), etc.

# Requirements

* UNIX/Linux and OpenVPN client installed
* a paid subscription to a paid VPN provider (in the script NordVPN is used. Use the [VPN comparison chart](https://thatoneprivacysite.net/vpn-comparison-chart/) to select the provider for your needs)
* the username and password are stored on separate lines in `/etc/openvpn/ovpn/auth.txt`. Set permissions to `-r-x——` or similar
* several `.ovpn` files of the servers of your choice in `/etc/openvpn/ovpn`
* in the ovpn files, the `auth-user-file` directive must point to the `auth.txt` file. Example how to edit them all at once:
```
 $ sed -i 's/auth-user-file/auth-user-file \/etc\/openvpn\/ovpn\/auth\.txt/g' *ovpn
```
* a connection to the internet
* make this script executable:
```
$ chmod +x /etc/openvpn/ovpn/openvpn-connect.sh
```
* use cron to reconnect twice a day (e.g. 04:07 and 14:07):
```
$ crontab -e 7 4,14 * * * /etc/openvpn/ovpn/openvpn-connect.sh
```
* TODO: root privileges?
