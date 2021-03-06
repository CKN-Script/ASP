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
Write-host -ForegroundColor Green '                                                     Jens Steinh�user   '
Write-host -ForegroundColor Green '                                                      Martin Barthel    '
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
Write-host -ForegroundColor Green ''
#-------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stellen werden Powershell spezifische Einstellungen vorgenommen
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle wird die Scriptausf�hrung f�r den aktuellen User erlaubt
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
#An diser Stelle werden die die Powershell Help Dateien aktualisiert
    Update-Help -UICulture En-US -Force -ErrorAction SilentlyContinue

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stellen werden die Kundenspezifischen Einstellungen in Variablen hinterlegt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$Kundenkennung = "A78"
$Kundenname = "Testkunde"
$Kundennummer = "173597#Ckn"
$Password = "Datev001"
$WTSIPAdresse = "10.10.10.11"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle werden Einstellungen im Windows Eventlog vorgenommen
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle die ckn-Computer Sorce im Anwandgs Eventlog angelegt
#https://www.msxfaq.de/code/powershell/pseventlog.htm
New-EventLog -LogName "cknComputer" -Source "ASPUmstellungsScript2.0" -ErrorAction SilentlyContinue

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird der f�r ckn PartnerASP vorgegebenen User STANDARD auf den lokalen PCs eingerichtet
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser stelle wird eine Variable erzeugt die das Kennwort f�r Administrator in einen SecurityString umwandelt
$StandardPassword = (convertto-securestring -string $Password -asplaintext -force)
#Pr�fen ob der User "standard" schon existiert
if (-not (get-localuser -name "standard" -ErrorAction SilentlyContinue))
{
    $StandardUserNichtVorhanden = "OK: Der User Standard existiert nicht! Er wird nun angelegt."
    Write-host -ForegroundColor Green "$StandardUserNichtVorhanden"
    Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "$StandardUserNichtVorhanden"
# An dieser Stelle wird der User Standard neu angelegt.
# Es wird eingestellt das, das Benutzerkonto nie abl�uft
# Es wird die Beschreibung "ckn Computer default User" im User hinterlegt
# Das Kennwort wird �ber die Variable $StandardPassword eingetragen
# Der Schalter "Kennwort l�uft nie ab" im User wird gesetzt
# Der Schalter "Benutzer kann Kennwort nicht ändern" im User wird gesetzt
    New-LocalUser -name standard -AccountNeverExpires -Description "ckn Computer default User" -Password $StandardPassword -PasswordNeverExpires -UserMayNotChangePassword -ErrorAction SilentlyContinue
}
else
{
    $StandardUserVorhanden = "Der User Standard existiert"
    write-warning "$StandardUserVorhanden"
    Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "$StandardUserVorhanden"
# An dieser Stelle werden f�r den User Standard diverse Einstellungen gesetzt wenn er schon vorhanden ist
# Es wird eingestellt das, das Benutzerkonto nie abl�uft
# Das Kennwort wird �ber die Variable $StandardPassword eingetragen
# Der Schalter "Kennwort l�uft nie ab" im User wird gesetzt
# Der Schalter "Benutzer kann Kennwort nicht �ndern" im User wird gesetzt
    Set-LocalUser -Name standard -AccountNeverExpires -Description "ckn Computer default User" -Password $StandardPassword -PasswordNeverExpires $true -UserMayChangePassword $false -ErrorAction SilentlyContinue
# An dieser Stelle wird der User Standard aktiviert wenn er deaktiviert sein sollte
    Enable-LocalUser -Name standard -ErrorAction SilentlyContinue
}
#An dieser Stelle wird der User Standard der lokalen Gruppe Benutzer hinzugefügt
Add-LocalGroupMember -Group Benutzer -Member standard -ErrorAction SilentlyContinue
#An dieser Stelle wird der User Standard aus der lokalen Gruppe Administratoren entfernt
Remove-LocalGroupMember -Group Administratoren -Member standard -ErrorAction SilentlyContinue

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird der f�r ckn partnerASP vorgegebenen User ADMINISTRATOR auf den lokalen PCs eingerichtet
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser stelle wird eine Variable erzeugt die das Kennwort f�r Administrator in einen SecurityString umwandelt
$AdminPassword = (convertto-securestring -string $Kundennummer -asplaintext -force)
if (-not (get-localuser -name "Administrator" -ErrorAction SilentlyContinue))
{
    $AdministratorUserNichtVorhanden ="OK: Der User Administrator existiert nicht! Er wird nun angelegt."
    Write-host -ForegroundColor Green "$AdministratorUserNichtVorhanden"
    Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "$AdministratorUserNichtVorhanden"
#An dieser Stelle wird der User Administrator neu angelegt.
#Es wird eingestellt das, das Benutzerkonto nie abl�uft
#Es wird die Beschreibung "ckn Computer default User" im User hinterlegt
#Das Kennwort wird �ber die Variable $StandardPassword eingetragen
#Der Schalter "Kennwort l�uft nie ab" im User wird gesetzt
#Der Schalter "Benutzer kann Kennwort nicht �ndern" im User wird gesetzt
    New-LocalUser -name Administrator -AccountNeverExpires -Description "ckn Computer Admin User" -Password $AdminPassword -PasswordNeverExpires -UserMayNotChangePassword -ErrorAction SilentlyContinue
}
else
{
    $AdministratorUserVorhanden
    write-warning "$AdministratorUserVorhanden"
    Write-EventLog -EntryType Information -LogName cknComputer -EventId "10001" -Source "ASPUmstellungsScript2.0" -Category "0" -Message "$AdministratorUserVorhanden"
#An dieser Stelle werden f�r den User Administrator diverse Einstellungen gesetzt wenn er schon vorhanden ist
#Es wird eingestellt das, das Benutzerkonto nie abl�uft
#Das Kennwort wird �ber die Variable $StandardPassword eingetragen
#Der Schalter "Kennwort l�uft nie ab" im User wird gesetzt
#Der Schalter "Benutzer kann Kennwort nicht �ndern" im User wird gesetzt
    Set-LocalUser -Name Administrator -AccountNeverExpires -Description "ckn Computer Admin User" -Password $AdminPassword -PasswordNeverExpires $true -UserMayChangePassword $false -ErrorAction SilentlyContinue
#An dieser Stelle wird der User Administrator aktiviert wenn er deaktiviert sein sollte
    Enable-LocalUser -Name Administrator -ErrorAction SilentlyContinue
}
#An dieser Stelle wird der User Administrator der lokalen Gruppe Administratoren hinzugef�gt
    Add-LocalGroupMember -Group Administratoren -Member Administrator -ErrorAction SilentlyContinue
