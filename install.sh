#!/usr/bin/env bash
# Author: AshkanRafiee - https://github.com/AshkanRafiee/

currentVersion="1.5"
prefix="/usr/local"

install()
{
	read -p "M for Mac, L For Linux or C to Cancel [Mm/Ll/Cc]: " answer
	answer=${answer:-C}

  	if [[ "$answer" == [Mm] ]]; then
    	echo -n "Installing No-Sanction: "
    	chmod a+x MacOSX/no-sanction
    	cp MacOSX/no-sanction $prefix/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
    	echo "Success"
	elif [[ "$answer" == [Ll] ]]; then
    	echo -n "Installing No-Sanction: "
    	chmod a+x Linux/no-sanction
    	cp Linux/no-sanction $prefix/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
    	echo "Success"
	elif [[ "$answer" == [Cc] ]]; then
		echo -n "Installation Canceled!"
	else
		echo -n "Use The Following Options: "
		echo -n "M for Mac, L For Linux or C to Cancel!"
	fi
}
install
exit 0