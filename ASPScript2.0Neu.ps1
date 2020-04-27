#-------------------------------------------------------------------------------------------------------------------
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green '                                                  Das ASP Script von CKN'
Write-host -ForegroundColor Green '                                                       Scripted by:     '
Write-host -ForegroundColor Green '                                                     Jens Steinhäuser   '
Write-host -ForegroundColor Green '                                                      Martin Barthel    '
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
#-------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stellen werden Powershell spezifische Einstellungen vorgenommen
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle wird die Scriptausführung für den aktuellen User erlaubt
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
#An diser Stelle werden die die Powershell Help Dateien aktualisiert
    Update-Help -UICulture En-US -Force -ErrorAction SilentlyContinue

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stellen werden die Kundenspezifischen Einstellungen in Variablen hinterlegt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$Kundenkennung = "l30"
$Kundenname = "Hopp"
$Kundennummer = "17576#Ckn"
$Password = "Datev001"
$WTSIPAdresse = "10.178.30.11"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle werden Einstellungen im Windows Eventlog vorgenommen
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle die ckn-Computer Sorce im Anwandgs Eventlog angelegt
#https://www.msxfaq.de/code/powershell/pseventlog.htm
New-EventLog -LogName "cknComputer" -Source "ASPUmstellungsScript2.0" -ErrorAction SilentlyContinue

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird der für ckn PartnerASP vorgegebenen User STANDARD auf den lokalen PCs eingerichtet
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser stelle wird eine Variable erzeugt die das Kennwort für Administrator in einen SecurityString umwandelt
$StandardPassword = (convertto-securestring -string $Password -asplaintext -force)
#Prüfen ob der User "standard" schon existiert
if (-not (get-localuser -name "standard" -ErrorAction SilentlyContinue))
{
    Write-host -ForegroundColor Green "OK: Der User Standard existiert nicht! Er wird nun angelegt."
    Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der User Standard existiert nicht! Er wird nun angelegt."

# An dieser Stelle wird der User Standard neu angelegt.
# Es wird eingestellt das, das Benutzerkonto nie abläuft
# Es wird die Beschreibung "ckn Computer default User" im User hinterlegt
# Das Kennwort wird über die Variable $StandardPassword eingetragen
# Der Schalter "Kennwort läuft nie ab" im User wird gesetzt
# Der Schalter "Benutzer kann Kennwort nicht Ã¤ndern" im User wird gesetzt
    New-LocalUser -name standard -AccountNeverExpires -Description "ckn Computer default User" -Password $StandardPassword -PasswordNeverExpires -UserMayNotChangePassword -ErrorAction SilentlyContinue
}
else
{
    write-warning "Der User Standard ist bereits vorhanden und wird nun Modifiziert"
    Write-EventLog -EntryType Warning -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "Der User Standard ist bereits vorhanden und wird nun Modifiziert"

# An dieser Stelle werden für den User Standard diverse Einstellungen gesetzt wenn er schon vorhanden ist
# Es wird eingestellt das, das Benutzerkonto nie abläuft
# Das Kennwort wird über die Variable $StandardPassword eingetragen
# Der Schalter "Kennwort läuft nie ab" im User wird gesetzt
# Der Schalter "Benutzer kann Kennwort nicht ändern" im User wird gesetzt
    Set-LocalUser -Name standard -AccountNeverExpires -Description "ckn Computer default User" -Password $StandardPassword -PasswordNeverExpires 1 -UserMayChangePassword 0 -ErrorAction SilentlyContinue

# An dieser Stelle wird der User Standard aktiviert wenn er deaktiviert sein sollte
    Write-host -ForegroundColor Green "OK: Der User Standard wird nun aktiviert"
    Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der User Standard wird nun aktiviert"
    Enable-LocalUser -Name standard -ErrorAction SilentlyContinue
}
#An dieser Stelle wird der User Standard der lokalen Gruppe Benutzer hinzugefügt
write-host -ForegroundColor Green "OK: Der User Standard wird der lokalen Gruppe Benutzer hinzugefügt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der User Standard wird der lokalen Gruppe Benutzer hinzugefügt"
Add-LocalGroupMember -Group Benutzer -Member standard -ErrorAction SilentlyContinue

