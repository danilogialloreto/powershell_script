#convert password to secure string
$Secure_String_Pwd = ConvertTo-SecureString "M15s.Dron10" -AsPlainText -Force
#create user and insert in administrator group
New-LocalUser "support" -Password $Secure_String_Pwd -FullName "support" -Description "Used by IT team for administrative tasks" -AccountNeverExpires -PasswordNeverExpires
Start-Sleep -Seconds 15
Add-LocalGroupMember -Group "Administrators" -Member "support"
exit 0