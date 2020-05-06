$LiveCred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic –AllowRedirection
Import-PSSession $Session
$UserSharing = Read-Host -Prompt 'Input the user that wants to share Calendar'
$UserShared = Read-Host -Prompt 'Input the user that will use shared calendar'
$Rights = Read-Host -Prompt 'Input the user that will use shared calendar'
Add-MailboxFolderPermission -Identity ${UserSharing}:\calendar -user $UserShared -AccessRights $Rights