#An dieser Stelle wird der User Standard aus der lokalen Gruppe Administratoren entfernt
write-host -ForegroundColor Green "OK: Der User Standard wird aus der lokalen Gruppe Administratoren entfernt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der User Standard wird aus der lokalen Gruppe Administratoren entfernt"
Remove-LocalGroupMember -Group Administratoren -Member standard -ErrorAction SilentlyContinue

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird der für ckn partnerASP vorgegebenen User ADMINISTRATOR auf den lokalen PCs eingerichtet
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser stelle wird eine Variable erzeugt die das Kennwort für Administrator in einen SecurityString umwandelt
$AdminPassword = (convertto-securestring -string $Kundennummer -asplaintext -force)
if (-not (get-localuser -name "Administrator" -ErrorAction SilentlyContinue))
{
    Write-host -ForegroundColor Green "OK: Der User Administrator existiert nicht! Er wird nun angelegt."
    Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der User Administrator existiert nicht! Er wird nun angelegt."

#An dieser Stelle wird der User Administrator neu angelegt.
#Es wird eingestellt das, das Benutzerkonto nie abläuft
#Es wird die Beschreibung "ckn Computer default User" im User hinterlegt
#Das Kennwort wird über die Variable $StandardPassword eingetragen
#Der Schalter "Kennwort läuft nie ab" im User wird gesetzt
#Der Schalter "Benutzer kann Kennwort nicht ändern" im User wird gesetzt
    New-LocalUser -name Administrator -AccountNeverExpires -Description "ckn Computer Admin User" -Password $AdminPassword -PasswordNeverExpires -UserMayNotChangePassword -ErrorAction SilentlyContinue
}
else
{
    write-warning "Der User Administrator ist bereits vorhanden und wird nun Modifiziert"
    Write-EventLog -EntryType Warning -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "Der User Administrator ist bereits vorhanden und wird nun Modifiziert"

#An dieser Stelle werden für den User Administrator diverse Einstellungen gesetzt wenn er schon vorhanden ist
#Es wird eingestellt das, das Benutzerkonto nie abläuft
#Das Kennwort wird über die Variable $StandardPassword eingetragen
#Der Schalter "Kennwort läuft nie ab" im User wird gesetzt
#Der Schalter "Benutzer kann Kennwort nicht ändern" im User wird gesetzt
    Set-LocalUser -Name Administrator -AccountNeverExpires -Description "ckn Computer Admin User" -Password $AdminPassword -PasswordNeverExpires $true -UserMayChangePassword $false -ErrorAction SilentlyContinue

#An dieser Stelle wird der User Administrator aktiviert wenn er deaktiviert sein sollte
    Write-host -ForegroundColor Green "OK: Der User Administrator wird nun aktiviert"
    Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der User Administrator wird nun aktiviert"
    Enable-LocalUser -Name Administrator -ErrorAction SilentlyContinue
}
#An dieser Stelle wird der User Administrator der lokalen Gruppe Administratoren hinzugefügt
write-host -ForegroundColor Green "OK: Der User Administrator wird der lokalen Gruppe Administratoren hinzugefügt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der User Administrator wird der lokalen Gruppe Administratoren hinzugefügt"
Add-LocalGroupMember -Group Administratoren -Member Administrator -ErrorAction SilentlyContinue

#An dieser Stelle wird der User Administrator aus der lokalen Gruppe Benutzer entfernt
write-host -ForegroundColor Green "OK: Der User Administrator wird aus der lokalen Gruppe Benutzer entfernt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der User Administrator wird aus der lokalen Gruppe Benutzer entfernt"
Remove-LocalGroupMember -Group Benutzer -Member Administrator -ErrorAction SilentlyContinue
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle werden Computer Allgemeine Kopiervorgänge durchgeführt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle wird ein Installationsverzeichnis kopiert und das ckn Softwarepaket kopiert
#https://www.itslot.de/2019/02/poweshell-ordner-und-unterordner.html
write-host -ForegroundColor Green "OK: Die Allgemeinen Installationsdaten werden kopiert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Die Allgemeinen Installationsdaten werden kopiert"
Copy-Item "Gemeinsam\Allgemein" -Destination "c:\Install\" -Recurse

#An dieser Stelle wird das Kundenspezifische Softwarepaket kopiert
write-host -ForegroundColor Green "OK: Die Kundenspezifischen Installationsdaten werden kopiert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Die Kundenspezifischen Installationsdaten werden kopiert"
Copy-Item "Kunden\$Kundenname\" -Destination "c:\Install\" -Recurse

#An dieser Stelle wird die ckn Teamviewer Verknüpfung auf den All-Users Desktiop kopiert
write-host -ForegroundColor Green "OK: Das TeamViewer Icon wird auf den Desktop kopiert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Das TeamViewer Icon wird auf den Desktop kopiert"
Copy-Item "C:\Install\ckn-TeamViewer.lnk" -Destination "c:\users\public\desktop\ckn-TeamViewer.lnk"

