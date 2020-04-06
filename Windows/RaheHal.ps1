# PowerShell Script for Laziest People on the Planet!
# Author: Ashkan Rafiee

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
