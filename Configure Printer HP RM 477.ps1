Set-ExecutionPolicy -ExecutionPolicy Unrestricted

$PnPUtil = "C:\Windows\System32\pnputil.exe"
$DriverPathInf = "C:\Windows\Temp\HP\hpmaD511_x64.inf"
$DriverPath = "C:\Windows\Temp\HP\"
$IPAddress = "10.10.10.201"
$DriverName = "HP PageWide Pro 477dw MFP PCL 6"
$PrinterName = "HP PageWide Pro 477dw MFP PCL 6 (Network)"

Invoke-WebRequest -uri ftp://px-rm-nas-01.px.iefcloud.com/sharedvol/Software/Intune/PW477.zip -OutFile C:\Windows\Temp\driver.zip
Expand-Archive -Path 'C:\Windows\Temp\driver.zip' -DestinationPath $DriverPath -Force


cmd /c "$PnPUtil -i -a $DriverPathInf"
Add-PrinterDriver -Name $DriverName 
Start-Sleep 10
Get-PrinterDriver
Start-Sleep 10
Add-PrinterPort -Name $IPAddress -PrinterHostAddress $IPAddress
Start-Sleep 10
Add-Printer -Name $PrinterName -ShareName $PrinterName -DriverName $DriverName -PortName $IPAddress

Set-PrintConfiguration -PrinterName $PrinterName -PaperSize A4