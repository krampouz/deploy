<#************************************************************************************************************************************

SCRIPT POWERSHELL DEPLOY.PS1

**************************************************************************************************************************************#>

<# Pour executer le script = <strong>Set-ExecutionPolicy RemoteSigned #>

Set-PSDebug -Trace 1

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
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /v ScreenSaverIsSecure /t REG_DWORD /d 1 /F
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /v ScreenSaveTimeOut /t REG_DWORD /d 900 /F
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d scrnsave.scr /F
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d C:\Windows\system32\scrnsave.scr /f


<# Désactivation du contrôle utilisateur #>
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_SZ /d 0 /F

<# Google GCPW #>
Invoke-WebRequest -Uri "https://dl.google.com/credentialprovider/gcpwstandaloneenterprise64.msi" -OutFile "c:\informatique\GCPW.msi"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "c:\informatique\GCPW.msi"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Google\GCPW" /v domains_allowed_to_login /t REG_SZ /d apajh22-29-35.org /F
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Google\GCPW" /v enable_multi_user_login /t REG_DWORD /d 1 /F
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Google\GCPW" /v enable_dm_enrollment /t REG_DWORD /d 0 /F

<# Drive File Stream #>
Invoke-WebRequest -Uri "https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.5.2/fusioninventory-agent_windows-x64_2.5.2.exe" -OutFile "c:\informatique\fi252.exe"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "c:\informatique\fi252.exe" -ArgumentList "/acceptlicense /runnow /server='http://intranet.apajh22-29-35.org/glpi/plugins/fusioninventory/' /S /no-ssl-check /add-firewall-exception /execmode=service /installtype=from-scratch"

<# openshell 4_4_142 #>
Invoke-WebRequest -Uri "https://github.com/Open-Shell/Open-Shell-Menu/releases/download/v4.4.142/OpenShellSetup_4_4_142.exe" -OutFile "c:\informatique\OpenShellSetup_4_4_142.exe"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "c:\informatique\OpenShellSetup_4_4_142.exe" -ArgumentList "/quiet"


<# TELEMETRY WDP #>
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile "c:\informatique\WPD.zip"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Expand-Archive -Path c:\informatique\WPD.zip c:\informatique\
Start-Process -FilePath "c:\informatique\WPD.exe"


<# Fusion inventory 2.5.2 #>
Invoke-WebRequest -Uri "https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.5.2/fusioninventory-agent_windows-x64_2.5.2.exe" -OutFile "c:\informatique\fi252.exe"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "c:\informatique\fi252.exe" -ArgumentList "/acceptlicense /runnow /server='http://intranet.apajh22-29-35.org/glpi/plugins/fusioninventory/' /S /no-ssl-check /add-firewall-exception /execmode=service /installtype=from-scratch"


<# DW Agent #>
Invoke-WebRequest -Uri "https://www.dwservice.net/download/dwagent_x86.exe" -OutFile "c:\informatique\dwagent_x86.exe"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
Start-Process -FilePath "c:\informatique\dwagent_x86.exe"

