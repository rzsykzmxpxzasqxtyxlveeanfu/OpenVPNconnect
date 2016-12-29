# OpenVPNconnect

By this script I want to obfuscate online behaviour using the many servers my VPN provider offers.
This script automatically connects to a NordVPN server by randomly selecting a .ovpn file from a directory. It can be used to periodically connect to another VPN server

# Requirements

1) UNIX/Linux and OpenVPN client installed

2) a paid subscription to NordVPN

3) the username and password are stored on separate lines in /etc/openvpn/ovpn/.htpasswd

4) several .ovpn files of the servers of your choice in /etc/openvpn/ovpn

5) a connection to the internet

6) make this script executable: $ chmod +x /etc/openvpn/ovpn/openvpn-connect.sh

7) use cron to reconnect twice a day (e.g. 04:07 and 14:07): $ crontab -e 7 4,14 * * * /etc/openvpn/ovpn/openvpn-connect.sh

8) TODO: root privileges?
