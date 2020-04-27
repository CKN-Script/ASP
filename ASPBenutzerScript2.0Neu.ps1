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
#An dieser Stelle wird Begleiter für Telefon deinstalliert
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
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# An dieser Stelle werden Registry EintrÃ¤ge für den Benutzer durchgefÃ¼hrt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle wird das automatische Treiber Update ausgeschaltet
#https://forums.mydigitallife.net/threads/disable-driver-update-regedit-1709-fall-creators-update.75846/
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /f /v DontSearchWindowsUpdate /t REG_DWORD /d 1

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

#An dieser Stelle wird im Windows Explorer die Option Erweitern, um Ordner zu öffnen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v NavPaneExpandToCurrentFolder /t REG_DWORD /d 1

#An dieser Stelle wird im Windows Explorer die Option Dateisymbol auf Miniaturansichten anzeigen ausgeschaltet
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v ShowTypeOverlay /t REG_DWORD /d 0

#An dieser Stelle wird im Windows Explorer die Option Erweiterungen bei bekannten Dateitypen ausblenden ausgeschaltet
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v HideFileExt /t REG_DWORD /d 0

#An dieser Stelle wird im Windows Explorer die Option Freigabe-Assistent verwenden ausgeschaltet
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v SharingWizardOn /t REG_DWORD /d 0

#An dieser Stelle wird im Windows Explorer die Option Immer Menüs anzeigen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v AlwaysShowMenus /t REG_DWORD /d 1

#An dieser Stelle wird im Windows Explorer die Option VollstÃ¤ndigen Pfad in der Titelleiste anzeigen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /f /v FullPath /t REG_DWORD /d 1

#An dieser Stelle wird im Internet Explorer die Option Verlauf beim Beeenden löschen gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Privacy" /f /v ClearBrowsingHistoryOnExit /t REG_DWORD /d 1

#An dieser Stelle wird im Internet Explorer die Option Temporäre Internetdateien Zu verwendender Speicherplatz auf 8 MB gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache" /f /v ContentLimit /t REG_DWORD /d 8
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache\Content" /f /v CachePrefix /t REG_SZ /d ""
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache\Content" /f /v CacheLimit /t REG_DWORD /d 2000

#An dieser Stelle wird im Internet Explorer die Option Leeren des Ordners für temporäre Internetdateien beim Schließen des Browsers gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\CACHE" /f /v Persistent /t REG_DWORD /d 0

#An dieser Stelle wird im Internet Explorer die Option Leeren des Ordners für temporäre Internetdateien beim Schließen des Browsers gesetzt
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /f /v "Start Page" /t REG_SZ /d "http://www.google.de/"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /f /v "Secondary Start Pages" /t REG_MULTI_SZ /d "http://www.ckn.de/"

#An dieser Stelle wird im Internet Explorer die Option Leeren des Ordners Proxyserver für LAN verwenden ausgeschaltet
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /f /v ProxyEnable /t REG_DWORD /d 0
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#An dieser Stelle werden die Standard User spezifischen Kopiervorgänge ausgeführt
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#An dieser Stelle wird das ASP Icon auf den Desktop des Standard Users kopiert
Copy-Item "C:\Install\ASP.rdp" -Destination "C:\Users\Standard\Desktop\ASP.rdp"

#An dieser Stelle wird die ASP Verknüpfung in den Autostart Ordner des Standard Users kopiert
Copy-Item "C:\Install\ASP.lnk" -Destination "C:\Users\Standard\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ASP.lnk"
pause
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
