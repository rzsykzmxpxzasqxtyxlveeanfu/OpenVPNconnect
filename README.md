# OpenVPNconnect
By default, a VPN is conenction is opened from a client to a server and the connection remains. By this script I want to obfuscate online behaviour using the many servers VPN providers offer. This script automatically, periodically connects to a VPN server by randomly selecting a .ovpn file from a directory.

# Context

This script is one several measures to protect online privacy. Other measures I use include blocking of ads, trackers, malware, social media, using Pi-hole (https://pi-hole.net/, https://github.com/pi-hole/pi-hole), the use of DD-WRT on routers (http://dd-wrt.com/), several browser plugins, obfuscation (https://mitpress.mit.edu/books/obfuscation), etc.

# Requirements

1) UNIX/Linux and OpenVPN client installed

2) a paid subscription to a paid VPN provider (in the script NordVPN is used. Select the VPN provider for your needs here https://thatoneprivacysite.net/vpn-comparison-chart/)

3) the username and password are stored on separate lines in /etc/openvpn/ovpn/.htpasswd

4) several .ovpn files of the servers of your choice in /etc/openvpn/ovpn

5) a connection to the internet

6) make this script executable: $ chmod +x /etc/openvpn/ovpn/openvpn-connect.sh

7) use cron to reconnect twice a day (e.g. 04:07 and 14:07): $ crontab -e 7 4,14 * * * /etc/openvpn/ovpn/openvpn-connect.sh

8) TODO: root privileges?
