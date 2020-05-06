$mailbox = 

Add-MailboxPermission -Identity $mailbox -User mbenuzzi@soldo.com -AccessRights FullAccess -AutoMapping:$false 
Add-MailboxPermission -Identity $mailbox -User dgialloreto@soldo.com -AccessRights FullAccess -AutoMapping:$false 
Add-MailboxPermission -Identity $mailbox -User pshahabi@soldo.com -AccessRights FullAccess -AutoMapping:$false 
Add-MailboxPermission -Identity $mailbox -User nbromilow@soldo.com -AccessRights FullAccess -AutoMapping:$false 