#An dieser Stelle wird der User Administrator aus der lokalen Gruppe Benutzer entfernt
    Remove-LocalGroupMember -Group Benutzer -Member Administrator -ErrorAction SilentlyContinue

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle werden Computer Allgemeine Kopiervorg�nge durchgef�hrt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#https://www.itslot.de/2019/02/poweshell-ordner-und-unterordner.html
#An dieser Stelle wird ein Installationsverzeichnis kopiert und das ckn Softwarepaket kopiert
Copy-Item "Gemeinsam\Allgemein" -Destination "c:\Install\" -Recurse
#An dieser Stelle wird das Kundenspezifische Softwarepaket kopiert
Copy-Item "Kunden\$Kundenname\" -Destination "c:\Install\" -Recurse

#An dieser Stelle wird die ckn Teamviewer Verkn�pfung auf den All-Users Desktiop kopiert
Copy-Item "C:\Install\ckn-TeamViewer.lnk" -Destination "c:\users\public\desktop\ckn-TeamViewer.lnk"
#An dieser Stelle wird das Programm ShowInfo in den All-Users AutoStart kopiert
Copy-Item "C:\Install\showinfo.exe" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\ShowInfo.exe"
#An dieser Stelle wird die ShowInfo Verkn�pfung auf den All-Users Desktiop kopiert
Copy-Item "C:\Install\showinfo.lnk" -Destination "c:\users\public\desktop\showinfo.lnk"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird das Kundenspezifische ASP Icon erstellt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#https://administrator.de/forum/powershell-dateiinhalt-ver%C3%A4ndern-148018.html
#https://blog.stefanrehwald.de/2013/03/03/powershell-03-2-strings-bearbeiten-und-untersuchen-mit-funktionen-wie-trim-substring-contains-tolower-toupper-startswith-endswith/

