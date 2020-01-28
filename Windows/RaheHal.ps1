# PowerShell Script for Laziest People on the Planet!
# Author: Ashkan Rafiee

$formRaheHal_Load = {
	#Changes The IP Label Texts Based On user's ip
	textchanger	
}

$buttonTurnOnShecan_Click={
	#Turns The Shecan DNS ON!
	Get-NetAdapter | set-DnsClientServerAddress -ServerAddresses ("178.22.122.100", "185.51.200.2")
	$wshell = New-Object -ComObject Wscript.Shell
	$wshell.Popup("Shecan DNS Turned On!", 0, "Successful!", 0x0)
}

$buttonTurnOffShecan_Click={
	#Turns The Shecan DNS OFF!
	Get-NetAdapter | set-DnsClientServerAddress -ResetServerAddresses
	$wshell = New-Object -ComObject Wscript.Shell
	$wshell.Popup("Shecan DNS Turned Off!", 0, "Successful!", 0x0)
}

function textchanger
{
	$iptxt = Start-Job -ScriptBlock $ipscript
	Do { [System.Windows.Forms.Application]::DoEvents() }
	Until ($iptxt.State -eq "Completed")
	$pip.Text = Get-Job | Receive-Job
	$ciptxt = Start-Job -ScriptBlock $cipscript
	Do { [System.Windows.Forms.Application]::DoEvents() }
	Until ($ciptxt.State -eq "Completed")
	$cip.Text = Get-Job | Receive-Job
}

function changeregistery
{
	$regist = Start-Job -ScriptBlock $regscript
	Do { [System.Windows.Forms.Application]::DoEvents() }
	Until ($regist.State -eq "Completed")
}

function removeregistery
{
	$rregist = Start-Job -ScriptBlock $rregscript
	Do { [System.Windows.Forms.Application]::DoEvents() }
	Until ($rregist.State -eq "Completed")
}

$ipscript = {
	Invoke-RestMethod http://ipinfo.io/json | Select -exp ip
}
$cipscript = {
	Invoke-RestMethod http://ipinfo.io/json | Select -exp country
}

$regscript = {
	# Define the HKCR
	New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
	# Define the registry key location
	$location = 'HKCR:\Applications\'
	# For testing I like a clear host :P
	Clear-Host
	
	# Adds that location at the top of the stack
	Push-Location
	Set-Location $location
	
	# Test if the 'photoviewer.dll' key already exists
	if (Test-Path "$location\photoviewer.dll")
	{
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Already Done!", 0, "Error!", 0x0)
		
	}
	else
	{
		
		New-Item -Path "$location" -Name 'photoviewer.dll'
		# If not create new key called shell
		New-Item -Path "$location\photoviewer.dll" -Name 'shell'
		# Create new keys called open and print in shell
		New-Item -Path "$location\photoviewer.dll\shell" -Name 'open'
		New-Item -Path "$location\photoviewer.dll\shell" -Name 'print'
		# Create new keys called command and target in open
		New-Item -Path "$location\photoviewer.dll\shell\open" -Name 'command'
		New-Item -Path "$location\photoviewer.dll\shell\open" -Name 'DropTarget'
		# Create new keys called command and target in print
		New-Item -Path "$location\photoviewer.dll\shell\print" -Name 'command'
		New-Item -Path "$location\photoviewer.dll\shell\print" -Name 'DropTarget'
		# Create new registery files in open folders
		New-ItemProperty -Path "$location\photoviewer.dll\shell\open\command" -Name '(Default)' -Value '%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen %1' -Type ExpandString
		New-ItemProperty -Path "$location\photoviewer.dll\shell\open\DropTarget" -Name 'Clsid' -Value '{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}' -PropertyType String
		# Create new registery files in print folders
		New-ItemProperty -Path "$location\photoviewer.dll\shell\print\command" -Name '(Default)' -Value '%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen %1' -Type ExpandString
		New-ItemProperty -Path "$location\photoviewer.dll\shell\print\DropTarget" -Name 'Clsid' -Value '{60fd46de-f830-4894-a628-6fa81bc0190d}' -PropertyType String
		# Reset back to the original location
		Pop-Location
		
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Operation Completed!", 0, "Successful!", 0x0)
	}
}

$rregscript = {
	# Define the HKCR
	New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
	# Define the registry key location
	$location = 'HKCR:\Applications\'
	# For testing I like a clear host :P
	Clear-Host
	
	# Adds that location at the top of the stack
	Push-Location
	Set-Location $location
	
	# Test if the 'photoviewer.dll' key already exists
	if (Test-Path "$location\photoviewer.dll")
	{
		Remove-Item -Path "$location\photoviewer.dll" -Recurse
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Operation Completed!", 0, "Successful!", 0x0)
	}
	else
	{
		# Reset back to the original location
		Pop-Location
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Already Deleted!", 0, "Error!", 0x0)
	}
}


$buttonWebsite_Click={
	#Opens a Url to RaheHal Website
	Start-Process "https:/AshkanRafiee.ir/RaheHal"
}

$labelMadeByAshkanRafiee_Click={
	#Opens a Url To my Website
	Start-Process "https:/AshkanRafiee.ir/main"
}

$buttonAddWin7PhotoViewerTo_Click={
	#Adds windows 7 photo viewer to openwith list of windows 10
	changeregistery
}

$buttonRemoveWin7PhotoViewe_Click={
	#removes windows 7 photo viewer from openwith list of windows 10
	removeregistery
}
