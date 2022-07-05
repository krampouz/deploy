<# 
1. Lancer PowerShell en administrateur

2. PS c:\...> Set-ExecutionPolicy RemoteSigned
3. PS c:\...> Invoke-WebRequest https://frama.link/deploy2001 -OutFile C:\informatique\deploy.ps1
4. PS c:\...> C:\informatique\deploy.ps1

#>


Set-PSDebug -Trace 1
<# Groupe de travail APAJH 22-29-35 et nom ordinateur#>

Add-Computer -WorkGroupName "APAJH 22-29-35"

Rename-Computer


<# Services de telemetrie - supprime si service existe #>
Set-Service -Name DiagTrack -StartupType Disabled
Set-Service -Name dmwappushservice -StartupType Disabled
Set-Service -Name WerSvc -StartupType Disabled
Set-Service -Name dmwappushsvc -StartupType Disabled

<# Activation du SMB1 #>
Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All

<# Télémetrie #>
echo "" > C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-DiagTrack-Listener.etl
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemtery /t REG_DWORD /d 0 /f

<# Premiere connexion - Pas de questions aux utilisateurs#>
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /F
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v PreventFirstRunPage /t REG_DWORD /d 1 /F
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_SZ /d 1 /F

<# Réactivation de l'option CTRL+ALT+SUPPR #>
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableCAD /t REG_DWORD /d 0 /F

<# Sécurisation veille #>
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveActive /t REG_DWORD /d 1 /F
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /v ScreenSaverIsSecure /t REG_SZ /d 1 /F
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /v ScreenSaveTimeOut /t REG_SZ /d 900 /F
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d scrnsave.scr /F
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d C:\Windows\system32\scrnsave.scr /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v InactivityTimeoutSecs /t REG_SZ /d 900 /F


<# Désactivation du contrôle utilisateur #>
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_SZ /d 0 /F

<# Google GCPW #>

$domainsAllowedToLogin = "apajh22-29-35.org"

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework


function Is-Admin() {
$admin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match 'S-1-5-32-544')
return $admin
}

<# Check if the current user is an admin and exit if they aren't. #>
if (-not (Is-Admin)) {
$result = [System.Windows.MessageBox]::Show('Il faut utiliser un compte ADMIN!', 'GCPW', 'OK', 'Erreur')
exit 5
}

<# Choose the GCPW file to download. 32-bit and 64-bit versions have different names #>
$gcpwFileName = 'gcpwstandaloneenterprise.msi'
if ([Environment]::Is64BitOperatingSystem) {
$gcpwFileName = 'gcpwstandaloneenterprise64.msi'
}

<# Download the GCPW installer. #>
$gcpwUrlPrefix = 'https://dl.google.com/credentialprovider/'
$gcpwUri = $gcpwUrlPrefix + $gcpwFileName
Write-Host 'Telechagement GCPW depuis' $gcpwUri
Invoke-WebRequest -Uri $gcpwUri -OutFile $gcpwFileName