$QuelleAPSIcon="C:\install\ASP.txt"
$ZielASPIcon="C:\install\ASP.rdp"

$Datei = Get-ChildItem $QuelleAPSIcon
foreach ($String in $Datei)
{
$Inhalt = Get-Content -Path $String
$Inhalt | foreach {$_ -replace "K123","$Kundenkennung"} | foreach {$_ -replace "255.255.255.255","$WTSIPAdresse"} | Out-File -FilePath $ZielASPIcon -encoding Default -Append 
}

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle werden die Standard User spezifischen Kopiervorg�nge ausgef�hrt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle wird das ASP Icon auf den Desktop des Standard Users kopiert
Copy-Item "C:\Install\ASP.rdp" -Destination "C:\Users\Standard\Desktop\ASP.rdp"
#An dieser Stelle wird die ASP Verkn�pfung in den Autostart Ordner des Standard Users kopiert
Copy-Item "C:\Install\ASP.lnk" -Destination "C:\Users\Standard\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ASP.lnk"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle werden Computer Spezifische Einstellungen vorgenommen
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle wird der PC in die ckn partnerASP Arbeitsgruppe gesetzt und versucht den PC aus der bestehenden Domain zu entfernen
Add-Computer -WorkGroupName dom$Kundenkennung

#An dieser Stelle wird der Eintrag "DnS-Suffix des Computers" eingestellt
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\" -Name "Domain" -Value dom$Kundenkennung.local
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\" -Name "NV Domain" -Value dom$Kundenkennung.local

#An dieser Stelle werden die physikalischen Netzwerkkarten auf DHCP gestellt
Get-NetAdapter -Physical | Set-NetIPInterface -Dhcp Enabled

#An dieser Stelle wird f�r die physikalischen Netzwerkkarten den DNS-Server auf DHCP gestellt
Get-NetAdapter -Physical | Set-DnsClientServerAddress -ResetServerAddresses

#An dieser Stelle wird auf den physikalischen Netzwerkkarten der Eintrag "DNS-Suffix f�r diese Verbindung" gesetzt
Get-NetAdapter -Physical | Set-DnsClient -ConnectionSpecificSuffix dom$Kundenkennung.local

#An dieser Stelle wird der DNS-Cache geleert
Clear-DnsClientCache

IPConfig /release
IPConfig /renew

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird der Proxy-Server auf Windows Ebene gel�scht
#https://www.der-windows-papst.de/2018/11/17/windows-proxy-server-systemweit-einstellen/
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

netsh winhttp reset proxy

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird der WSUS Server f�r den PC Eingestellt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle werden die Policy basierenden Windows Update Einstellungen gel�scht
REG DELETE "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate"

#An dieser Stelle wird die Windows Update Auslieferungs Optimierung ausgeschaltet
#https://www.kapilarya.com/configure-windows-update-delivery-optimization-windows-10
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /f /v DODownloadMode /t REG_DWORD /d 0

#An dieser Stelle wird das Windows Update auf Benachrichtigung f�r Herunterladen und Installieren eingestellt
#https://docs.microsoft.com/de-de/windows/deployment/update/waas-wu-settings
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /f /v AUOptions /t REG_DWORD /d 2

