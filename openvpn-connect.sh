#!/bin/sh

# check if required .htpassword file exists and is readable
if [ ! -r /etc/openvpn/ovpn/.htpasswd ]
then
     echo ERROR: File with username and password not found or not readable
     exit 1
fi

# file path and naming format of NordVPN .ovpn files is:
#   /etc/openvpn/ovpn/bg1.nordvpn.com.udp1194.ovpn
#   /etc/openvpn/ovpn/au14.nordvpn.com.udp1194.ovpn
#   /etc/openvpn/ovpn/de101.nordvpn.com.tcp443.ovpn
# regex pattern of file path and names:
pattern='^(\/etc\/openvpn\/ovpn\/)(([a-z]{2})([0-9]{1,3})\.nordvpn\.com\.(udp|tcp)(1194|443)\.ovpn)$'

while :
do

     # select a random .ovpn file
     ovpn=$(ls /etc/openvpn/ovpn/*.ovpn | shuf -n 1)

     if [[ $ovpn =~ $pattern ]]
     then
          # file matches pattern
          break
     fi

done

# display countrycode, server number, protocol and portnumber
echo Going to open new OpenVPN connection to ${BASH_REMATCH[2]} server numer ${BASH_REMATCH[3]} over ${BASH_REMATCH[4]} though port ${BASH_REMATCH[5]}

# open the connection
openvpn --auth-user-pass /etc/openvpn/ovpn/.htpasswd $ovpn
