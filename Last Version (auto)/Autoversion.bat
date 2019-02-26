@echo off

color 2
echo                             #############################################
echo                             #   Welcome To "No Sanction" Application!   #
echo                             #           Made By Ashkan Rafiee           #
echo                             #############################################
echo +                                                                                                      +
:choice
set /P c=Enter The Appropriate Hotkey(help="h", Ping="p", Shecan ON/OFF="y/n", Your External IP ="i", Exit ="x"):
if /I "%c%" EQU "Y" goto :DNSON
if /I "%c%" EQU "N" goto :DNSOFF
if /I "%c%" EQU "P" goto :PING
if /I "%c%" EQU "IP" goto :IP
if /I "%c%" EQU "I" goto :IP
if /I "%c%" EQU "HELP" goto :HELP
if /I "%c%" EQU "H" goto :HELP
if /I "%c%" EQU "C" goto :COPYRIGHT
if /I "%c%" EQU "X" goto :EXIT
goto :choice

:DNSON
(for /f "tokens=3* delims= " %%a in ('netsh Interface show interface ^|find /I "Connected"') do echo %%b) > temp.txt
for /F "tokens=*" %%F in (temp.txt) DO (netsh interface ipv4 set dns "%%F" static 94.232.174.194)
echo "Shecan Turned ON!"
del /f temp.txt
pause
cls
goto :choice

:DNSOFF
(for /f "tokens=3* delims= " %%a in ('netsh Interface show interface ^|find /I "Connected"') do echo %%b) > temp.txt
for /F "tokens=*" %%F in (temp.txt) DO (netsh interface ipv4 set dns "%%F" dhcp)
echo "Shecan Turned Off!"
del /f temp.txt
pause
cls
goto :choice

:PING
ping cloudflare.com
pause
cls
goto :choice

:IP
curl ifconfig.co
curl ifconfig.co/country
pause
cls
goto :choice

:HELP
echo DNS ON/OFF = "Y/N"
echo Ping cloudflare = "P"
echo Your External IP = "IP"
echo Exit = "X"
echo Contact Me: "AshkanRafiee@protonmail.com"
pause
cls
goto :choice

:COPYRIGHT
echo All Rights Reserved To "Ashkan Rafiee"
pause
cls
goto :choice

:EXIT
exit