# Bildschirm leeren
clear

# Script automatisch als Admin ausführen (klappt noch nicht ganz)
# https://www.debinux.de/2014/07/powershell-script-mit-administrativen-rechten-ausfuehren/
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Running elevated..."
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    #break
}

#oder 
#if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Write-host
Write-host 'Prüfe ob das Script mit ADMIN-Rechten ausgeführt wird:'

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] “Administrator”))
{
    Write-Warning 'Fehler: Bitte das Script erneut mit Admninrecht ausführen!'
    Read-Host 'Press any key to exit...'
    exit
}
else
{
    Write-Host -ForegroundColor Green 'OK: Das Script wird mit Adminrechten ausgeführt!'
}
