# Bildschirm leeren
clear

Write-Host
Write-host 'Prüfe ob User "standad" bereits existiert: '

$Password = "Datev001"
$StandardPassword = (convertto-securestring -string $Password -asplaintext -force)

#Prüfen ob der User "standard" schon existiert
if (-not (get-localuser -name "standard" -ErrorAction SilentlyContinue))
{
    #Hier kommt der Teil des Codes rein, der ausgeführt werden soll, wenn der noch nicht existiert
    Write-host -ForegroundColor Green 'OK: Der User "standard" existiert nicht!'
    New-LocalUser -name standard -AccountNeverExpires -Description "ckn Computer default User" -Password $StandardPassword -PasswordNeverExpires -UserMayNotChangePassword

}
else
{
    #Wenn der User schon existiert, wird dieser Teil ausgeführt.
    write-warning 'Der User "standard" existiert'
    Set-LocalUser -Name standard -AccountNeverExpires -Description "ckn Computer default User" -Password $StandardPassword -PasswordNeverExpires $true -UserMayChangePassword $false

}