#An dieser Stelle wird das automatische Treiber Update ausgeschaltet
#https://forums.mydigitallife.net/threads/disable-driver-update-regedit-1709-fall-creators-update.75846/
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /f /v DontSearchWindowsUpdate /t REG_DWORD /d 1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /f /v SearchOrderConfig /t REG_DWORD /d 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /f /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle die Vorinstallierten Windows 10 Apps deinstalliert
#https://www.heise.de/tipps-tricks/Windows-10-Vorinstallierte-Apps-deinstallieren-3970502.html
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#!Nicht vorhanden
#An dieser Stelle wird 3D Builder deinstalliert
Get-AppxPackage *3dbuilder* | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Alarm und Uhr deinstalliert
#Get-AppxPackage Microsoft.windowsalarms | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Asphalt 8: Airborne deinstalliert
Get-AppxPackage *Asphalt8Airborne* | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Begleiter f�r Telefon deinstalliert
#Get-AppxPackage *windowsphone* | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Candy Crush Saga deinstalliert
Get-AppxPackage *CandyCrushSaga* | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Drawboard PDF deinstalliert
Get-AppxPackage *DrawboardPDF* | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Erste Schritte deinstalliert
#Get-AppxPackage Microsoft.getstarted | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Facebook deinstalliert
Get-AppxPackage *Facebook* | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Feedback Hub deinstalliert
Get-AppxPackage Microsoft.windowsfeedbackhub | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Filme & TV deinstalliert
Get-AppxPackage Microsoft.zunevideo | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Finanzen deinstalliert
Get-AppxPackage *bingfinance* | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Fotos deinstalliert
Get-AppxPackage Microsoft.Windows.photos | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Groove-Musik deinstalliert
Get-AppxPackage Microsoft.zunemusic | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Kalender & Mail deinstalliert
#Get-AppxPackage microsoft.windowscommunicationsapps | remove-appxpackage

#!Vorhanden
#An dieser Stelle wird Kamera deinstalliert
Get-AppxPackage Microsoft.windowscamera | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Karten deinstalliert
Get-AppxPackage Microsoft.windowsmaps | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Kontakte deinstalliert
#Get-AppxPackage Microsoft.people | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Microsoft Solitaire Collection deinstalliert
Get-AppxPackage Microsoft.Microsoftsolitairecollection* | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Nachrichten deinstalliert
Get-AppxPackage *bingnews* | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Nachrichten & Skype deinstalliert
#Get-AppxPackage Microsoft.messaging | remove-appxpackage

#!Vorhanden
#An dieser Stelle wird Office holen deinstalliert
Get-AppxPackage Microsoft.Microsoftofficehub* | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird OneNote deinstalliert
Get-AppxPackage Microsoft.Office.onenote* | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Paint 3D deinstalliert
Get-AppxPackage Microsoft.mspaint | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Rechner deinstalliert
Get-AppxPackage Microsoft.windowscalculator | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Skype deinstalliert
#Get-AppxPackage Microsoft.skypeapp | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Sport deinstalliert
Get-AppxPackage *bingsports* | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Sprachrekorder deinstalliert
Get-AppxPackage Microsoft.windowssoundrecorder | Remove-AppxPackage

#!Nicht vorhanden
#An dieser Stelle wird Windows DVD Player deinstalliert
#Get-AppxPackage *dvd* | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Xbox Identity Provider deinstalliert
Get-AppxPackage Microsoft.xboxIdentityprovider | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Xbox deinstalliert
Get-AppxPackage Microsoft.xboxapp | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird 3DViewer deinstalliert
Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird Wallet deinstalliert
Get-AppxPackage Microsoft.Wallet | Remove-AppxPackage

#!Vorhanden
#An dieser Stelle wird XBox Komponenten deinstalliert
Get-AppxPackage Microsoft.XBox.TCUI | Remove-AppxPackage
Get-AppxPackage Microsoft.XBoxGameOverlay | Remove-AppxPackage
Get-AppxPackage Microsoft.XBoxSpeechToTextOverlay | Remove-AppxPackage
Get-AppxPackage Microsoft.XBoxGameCallableUI | Remove-AppxPackage

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# An dieser Stelle werden Registry Einträge f�r den PC durchgeführt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle werden Werbe-Apps im Starmen� entfernen
#https://www.antary.de/2016/05/23/windows-10-werbe-apps-im-startmenue-entfernen/?cookie-state-change=1565467955970
#https://www.deskmodder.de/blog/2018/09/12/app-vorschlaege-deaktivieren-bei-der-installation-von-programmen-in-der-windows-10-1809/
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f /v DisableSoftLanding /t REG_DWORD /d 1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /f /v AicEnabled /t REG_SZ /d Anywhere

