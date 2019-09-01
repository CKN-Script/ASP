# Bildschirm leeren
clear

# Wenn ' benutzt werden, werden " dargestellt 
Write-host
Write-host 'Prüfe ob aktueller User Migleid der Gruppen "lokale Administratoren" ist: '

# Variablen werden initialisiert:
# "$currentUser" wird mit dem aktuellen Usernamen gefüllt. welches der Befehl "whoami" ausgiebt
# "$isAdmin" wird mit NULL initialisiert um Fehler zu vermeiden, falls es sie schon gibt.
$currentUser = whoami
$isAdmin = $null

# Es wird geprüft ob der aktuelle User Mitglied der lokalen Admin gruppe ist.
# "-ErrorAction SilentlyContinue" unterdrückt die Fehlermeldung, wenn der User NICHT Mitglied ist.
$isAdmin = (Get-LocalGroupMember -Group Administratoren -member $currentUser -ErrorAction SilentlyContinue)

if (-not ($isAdmin))
{Write-warning “Der Aktuelle User ist nicht Mitglied der lokalen Admingruppe”}
else { 
Write-host -ForegroundColor Green “OK: Du bist Admin”
}
