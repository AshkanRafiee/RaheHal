#!/bin/bash
#made by AshkanRafiee
#github: https://github.com/AshkanRafiee/No-Sanction
echo Enter "y" to turn on / Enter every word but "y" to turn off:
read state

if [ "$state" == "y" ]
then
	sed -i 's/nameserver 94.232.174.194//g' /etc/resolv.conf
	sed -i 's/nameserver 178.22.122.100//g' /etc/resolv.conf
	sed -i '/^$/d' /etc/resolv.conf
	#3 above lines removes existing nameservers if there is any!
	sed -i '1 i\nameserver 94.232.174.194\nnameserver 178.22.122.100' /etc/resolv.conf
	#adds the nameservers
	echo No-Sanction has been turned ON!
else
	sed -i 's/nameserver 94.232.174.194//g' /etc/resolv.conf
	sed -i 's/nameserver 178.22.122.100//g' /etc/resolv.conf
	sed -i '/^$/d' /etc/resolv.conf
	#3 above lines removes existing nameservers if there is any!
	echo No-Sanction has been turned OFF!
fi
read -n1 -r -p "Press any key to continue..."