#An dieser Stelle wird das Programm ShowInfo in den All-Users AutoStart kopiert
write-host -ForegroundColor Green "OK: Das Tool ShowInfo wird in den Autostart kopiert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Das Tool ShowInfo wird in den Autostart kopiert"
Copy-Item "C:\Install\showinfo.exe" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\ShowInfo.exe"

#An dieser Stelle wird die ShowInfo Verknüpfung auf den All-Users Desktiop kopiert
write-host -ForegroundColor Green "OK: Das ShowInfo Icon wird auf den Desktop kopiert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Das ShowInfo Icon wird auf den Desktop kopiert"
Copy-Item "C:\Install\showinfo.lnk" -Destination "c:\users\public\desktop\showinfo.lnk"
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird das Kundenspezifische ASP Icon erstellt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#https://administrator.de/forum/powershell-dateiinhalt-veraendern-148018.html
#https://blog.stefanrehwald.de/2013/03/03/powershell-03-2-strings-bearbeiten-und-untersuchen-mit-funktionen-wie-trim-substring-contains-tolower-toupper-startswith-endswith/
write-host -ForegroundColor Green "OK: Das Kundenspezifische ASP Icon wird erstellt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Das Kundenspezifische ASP Icon wird erstellt"

$QuelleAPSIcon="C:\install\ASP.txt"
$ZielASPIcon="C:\install\ASP.rdp"

$Datei = Get-ChildItem $QuelleAPSIcon
foreach ($String in $Datei)
{
$Inhalt = Get-Content -Path $String
$Inhalt | foreach {$_ -replace "K123","$Kundenkennung"} | foreach {$_ -replace "255.255.255.255","$WTSIPAdresse"} | Out-File -FilePath $ZielASPIcon -encoding Default -Append 
}
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle werden Computer Spezifische Einstellungen vorgenommen
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle wird die IPConfigurationen der Netzwerkkarten in das Ereignisprotokoll geschrieben
$IPConfig = IPConfig /all
write-host -ForegroundColor Green "OK: Die bestehende IP Configuration wird dokumentiert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "$IPConfig"

#An dieser Stelle wird der PC in die ckn partnerASP Arbeitsgruppe gesetzt und versucht den PC aus der bestehenden Domain zu entfernen
write-host -ForegroundColor Green "OK: Der Computer Arbeitsgruppenname wird geändert (und wenn möglich aus der Domäne entfernt)"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der Computer Arbeitsgruppenname wird geändert (und wenn möglich aus der Domäne entfernt)"
Add-Computer -WorkGroupName dom$Kundenkennung -ErrorAction SilentlyContinue

#An dieser Stelle wird der Eintrag "DnS-Suffix des Computers" eingestellt
write-host -ForegroundColor Green "OK: Das DNS Suffix des Computers wird geändert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Das DNS Suffix des Computers wird geändert"
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\" -Name "Domain" -Value dom$Kundenkennung.local
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\" -Name "NV Domain" -Value dom$Kundenkennung.local

#An dieser Stelle werden die physikalischen Netzwerkkarten auf DHCP gestellt
write-host -ForegroundColor Green "OK: Die physikalische Netzwerkkarte wird auf DHCP umgestellt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Die physikalische Netzwerkkarte wird auf DHCP umgestellt"
Get-NetAdapter -Physical | Set-NetIPInterface -Dhcp Enabled -ErrorAction SilentlyContinue

#An dieser Stelle wird für die physikalischen Netzwerkkarten den DNS-Server auf DHCP gestellt
write-host -ForegroundColor Green "OK: Die DNS Server der physikalische Netzwerkkarte wird auf DHCP umgestellt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Die DNS Server der physikalische Netzwerkkarte wird auf DHCP umgestellt"
Get-NetAdapter -Physical | Set-DnsClientServerAddress -ResetServerAddresses -ErrorAction SilentlyContinue

#An dieser Stelle wird auf den physikalischen Netzwerkkarten der Eintrag "DNS-Suffix für diese Verbindung" gesetzt
write-host -ForegroundColor Green "OK: Das DNS Suffix auf der physikalischen Netzwerkkarte wird geändert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Das DNS Suffix auf der physikalischen Netzwerkkarte wird geändert"
Get-NetAdapter -Physical | Set-DnsClient -ConnectionSpecificSuffix dom$Kundenkennung.local -ErrorAction SilentlyContinue

