# Bildschirm leeren
clear

Write-host
Write-host 'Prüfe ob das Script mit ADMIN-Rechten ausgeführt wird:'

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] “Administrator”))
{
    Write-Warning 'Fehler: Bitte das Script erneut mit Admninrecht ausführen!'
    Read-Host 'Press any key to exit...'
    exit
}
else
{
    Write-Host -ForegroundColor Green 'OK: Das Script wird mit Adminrechten ausgeführt!'
}
