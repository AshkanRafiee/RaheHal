# PowerShell Script for Laziest People on the Planet!
# Author: Ashkan Rafiee


function Show-RaheHal_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formRaheHal = New-Object 'System.Windows.Forms.Form'
	$dnstatus = New-Object 'System.Windows.Forms.Label'
	$labelDNSCurrentStatus = New-Object 'System.Windows.Forms.Label'
	$buttonRefresh = New-Object 'System.Windows.Forms.Button'
	$buttonRemoveWin7PhotoViewe = New-Object 'System.Windows.Forms.Button'
	$labelRaheHalForLaziestPeo = New-Object 'System.Windows.Forms.Label'
	$pip = New-Object 'System.Windows.Forms.Label'
	$cip = New-Object 'System.Windows.Forms.Label'
	$labelPublicIP = New-Object 'System.Windows.Forms.Label'
	$labelCountry = New-Object 'System.Windows.Forms.Label'
	$labelMadeByAshkanRafiee = New-Object 'System.Windows.Forms.Label'
	$buttonWebsite = New-Object 'System.Windows.Forms.Button'
	$buttonAddWin7PhotoViewerTo = New-Object 'System.Windows.Forms.Button'
	$buttonTurnOffShecan = New-Object 'System.Windows.Forms.Button'
	$buttonTurnOnShecan = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$formRaheHal_Load = {
		#Changes The IP Label Texts Based On user's ip
		textchanger	
	}
	
	$buttonTurnOnShecan_Click={
		#Turns The Shecan DNS ON!
		Get-NetAdapter | set-DnsClientServerAddress -ServerAddresses ("178.22.122.100", "185.51.200.2")
		textchanger
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Shecan DNS Turned On!", 0, "Successful!", 0x0)
	}
	
	$buttonTurnOffShecan_Click={
		#Turns The Shecan DNS OFF!
		Get-NetAdapter | set-DnsClientServerAddress -ResetServerAddresses
		textchanger
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
		$statustext = Start-Job -ScriptBlock $statuscript
		Do { [System.Windows.Forms.Application]::DoEvents() }
		Until ($statustext.State -eq "Completed")
		$dnstatus.Text = Get-Job | Receive-Job
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
	
	$statuscript = {
		$dnlist = Get-DnsClientServerAddress | Select-Object -ExpandProperty ServerAddresses
		if ($dnslist -contains "178.22.122.100" -or $dnlist -contains "185.51.200.2")
		{
			return "ON"
		}
		else
		{
			return "Off"
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
	
	$buttonRefresh_Click={
		#Refresh IP and Country data
		textchanger
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formRaheHal.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonRefresh.remove_Click($buttonRefresh_Click)
			$buttonRemoveWin7PhotoViewe.remove_Click($buttonRemoveWin7PhotoViewe_Click)
			$labelMadeByAshkanRafiee.remove_Click($labelMadeByAshkanRafiee_Click)
			$buttonWebsite.remove_Click($buttonWebsite_Click)
			$buttonAddWin7PhotoViewerTo.remove_Click($buttonAddWin7PhotoViewerTo_Click)
			$buttonTurnOffShecan.remove_Click($buttonTurnOffShecan_Click)
			$buttonTurnOnShecan.remove_Click($buttonTurnOnShecan_Click)
			$formRaheHal.remove_Load($formRaheHal_Load)
			$formRaheHal.remove_Load($Form_StateCorrection_Load)
			$formRaheHal.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formRaheHal.SuspendLayout()
	#
	# formRaheHal
	#
	$formRaheHal.Controls.Add($dnstatus)
	$formRaheHal.Controls.Add($labelDNSCurrentStatus)
	$formRaheHal.Controls.Add($buttonRefresh)
	$formRaheHal.Controls.Add($buttonRemoveWin7PhotoViewe)
	$formRaheHal.Controls.Add($labelRaheHalForLaziestPeo)
	$formRaheHal.Controls.Add($pip)
	$formRaheHal.Controls.Add($cip)
	$formRaheHal.Controls.Add($labelPublicIP)
	$formRaheHal.Controls.Add($labelCountry)
	$formRaheHal.Controls.Add($labelMadeByAshkanRafiee)
	$formRaheHal.Controls.Add($buttonWebsite)
	$formRaheHal.Controls.Add($buttonAddWin7PhotoViewerTo)
	$formRaheHal.Controls.Add($buttonTurnOffShecan)
	$formRaheHal.Controls.Add($buttonTurnOnShecan)
	$formRaheHal.AutoScaleDimensions = '6, 13'
	$formRaheHal.AutoScaleMode = 'Font'
	$formRaheHal.BackColor = 'Info'
	$formRaheHal.ClientSize = '472, 421'
	#region Binary Data
	$formRaheHal.Icon = [System.Convert]::FromBase64String('
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
AABJRU5ErkJggg==')
	#endregion
	$formRaheHal.Name = 'formRaheHal'
	$formRaheHal.Text = 'RaheHal'
	$formRaheHal.add_Load($formRaheHal_Load)
	#
	# dnstatus
	#
	$dnstatus.AutoSize = $True
	$dnstatus.Location = '289, 46'
	$dnstatus.Name = 'dnstatus'
	$dnstatus.Size = '23, 17'
	$dnstatus.TabIndex = 13
	$dnstatus.Text = 'N/A'
	$dnstatus.UseCompatibleTextRendering = $True
	#
	# labelDNSCurrentStatus
	#
	$labelDNSCurrentStatus.AutoSize = $True
	$labelDNSCurrentStatus.Location = '176, 46'
	$labelDNSCurrentStatus.Name = 'labelDNSCurrentStatus'
	$labelDNSCurrentStatus.Size = '107, 17'
	$labelDNSCurrentStatus.TabIndex = 12
	$labelDNSCurrentStatus.Text = 'DNS Current Status:'
	$labelDNSCurrentStatus.UseCompatibleTextRendering = $True
	#
	# buttonRefresh
	#
	$buttonRefresh.Location = '228, 307'
	$buttonRefresh.Name = 'buttonRefresh'
	$buttonRefresh.Size = '188, 38'
	$buttonRefresh.TabIndex = 11
	$buttonRefresh.Text = 'Refresh'
	$buttonRefresh.UseCompatibleTextRendering = $True
	$buttonRefresh.UseVisualStyleBackColor = $True
	$buttonRefresh.add_Click($buttonRefresh_Click)
	#
	# buttonRemoveWin7PhotoViewe
	#
	$buttonRemoveWin7PhotoViewe.Location = '49, 237'
	$buttonRemoveWin7PhotoViewe.Name = 'buttonRemoveWin7PhotoViewe'
	$buttonRemoveWin7PhotoViewe.Size = '367, 51'
	$buttonRemoveWin7PhotoViewe.TabIndex = 10
	$buttonRemoveWin7PhotoViewe.Text = 'Remove Win7 Photo Viewer from Win10 Open-With List'
	$buttonRemoveWin7PhotoViewe.UseCompatibleTextRendering = $True
	$buttonRemoveWin7PhotoViewe.UseVisualStyleBackColor = $True
	$buttonRemoveWin7PhotoViewe.add_Click($buttonRemoveWin7PhotoViewe_Click)
	#
	# labelRaheHalForLaziestPeo
	#
	$labelRaheHalForLaziestPeo.AutoSize = $True
	$labelRaheHalForLaziestPeo.Location = '129, 20'
	$labelRaheHalForLaziestPeo.Name = 'labelRaheHalForLaziestPeo'
	$labelRaheHalForLaziestPeo.Size = '225, 17'
	$labelRaheHalForLaziestPeo.TabIndex = 9
	$labelRaheHalForLaziestPeo.Text = 'RaheHal For Laziest People On The Planet!'
	$labelRaheHalForLaziestPeo.UseCompatibleTextRendering = $True
	#
	# pip
	#
	$pip.AutoSize = $True
	$pip.Location = '51, 328'
	$pip.Name = 'pip'
	$pip.Size = '67, 17'
	$pip.TabIndex = 8
	$pip.Text = '***.***.***.***'
	$pip.UseCompatibleTextRendering = $True
	#
	# cip
	#
	$cip.AutoSize = $True
	$cip.Location = '157, 328'
	$cip.Name = 'cip'
	$cip.Size = '44, 17'
	$cip.TabIndex = 7
	$cip.Text = '*********'
	$cip.UseCompatibleTextRendering = $True
	#
	# labelPublicIP
	#
	$labelPublicIP.AutoSize = $True
	$labelPublicIP.Location = '51, 307'
	$labelPublicIP.Name = 'labelPublicIP'
	$labelPublicIP.Size = '52, 17'
	$labelPublicIP.TabIndex = 6
	$labelPublicIP.Text = 'Public IP:'
	$labelPublicIP.UseCompatibleTextRendering = $True
	#
	# labelCountry
	#
	$labelCountry.AutoSize = $True
	$labelCountry.Location = '157, 307'
	$labelCountry.Name = 'labelCountry'
	$labelCountry.Size = '47, 17'
	$labelCountry.TabIndex = 5
	$labelCountry.Text = 'Country:'
	$labelCountry.UseCompatibleTextRendering = $True
	#
	# labelMadeByAshkanRafiee
	#
	$labelMadeByAshkanRafiee.AutoSize = $True
	$labelMadeByAshkanRafiee.Location = '170, 396'
	$labelMadeByAshkanRafiee.Name = 'labelMadeByAshkanRafiee'
	$labelMadeByAshkanRafiee.Size = '125, 17'
	$labelMadeByAshkanRafiee.TabIndex = 4
	$labelMadeByAshkanRafiee.Text = 'Made By Ashkan Rafiee'
	$labelMadeByAshkanRafiee.UseCompatibleTextRendering = $True
	$labelMadeByAshkanRafiee.add_Click($labelMadeByAshkanRafiee_Click)
	#
	# buttonWebsite
	#
	$buttonWebsite.Location = '184, 352'
	$buttonWebsite.Name = 'buttonWebsite'
	$buttonWebsite.Size = '99, 29'
	$buttonWebsite.TabIndex = 3
	$buttonWebsite.Text = 'Website'
	$buttonWebsite.UseCompatibleTextRendering = $True
	$buttonWebsite.UseVisualStyleBackColor = $True
	$buttonWebsite.add_Click($buttonWebsite_Click)
	#
	# buttonAddWin7PhotoViewerTo
	#
	$buttonAddWin7PhotoViewerTo.Location = '49, 180'
	$buttonAddWin7PhotoViewerTo.Name = 'buttonAddWin7PhotoViewerTo'
	$buttonAddWin7PhotoViewerTo.Size = '367, 51'
	$buttonAddWin7PhotoViewerTo.TabIndex = 2
	$buttonAddWin7PhotoViewerTo.Text = 'Add Win7 Photo Viewer to Win10 Open-With List'
	$buttonAddWin7PhotoViewerTo.UseCompatibleTextRendering = $True
	$buttonAddWin7PhotoViewerTo.UseVisualStyleBackColor = $True
	$buttonAddWin7PhotoViewerTo.add_Click($buttonAddWin7PhotoViewerTo_Click)
	#
	# buttonTurnOffShecan
	#
	$buttonTurnOffShecan.Location = '237, 66'
	$buttonTurnOffShecan.Name = 'buttonTurnOffShecan'
	$buttonTurnOffShecan.Size = '179, 108'
	$buttonTurnOffShecan.TabIndex = 1
	$buttonTurnOffShecan.Text = 'Turn off Shecan'
	$buttonTurnOffShecan.UseCompatibleTextRendering = $True
	$buttonTurnOffShecan.UseVisualStyleBackColor = $True
	$buttonTurnOffShecan.add_Click($buttonTurnOffShecan_Click)
	#
	# buttonTurnOnShecan
	#
	$buttonTurnOnShecan.Location = '49, 66'
	$buttonTurnOnShecan.Name = 'buttonTurnOnShecan'
	$buttonTurnOnShecan.Size = '182, 108'
	$buttonTurnOnShecan.TabIndex = 0
	$buttonTurnOnShecan.Text = 'Turn on Shecan'
	$buttonTurnOnShecan.UseCompatibleTextRendering = $True
	$buttonTurnOnShecan.UseVisualStyleBackColor = $True
	$buttonTurnOnShecan.add_Click($buttonTurnOnShecan_Click)
	$formRaheHal.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formRaheHal.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formRaheHal.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formRaheHal.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $formRaheHal.ShowDialog()

} #End Function

#Call the form
Show-RaheHal_psf | Out-Null
