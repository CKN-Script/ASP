# Bildschirm leeren
clear

Write-Host
Write-host 'Prüfe ob User "standad" bereits existiert: '

#Prüfen ob der User "standard" schon existiert
if (-not (get-localuser -name "standard" -ErrorAction SilentlyContinue))
{
    #Hier kommt der Teil des Codes rein, der ausgeführt werden soll, wenn der noch nicht existiert
    Write-host -ForegroundColor Green 'OK: Der User "standard" existiert nicht!'
}
else
{
    #Wenn der User schon existiert, wird dieser Teil ausgeführt.
    write-warning 'Der User "standard" existiert'
}