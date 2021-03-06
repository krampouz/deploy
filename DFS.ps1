    $caption = "Voulez-vous installer Drive File Stream?"    
    $message = "Saisir 'Y' pour installer DFS"
    [int]$defaultChoice = 0
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Installer"
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Continuer"
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $choiceRTN = $host.ui.PromptForChoice($caption,$message, $options,$defaultChoice)

if ( $choiceRTN -ne 1 )
{
   function Install-DFS
{
$LocalTempDir = $env:TEMP; 
    $ChromeInstaller = "DFS.exe"; 
    $url='https://dl.google.com/drive-file-stream/GoogleDriveFSSetup.exe'; 
    $output="$LocalTempDir\$DFSInstaller"

    try {
        (new-object    System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/silent","/install" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$DFSInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}
Install-DFS
}
else
{
   "Le Script Continue"
}