#An dieser Stelle wird der DNS-Cache geleert
write-host -ForegroundColor Green "OK: Der DNS Cache wird geleert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der DNS Cache wird geleert"
Clear-DnsClientCache -ErrorAction SilentlyContinue

#An dieser Stelle wird der DNS-Cache geleert
write-host -ForegroundColor Green "OK: Der WINS Cache wird geleert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der WINS Cache wird geleert"
nbtstat /R

#An dieser Stelle wird die IP Einstellung zurückgesetzt und erneuert
write-host -ForegroundColor Green "OK: Die IP Einstellungen der Netzwerkkarte werden zurückgesetzt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Die IP Einstellungen der Netzwerkkarte werden zurückgesetzt"
IPConfig /release
IPConfig /renew
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird der Proxy-Server auf Windows Ebene gelöscht
#https://www.der-windows-papst.de/2018/11/17/windows-proxy-server-systemweit-einstellen/
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

write-host -ForegroundColor Green "OK: Der Proxy auf Computer Ebene wird gelöscht"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Der Proxy auf Computer Ebene wird gelöscht"
netsh winhttp reset proxy
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird der WSUS Server für den PC Eingestellt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle werden die Policy basierenden Windows Update Einstellungen gelöscht
write-host -ForegroundColor Green "OK: Die Windows Update Einstellungen der alten Domäne werden gelöscht"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Die Windows Update Einstellungen der alten Domäne werden gelöscht"
REG DELETE "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate" /YES

#An dieser Stelle wird die Windows Update Auslieferungs Optimierung ausgeschaltet
#https://www.kapilarya.com/configure-windows-update-delivery-optimization-windows-10
write-host -ForegroundColor Green "OK: Die Windows Update Auslieferungs Optimierung wird abgeschaltet"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Die Windows Update Auslieferungs Optimierung wird abgeschaltet"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /f /v DODownloadMode /t REG_DWORD /d 0

#An dieser Stelle wird das Windows Update auf Benachrichtigung für Herunterladen und Installieren eingestellt
#https://docs.microsoft.com/de-de/windows/deployment/update/waas-wu-settings
write-host -ForegroundColor Green "OK: Das Windows Update wird auf Benachrichtigung für Herunterladen und Installieren eingestellt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Das Windows Update wird auf Benachrichtigung für Herunterladen und Installieren eingestellt"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /f /v AUOptions /t REG_DWORD /d 2

#An dieser Stelle wird das automatische Treiber Update ausgeschaltet
#https://forums.mydigitallife.net/threads/disable-driver-update-regedit-1709-fall-creators-update.75846/
write-host -ForegroundColor Green "OK: Das automatische Treiber Update wird ausgeschaltet"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Das automatische Treiber Update wird ausgeschaltet"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /f /v DontSearchWindowsUpdate /t REG_DWORD /d 1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /f /v SearchOrderConfig /t REG_DWORD /d 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /f /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# An dieser Stelle werden Registry EintrÃ¤ge für den PC durchgefÃ¼hrt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle werden Werbe-Apps im Starmenü entfernen
#https://www.antary.de/2016/05/23/windows-10-werbe-apps-im-startmenue-entfernen/?cookie-state-change=1565467955970
#https://www.deskmodder.de/blog/2018/09/12/app-vorschlaege-deaktivieren-bei-der-installation-von-programmen-in-der-windows-10-1809/
write-host -ForegroundColor Green "OK: Die Werbe-Apps im Starmenü werden entfernt"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Die Werbe-Apps im Starmenü werden entfernt"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f /v DisableSoftLanding /t REG_DWORD /d 1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /f /v AicEnabled /t REG_SZ /d Anywhere

#An dieser Stelle wird Cortana deaktiviert
#https://www.tecchannel.de/a/so-koennen-sie-cortana-abschalten,3277884
write-host -ForegroundColor Green "OK: Cortana wird deaktiviert"
Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "OK: Cortana wird deaktiviert"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\PolicyManager\current\device\Experience" /f /v AllowCortana /t REG_DWORD /d 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\PolicyManager\current\device\Experience" /f /v DisableWebSearch /t REG_DWORD /d 1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\PolicyManager\current\device\Experience" /f /v AllowSearchToUseLocation /t REG_DWORD /d 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\PolicyManager\current\device\Experience" /f /v ConnectedSearchUseWeb /t REG_DWORD /d 0
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
