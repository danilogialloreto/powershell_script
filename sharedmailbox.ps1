

$Groups = Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited | Select Identity,Alias,DisplayName,PrimarySmtpAddress | sort displayname


$Groups | ForEach-Object {
  $group = $_.DisplayName
  Get-MailboxPermission -Identity $_.DisplayName | select Identity, User | sort DisplayName | where { ($_.User -notlike '*NT AUTHORITY*') -and ($_.User -notlike '*S-1-5-21-*') -and ($_.User -notlike '*JitUsers*') -and ($_.User -notlike '*EURPRD07*') } 
} | Export-csv .\SharedMailbox_Users.csv


