Set-ExecutionPolicy RemoteSigned -Scope Process

$Uname = "Director"
$Pass = "PA$$WORD"
$FUname = "������ ���� ��������"
$Uinfo = "�������� ������� ���. 666"


#$PPAS = Read-Host -AsSecureString
 #read user password
 #;Password = Read-Host -AsSecureString
 #---
 #�������� ������ ������������ ( ������ �� ������ )
 $UserParam = @{
 PasswordNeverExpires = 1;
 UserMayNotChangePassword = 1;
 Password = (ConvertTo-SecureString -AsPlainText $Pass -Force);
 Name = $Uname;
 FullName = $FUname;
 Description = $Uinfo;
 }
 New-LocalUser @UserParam 
 
 Add-LocalGroupMember -Group "������������" -Member $Uname

  #----Rename-Computer -NewName $PCNAME ----- PC naming

 $ind = (Get-NetAdapter)[0].ifIndex
 Write-Host $ind

 if ((Get-NetIPInterface -InterfaceIndex (Get-NetAdapter)[0].ifIndex -AddressFamily IPv4).Dhcp -eq "Disabled") { echo "alala" } else {}


 pause

 #192.168.20.112 - �������� ip

#mask 255.255.252.0
#GW   192.168.22.217
#DNS 192.168.20.2



 # ���������� �� 
 ;#Set-NetIPInterface -InterfaceAlias $Iface -Dhcp Disabled
 
 #$ipParams = @{
#InterfaceAlias $Iface
#InterfaceIndex = $ind
#IPAddress = "192.168.20.22"
#PrefixLength = 24
#AddressFamily = "IPv4"
#}
#New-NetIPAddress @ipParams