#An dieser Stelle wird Cortana deaktiviert
#https://www.tecchannel.de/a/so-koennen-sie-cortana-abschalten,3277884
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\PolicyManager\current\device\Experience" /f /v AllowCortana /t REG_DWORD /d 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\PolicyManager\current\device\Experience" /f /v DisableWebSearch /t REG_DWORD /d 1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\PolicyManager\current\device\Experience" /f /v AllowSearchToUseLocation /t REG_DWORD /d 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\PolicyManager\current\device\Experience" /f /v ConnectedSearchUseWeb /t REG_DWORD /d 0

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# An dieser Stelle werden Registry Einträge f�r den Benutzer durchgeführt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle wird eingestellt das die Windows Version im unteren rechten bereich auf dem Desktop angezeigt wird
#https://www.pcwelt.de/tipps/Versionsnummer-einblenden-10048509.html
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /f /v PaintDesktopVersion /t REG_DWORD /d 1

#An dieser Stelle wird eingestellt das in der Taskleiste immer alle Symbole angezeigt werden
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /f /v EnableAutoTray /t REG_DWORD /d 0

#An dieser Stelle wird eingestellt das die Tasks in der Taskleiste nie Gruppiert werden
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarGlomLevel /t REG_DWORD /d 2

#An dieser Stelle wird der Task View Button in der Taskleiste entfernt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v ShowTaskViewButton /t REG_DWORD /d 0

#An dieser Stelle wird der Kontakte Bereich in der Taskleiste entfernt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /f /v PeopleBand /t REG_DWORD /d 0

#An dieser Stelle wird im Windows Explorer die Option Alle Ordner Anzeigen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v NavPaneShowAllFolders /t REG_DWORD /d 1

#An dieser Stelle wird im Windows Explorer die Option Ausgeblendete Dateien, Ordner und Laufwerke Anzeigen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v Hidden /t REG_DWORD /d 1

#An dieser Stelle wird im Windows Explorer die Option Erweitern, um Ordner zu �ffnen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v NavPaneExpandToCurrentFolder /t REG_DWORD /d 1

#An dieser Stelle wird im Windows Explorer die Option Dateisymbol auf Miniaturansichten anzeigen ausgeschaltet
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v ShowTypeOverlay /t REG_DWORD /d 0

#An dieser Stelle wird im Windows Explorer die Option Erweiterungen bei bekannten Dateitypen ausblenden ausgeschaltet
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v HideFileExt /t REG_DWORD /d 0

#An dieser Stelle wird im Windows Explorer die Option Freigabe-Assistent verwenden ausgeschaltet
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v SharingWizardOn /t REG_DWORD /d 0

#An dieser Stelle wird im Windows Explorer die Option Immer Men�s anzeigen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v AlwaysShowMenus /t REG_DWORD /d 1

#An dieser Stelle wird im Windows Explorer die Option Vollständigen Pfad in der Titelleiste anzeigen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /f /v FullPath /t REG_DWORD /d 1

#An dieser Stelle wird im Internet Explorer die Option Verlauf beim Beeenden l�schen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Privacy" /f /v ClearBrowsingHistoryOnExit /t REG_DWORD /d 1

#An dieser Stelle wird im Internet Explorer die Option Tempor�re Internetdateien Zu verwendender Speicherplatz auf 8 MB gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache" /f /v ContentLimit /t REG_DWORD /d 8
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache\Content" /f /v CachePrefix /t REG_SZ /d ""
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache\Content" /f /v CacheLimit /t REG_DWORD /d 2000

#An dieser Stelle wird im Internet Explorer die Option Leeren des Ordners f�r tempor�re Internetdateien beim Schlie�en des Browsers gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\CACHE" /f /v Persistent /t REG_DWORD /d 0

#An dieser Stelle wird im Internet Explorer die Option Leeren des Ordners f�r tempor�re Internetdateien beim Schlie�en des Browsers gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /f /v "Start Page" /t REG_SZ /d "http://www.google.de/"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /f /v "Secondary Start Pages" /t REG_MULTI_SZ /d "http://www.ckn.de/"

#An dieser Stelle wird im Internet Explorer die Option Leeren des Ordners Proxyserver f�r LAN verwenden ausgeschaltet
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /f /v ProxyEnable /t REG_DWORD /d 0
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
