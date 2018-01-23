#!/bin/sh

# path to file with username and password, both on their own line
auth='/etc/openvpn/ovpn/auth.txt'

# check if required auth.txt file exists and is readable
if [ ! -r $auth ]
then
     echo ERROR: File with username and password not found or not readable
     exit 1
fi

# auth file is passed as an argument in the .ovpn files, not in this script
# all NordVPN .ovpn files must me edited, you can use this command:
#       $ sed -i 's/auth-user-file/auth-user-file \/etc\/openvpn\/ovpn\/auth\.txt/g' *ovpn

# file path and naming format of NordVPN .ovpn files is:
#   /etc/openvpn/ovpn/bg1.nordvpn.com.udp.ovpn
#   /etc/openvpn/ovpn/au14.nordvpn.com.udp.ovpn
#   /etc/openvpn/ovpn/de101.nordvpn.com.tcp.ovpn
#   /etc/openvpn/ovpn/us1024.nordvpn.tcp.ovpn
# regex pattern of file path and names:
pattern='^(\/etc\/openvpn\/ovpn\/)(([a-z]{2})([0-9]{1,4})\.nordvpn\.com\.(udp|tcp)\.ovpn)$'

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

# display date/time, countrycode, server number and protocol
echo `date '+%c'` Opening new OpenVPN connection to ${BASH_REMATCH[3]^^} server ${BASH_REMATCH[4]} over ${BASH_REMATCH[5]^^}

# open the connection, prevent output messages and keep it running
openvpn --config $ovpn &>/dev/null &disown;

exit
