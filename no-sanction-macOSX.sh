#!/bin/bash
#made by AshkanRafiee
#github: https://github.com/AshkanRafiee/No-Sanction
echo "enter y/n to turn on/off No-Sanction:"
read state
if [ "$state" == "y" ]
then
networksetup -setdnsservers Wi-Fi 178.22.122.100 94.232.174.194
#sudo discoveryutil mdnsflushcache #deprecated
sudo killall -HUP mDNSResponder; sleep 1;
echo "No-Sanction has been turned on Successfully!"
else
networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4 
#sudo discoveryutil mdnsflushcache #deprecated
sudo killall -HUP mDNSResponder; sleep 1;
echo "No-Sanction has been turned off Successfully!"
fi
read -n1 -r -p "Press any key to continue..."
clear
exit
