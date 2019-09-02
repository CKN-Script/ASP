Function Set-AutoLogon{

    [CmdletBinding()]
    Param(
        
        [Parameter(Mandatory=$True,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [String[]]$DefaultUsername,

        [Parameter(Mandatory=$True,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [String[]]$DefaultPassword,

        [Parameter(Mandatory=$False,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [AllowEmptyString()]
        [String[]]$AutoLogonCount,

        [Parameter(Mandatory=$False,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [AllowEmptyString()]
        [String[]]$Script
                
    )

    Begin
    {
        #Registry path declaration
        $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
        $RegROPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
    
    }
    
    Process
    {

        try
        {
            #setting registry values
            Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String  
            Set-ItemProperty $RegPath "DefaultUsername" -Value "$DefaultUsername" -type String  
            Set-ItemProperty $RegPath "DefaultPassword" -Value "$DefaultPassword" -type String
            if($AutoLogonCount)
            {
                
                Set-ItemProperty $RegPath "AutoLogonCount" -Value "$AutoLogonCount" -type DWord
            
            }
            else
            {

                Set-ItemProperty $RegPath "AutoLogonCount" -Value "1" -type DWord

            }
            if($Script)
            {
                
                Set-ItemProperty $RegROPath "(Default)" -Value "$Script" -type String
            
            }
            else
            {
            
                Set-ItemProperty $RegROPath "(Default)" -Value "" -type String
            
            }        
        }

        catch
        {

            Write-Output "An error had occured $Error"
            
        }
    }
    
    End
    {
        
        #End

    }

}

Set-AutoLogon -DefaultUsername "standard" -DefaultPassword "Datev001" -AutoLogonCount "1" -Script "c:\scripts\neustart_Administrator.ps1"

Restart-Computer