<# Run the GCPW installer and wait for the installation to finish #>
$arguments = "/i `"$gcpwFileName`""
$installProcess = (Start-Process msiexec.exe -ArgumentList $arguments -PassThru -Wait)

<# Check if installation was successful #>
if ($installProcess.ExitCode -ne 0) {
$result = [System.Windows.MessageBox]::Show('Installation plantee!', 'GCPW', 'OK', 'Erreur')
exit $installProcess.ExitCode
}
else {
$result = [System.Windows.MessageBox]::Show('Installation terminee avec succes!', 'GCPW', 'OK', 'Info')
}

<# Set the required registry key with the allowed domains #>
$registryPath = 'HKEY_LOCAL_MACHINE\Software\Google\GCPW'
$name = 'domains_allowed_to_login'
[microsoft.win32.registry]::SetValue($registryPath, $name, $domainsAllowedToLogin)

$domains = Get-ItemPropertyValue HKLM:\Software\Google\GCPW -Name $name

if ($domains -eq $domainsAllowedToLogin) {
$msgResult = [System.Windows.MessageBox]::Show('Configuration OK!', 'GCPW', 'OK', 'Info')
}
else {
$msgResult = [System.Windows.MessageBox]::Show('La base de registre est en lecture seule. Configuration KO.', 'GCPW', 'OK', 'Erreur')

}


reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Google\GCPW" /v enable_multi_user_login /t REG_DWORD /d 1 /F
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Google\GCPW" /v enable_dm_enrollment /t REG_DWORD /d 0 /F




<# openshell 4_4_142 #>
Invoke-WebRequest -Uri "https://github.com/Open-Shell/Open-Shell-Menu/releases/download/v4.4.142/OpenShellSetup_4_4_142.exe" -OutFile "c:\informatique\OpenShellSetup_4_4_142.exe"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "c:\informatique\OpenShellSetup_4_4_142.exe" -ArgumentList "/quiet"
<# Lancement GPEDIT #>

Invoke-WebRequest -Uri "https://github.com/krampouz/deploy/blob/master/screensave.png" -OutFile "c:\informatique\screensave.png"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

<# TELEMETRY WDP #>
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile "c:\informatique\WPD.zip"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Expand-Archive -Path c:\informatique\WPD.zip c:\informatique\
Start-Process -FilePath "c:\informatique\WPD.exe"


<# Fusion inventory 2.5.2 #>
Invoke-WebRequest -Uri "https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.5.2/fusioninventory-agent_windows-x64_2.5.2.exe" -OutFile "c:\informatique\fi252.exe"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "c:\informatique\fi252.exe" -ArgumentList "/acceptlicense /runnow /server='https://intranet.apajh22-29-35.org/glpi/plugins/fusioninventory/' /S /no-ssl-check /add-firewall-exception /execmode=service /installtype=from-scratch"


<# DW Agent #>
Invoke-WebRequest -Uri "https://www.dwservice.net/download/dwagent_x86.exe" -OutFile "c:\informatique\dwagent_x86.exe"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "c:\informatique\dwagent_x86.exe"


<# INFORMATION ORDI + génération rapport html#>



Get-CimInstance -ClassName Win32_ComputerSystem


#CSS codes
$header = @"
<style>
    h1 {
        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;
    }
    h2 {
        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;
    }
   table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}
    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }
    #CreationDate {
        font-family: Arial, Helvetica, sans-serif;
        color: #ff3300;
        font-size: 12px;
    }
    .StopStatus {
        color: #ff0000;
    }
    .RunningStatus {
        color: #008000;
    }
</style>
"@
#The command below will get the name of the computer
$ComputerName = "<h1>NOM ORDI: $env:computername</h1>"
#The command below will get the Operating System information, convert the result to HTML code as table and store it to a variable
$OSinfo = Get-CimInstance -Class Win32_OperatingSystem | ConvertTo-Html -As List -Property Version,Caption,BuildNumber,Manufacturer -Fragment -PreContent "<h2>OS Information</h2>"

#The command below will get the Processor information, convert the result to HTML code as table and store it to a variable
$ProcessInfo = Get-CimInstance -ClassName Win32_Processor | ConvertTo-Html -As List -Property DeviceID,Name,Caption,MaxClockSpeed,SocketDesignation,Manufacturer -Fragment -PreContent "<h2>Processeur Information</h2>"

#The command below will get the BIOS information, convert the result to HTML code as table and store it to a variable
$BiosInfo = Get-CimInstance -ClassName Win32_BIOS | ConvertTo-Html -As List -Property SMBIOSBIOSVersion,Manufacturer,Name,SerialNumber -Fragment -PreContent "<h2>BIOS Information</h2>"

#The command below will get the details of Disk, convert the result to HTML code as table and store it to a variable
$DiscInfo = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | ConvertTo-Html -As List -Property DeviceID,DriveType,ProviderName,VolumeName,Size,FreeSpace -Fragment -PreContent "<h2>Disk Information</h2>"

#The command below will get first 10 services information, convert the result to HTML code as table and store it to a variable
$ServicesInfo = Get-CimInstance -ClassName Win32_Service | Select-Object -First 10  |ConvertTo-Html -Property Name,DisplayName,State -Fragment -PreContent "<h2>Services Information</h2>"
$ServicesInfo = $ServicesInfo -replace '<td>Running</td>','<td class="RunningStatus">Running</td>'
$ServicesInfo = $ServicesInfo -replace '<td>Stopped</td>','<td class="StopStatus">Stopped</td>'

  
#The command below will combine all the information gathered into a single HTML report
$Report = ConvertTo-HTML -Body "$ComputerName $OSinfo $ProcessInfo $BiosInfo $DiscInfo $ServicesInfo" -Head $header -Title "Computer Information Report" -PostContent "<p id='CreationDate'>Date Edition: $(Get-Date)</p>"

#The command below will generate the report to an HTML file
$Report | Out-File c:\informatique\Basic-Ordi-Rapport.html
Start-Process "c:\informatique\Basic-Ordi-Rapport.html"

<# Reboot ordi #>
#Restart-Computer -confirm

<# parametres veille ecran pour tous les utilisateurs #>
start-process gpedit
start shell:AppsFolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge https://raw.githubusercontent.com/krampouz/deploy/master/screensave.png

<# Pave numerique active #>
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 2 /F

