#start the session
Set-ExecutionPolicy RemoteSigned -Confirm:$false
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication  Basic -AllowRedirection
#import the session
Import-PSSession $Session
#connect aad
Connect-AzureAD -Credential $UserCredential
#set group variables
$Rome = "AllSoldoRome@soldo.com"
$Milan = "AllSoldoMilan@soldo.com"
$Dublin = "AllSoldoDublin@soldo.com"
$London = "AllSoldoLondon@soldo.com"
$External = "AllSoldo_External@soldo.com"
$Rome_Dyn = "49f1ed7d-e4c5-4db7-a47b-292df8cf050b"
$Milan_Dyn = "931cf084-8678-495d-92d2-b623605836b1"
$Dublin_Dyn = "c77a784e-a6db-4d6f-a8c7-db598a4958fe"
$London_Dyn = "71a29d01-be41-4272-8911-e9b0623bf164"
$External_Dyn = "f3d015c5-b1f8-43b9-ae89-06f0289c590d"
$RomeBackup = "AllSoldoRome_Backup@soldo.com"
$MilanBackup = "AllSoldoMilan_Backup@soldo.com"
$DublinBackup = "AllSoldoDublin_Backup@soldo.com"
$LondonBackup = "AllSoldoLondon_Backup@soldo.com"
$ExternalBackup = "AllSoldoExternal_Backup@soldo.com"
#empty backup groups
Get-DistributionGroupMember -Identity $RomeBackup | % {Remove-distributiongroupmember -Identity $RomeBackup -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $MilanBackup | % {Remove-distributiongroupmember -Identity $MilanBackup -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $DublinBackup | % {Remove-distributiongroupmember -Identity $DublinBackup -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $LondonBackup | % {Remove-distributiongroupmember -Identity $LondonBackup -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $ExternalBackup | % {Remove-distributiongroupmember -Identity $ExternalBackup -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
#backup groups
Get-DistributionGroupMember -Identity $Rome | % {add-distributiongroupmember -Identity $RomeBackup -Member $_.Name; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $London | % {add-distributiongroupmember -Identity $LondonBackup -Member $_.Name; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $Dublin | % {add-distributiongroupmember -Identity $DublinBackup -Member $_.Name; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $Milan | % {add-distributiongroupmember -Identity $MilanBackup -Member $_.Name; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $External | % {add-distributiongroupmember -Identity $ExternalBackup -Member $_.Name; Start-Sleep -Milliseconds 500}
#remove all members from the distribution lists
Get-DistributionGroupMember -Identity $Rome | % {Remove-distributiongroupmember -Identity $Rome -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $Milan | % {Remove-distributiongroupmember -Identity $Milan -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $Dublin | % {Remove-distributiongroupmember -Identity $Dublin -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $London | % {Remove-distributiongroupmember -Identity $London -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
Get-DistributionGroupMember -Identity $External | % {Remove-distributiongroupmember -Identity $External -Member $_.Name -Confirm:$false; Start-Sleep -Milliseconds 500}
#copy from dyn sec group to me-sg
Get-AzureADGroupMember -All $True -ObjectId $Rome_Dyn | % {add-distributiongroupmember -Identity $Rome -Member $_.UserPrincipalName; Start-Sleep -Milliseconds 500}
Get-AzureADGroupMember -All $True -ObjectId $Milan_Dyn | % {add-distributiongroupmember -Identity $Milan -Member $_.UserPrincipalName; Start-Sleep -Milliseconds 500}
Get-AzureADGroupMember -All $True -ObjectId $Dublin_Dyn | % {add-distributiongroupmember -Identity $Dublin -Member $_.UserPrincipalName; Start-Sleep -Milliseconds 500}
Get-AzureADGroupMember -All $True -ObjectId $London_Dyn | % {add-distributiongroupmember -Identity $London -Member $_.UserPrincipalName; Start-Sleep -Milliseconds 500}
Get-AzureADGroupMember -All $True -ObjectId $External_Dyn | % {add-distributiongroupmember -Identity $External -Member $_.UserPrincipalName; Start-Sleep -Milliseconds 500}
#aad disconnect
Disconnect-AzureAD
#close current session
Get-PSSession | Remove-PSSession