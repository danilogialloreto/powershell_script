#Get signed-in user's SID to ingest into XML file (this way the task is registered/ran as the user)
$domainuser = "$env:USERDOMAIN\$env:USERNAME"
$newargs = (New-Object System.Security.Principal.NTAccount($domainuser)).Translate([System.Security.Principal.SecurityIdentifier]).value

#Create xml file to create task to run bat
$xmlText = '<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2020-10-13T09:20:39.9917176</Date>
    <Author>AzureAD\GialloretoDanilo</Author>
    <URI>\OneDriveForceStartup</URI>
  </RegistrationInfo>
  <Triggers>
    <BootTrigger>
      <Enabled>true</Enabled>
    </BootTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>INGESTSID</UserId>
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>LeastPrivilege</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>true</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>false</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT0S</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>%LOCALAPPDATA%\Microsoft\OneDrive\OneDrive.exe</Command>
    </Exec>
  </Actions>
</Task>'

#Create fodler to create task to run bat

$homepath = Write-Host "c:$env:HOMEPATH"

if(!(Test-Path "c:\Users\Public\Resources")){
    New-Item -ItemType Directory -Path "c:\Users\Public" -Name "Resources"
}
 
#Create the script and XML files from the content above
New-Item -ItemType File -Path "c:\Users\Public\Resources" -Name "addtask.xml" -Force
Add-Content "c:\Users\Public\Resources\addtask.xml" $xmlText | Set-Content "c:\Users\Public\Resources\addtask.xml" -Force
 

#Ingest the SID into the XML
Start-Sleep -Seconds 3
(Get-Content "c:\Users\Public\Resources\addtask.xml") | Foreach {$_ -replace "INGESTSID", "$newargs"} | Set-Content "c:\Users\Public\Resources\addtask.xml" -force

#Create the task
Start-Sleep -Seconds 3
schtasks /create /TN "ForceOneDriveAtStartup" /xml "c:\Users\Public\Resources\addtask.xml" /f
 
#Run the task
Start-Sleep -Seconds 3
schtasks /run /tn "ForceOneDriveAtStartup"