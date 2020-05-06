#Start Session
Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

#Initialize variable for the two groups
$PrimaryGroup = Read-Host -Prompt 'Type the UPN of group from which to copy the users'
$SecondaryGroup = Read-Host -Prompt 'Type the UPN of group to copy the users'

#to copy all members from a distribution list to another
Get-DistributionGroupMember -Identity $PrimaryGroup | % {add-distributiongroupmember -Identity $SecondaryGroup -Member $_.Name}

#Clean Session
Remove-PSSession