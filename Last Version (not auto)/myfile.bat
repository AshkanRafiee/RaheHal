@ECHO OFF

:choice
set /P c=Rahe Halle Dast Saze Ashkan Roshan Bashe ?[Y/N]?
if /I "%c%" EQU "Y" goto :somewhere
if /I "%c%" EQU "N" goto :somewhere_else
goto :choice


:somewhere

netsh interface ipv4 set dns "Ethernet" static 178.22.122.100
echo "Roshan Shod"
pause 
exit

:somewhere_else

netsh interface ipv4 set dns "Ethernet" dhcp
echo "Khamush Shod"
pause 
exit