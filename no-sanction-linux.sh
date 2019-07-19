#!/bin/bash
#made by AshkanRafiee
#github: https://github.com/AshkanRafiee/No-Sanction
dialog --backtitle "No-Sanction" \
       --title "Active/Deactive" \
       --yesno "\nTurn On/Off?\n yes=On  no=Off" 8 30
if [ "$?" == "0" ]
then
	sed -i 's/nameserver 185.51.200.2//g' /etc/resolv.conf
	sed -i 's/nameserver 178.22.122.100//g' /etc/resolv.conf
	sed -i '/^$/d' /etc/resolv.conf
	#3 above lines removes existing nameservers if there is any!
	sed -i '1 i\nameserver 94.232.174.194\nnameserver 178.22.122.100' /etc/resolv.conf
	#adds the nameservers
	dialog --title "Sucessful!" --msgbox 'No-Sanction has been turned ON!' 6 30
else
	sed -i 's/nameserver 185.51.200.2//g' /etc/resolv.conf
	sed -i 's/nameserver 178.22.122.100//g' /etc/resolv.conf
	sed -i '/^$/d' /etc/resolv.conf
	#3 above lines removes existing nameservers if there is any!
	dialog --title "Sucessful!" --msgbox 'No-Sanction has been turned OFF!' 6 30
fi
clear
exit
