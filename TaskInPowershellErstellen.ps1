clear

#
# Script zum automatischen erstellen eines Tasks!
#
# https://www.windowspro.de/script/register-scheduledtask-geplante-aufgaben-erstellen-powershell
#

# !!! Auslöser definieren !!!
# https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger?view=win10-ps
#
# beim starten des Rechners:
# New-ScheduledTaskTrigger -AtStartup
#
$triger = New-ScheduledTaskTrigger -AtLogon -User standard

# !!! Aus zu führende Aktionen definieren !!!
# https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskaction?view=win10-ps
$action = New-ScheduledTaskAction -WorkingDirectory $env:TEMP -Execute $env:SystemRoot\system32\powershell.exe -Argument "-command 'C:\install\benutzer.ps1'"

# !!! im anderen Userkontext ausführen 
# https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskprincipal?view=win10-ps
#
# mit erhöhten Rechten "-RunLevel Highest"
$principal New-ScheduledTaskPrincipal -UserId "LOCALSERVICE" -LogonType ServiceAccount

# weitere Bedingungen
# https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasksettingsset?view=win10-ps
$settings = New-ScheduledTaskSettingsSet -RunOnlyIfIdle -WakeToRun

# Den Task registrieren
Register-ScheduledTask -TaskName CNKUserScriptAusführen -TaskPath "\CKN" -Action $action -Settings $settings -Trigger $triger -Principal $principal

# zum Löschen eines Tasks:
# UnRegister-ScheduledTask -TaskName CNKUserScriptAusführen
#


# Plan:
# 1. Bei ausführen des Admin-Scripts, wird ein Task erstellt, der den standard User beim booten des PCs automatisch anmeldet (evtl per RegRedit: https://www.andysblog.de/windows-benutzer-automatisch-anmelden-und-ggf-den-computer-sperren)
# 2. Wird ein Task erstellt, der bei der Anmeldung des "standard"-Users das Benutzer-Script mit user-Rechten ausführt.
# 3. Wird ein Task erstellt, der bei der Anmeldung des "standard"-Users die ersten task deaktiviert.
# 4. Das Admin-Script startet den PC neu; Nun wird automatisch der "standard"-User angemeldet und das Benutzer-Script ausgeführt
# 5. Im Benutzer-Script wird ein Task erstellt, der bei der Abmeldung des "standard"-Users alle Tasks deaktiviert.
# 6. Das Benutzer-Script meldet den "standard"-Users ab!
#
#
