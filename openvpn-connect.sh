#!/bin/sh

# check if one arguments is given
if [[ $# -eq 1 ]] ; then 

	# argument $1 should contain a two character country code (e.g.: uk, cy, hu, br, in)

	# first, check if a ovpn file exists for the given country code 
	
	# empty array for country codes
	declare -a countries

	# read all file names starting with the country code
	for f in /etc/openvpn/ovpn/$1*.ovpn;
	do
	
		# put two first characters of the filename in array
		countries+="${f:0:2}"
	
	done

	# remove duplicates from array and sort it
	countries="${countries[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '

	# check if lowercase country code entered by user is in array
	if [[ -n "${countries[$1]}" ]]
	then
	
		# use country code in the pattern to search for ovpn files
		pattern='^(\/etc\/openvpn\/ovpn\/)(($1)([0-9]{1,4})\.nordvpn\.com\.(udp|tcp)\.ovpn)$'

		# use country code to select one random ovpv file
		ovpn=$(ls /etc/openvpn/ovpn/$1*.ovpn | shuf -n 1)
	
	else
	
		# no file with country code found
		# print list of available countries
		echo "No VPN server(s) in country $1. Retry with one of these:"
		printf '%s ' "${countries[@]}"
		echo "In the meantime: will connnect to another, random, VPN server"
	
	fi

else

	# regex pattern for ovpn files
	pattern='^(\/etc\/openvpn\/ovpn\/)(([a-z]{2})([0-9]{1,4})\.nordvpn\.com\.(udp|tcp)\.ovpn)$'

	# command to select random file
	ovpn=$(ls /etc/openvpn/ovpn/*.ovpn | shuf -n 1)

fi

while :
do

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
