
# LINK powershell -windowstyle hidden -exec bypass -file "myscript.ps1"
#Set-ExecutionPolicy RemoteSigned -Scope Process
#Set-ExecutionPolicy Unrestricted -Scope Process
 
#192.168.20.112 - тестовый ip

#mask 255.255.252.0
#GW   192.168.22.217
#DNS 192.168.20.2
 
 
# Use the Set-ADAccountPassword cmdlet to change the user’s password:
#Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$newPass" -Force)
#Replace $user and $newPass with the actual username and a new password.
$Uname = "Director"
$Pass = "PA$$WORD"
$FUname = "Иванов Иван Иванович"
$Uinfo = "Директор филиала тел. 666"
$PCNAME = "DESKTOP-0568"



 #read user password
 #;Password = Read-Host -AsSecureString
 #---
 #Создание нового пользователя ( запуск от админа )
 $UserParam = @{
 PasswordNeverExpires = 1;
 UserMayNotChangePassword = 1;
 Password = (ConvertTo-SecureString -AsPlainText $Pass -Force);
 Name = $Uname;
 FullName = $FUname;
 Description = $Uinfo;
 }
 New-LocalUser @UserParam 
 
 Add-LocalGroupMember -Group "Пользователи" -Member $Uname

 #----Rename-Computer -NewName $PCNAME ----- PC naming
 
 #New-LocalUser -Name "Director" -Password (ConvertTo-SecureString -AsPlainText "PA$$WORD" -Force) -FullName "Иванов Иван Иванович" -Description "Директор филиала тел. 666" -PasswordNeverExpires 1 -UserMayNotChangePassword 0
 #;New-LocalUser $UserName -Password $Password -FullName $FIO -Description $Details
 #добавление пользоваетля в группу
 #Add-LocalGroupMember -Group "Пользователи" -Member "PotashnikovVA"
 #  Set-LocalUser -Name "PotashnikovVA" -PasswordNeverExpires 1 -UserMayChangePassword 0
 # 
 #Add-LocalGroupMember -Group "Administrators" -Member "ИМЯ_НОВОГО_ПОЛЬЗОВАТЕЛЯ"
 #---
 #переименование ПК.
 #;Rename-Computer -NewName $CompName
 ##  CMD STYLE ## wmic computersystem where name="%COMPUTERNAME%" call rename name="NAME"
 #---
 #Установка сетевых параметров.

 $ind = (Get-NetAdapter)[0].ifIndex
 Write-Host $ind

 if ((Get-NetIPInterface -InterfaceIndex (Get-NetAdapter)[0].ifIndex -AddressFamily IPv4).Dhcp -eq "Disabled") { echo "alala"  } else {}

 # добавление на 
 ;#Set-NetIPInterface -InterfaceAlias $Iface -Dhcp Disabled
 
 #$ipParams = @{
#InterfaceAlias $Iface
#InterfaceIndex = $ind
#IPAddress = "192.168.1.2"
#PrefixLength = 24
#AddressFamily = "IPv4"
#}
#New-NetIPAddress @ipParams
