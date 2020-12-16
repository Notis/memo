rundll32.exe keymgr.dll, KRShowKeyMgr					Менеджер сохраненных паролей
%windir%\system32\control.exe /name Microsoft.NetworkAndSharingCenter	Сетевые подключения
certmgr.msc -  управление сертификатами
appwiz.cpl
===============
очистка кеша иконок.

Для Windows 7 и Windows Server 2008 R2

tasklist

taskkill /im explorer.exe /f

cd %userprofile%\appdata\local
attrib -h IconCache.db
del IconCache.db
explorer


Для Windows 8.1 и Windows Server 2012 R2, 2016

taskkill /im explorer.exe /f

cd /d %userprofile%\AppData\Local\Microsoft\Windows\Explorer
del /f /a s IconCache*
explorer
-----------------------
Запуск в безопасном режиме
bcdedit /set {current} safeboot network
shutdown.exe /r /o /f / t 00

---------------------

wmic memorychip get capacity

-----------------------
HKEY_LOCAL_MACHINE \ SOFTWARE \ Microsoft \ Windows NT \ CurrentVersion \ ProfileList \ SID используемого вами профиля \ ProfileImagePath \ Путь к профилю (D:\Users\userolen)


(Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey - get product key

вызов окна смены пароля на vbs.
>>>
set objShell = CreateObject("shell.application")
objshell.WindowsSecurity
>>>
-

------------------------------
	iconv
Get-Content -Encoding oem .\Desktop\sysinfoall.log > .\Desktop\syslog.txt
----------------------------------

psexec @computers.txt /u USER /p PASS cmd.exe /v /c ""systeminfo | find "KB4012212" || echo !computername! >> \\server\share\log.txt"""
psexec64.exe @ps3.txt -u admin -p pass -n 5 cmd.exe /v /c ""systeminfo >> \\net\sys.log""

----------------------------------
parse like awk
Get-Content .\pc.txt | foreach {($_ -split '\s+',4)[0]}  > pc3.txt
-------

wmic memorychip get capacity /format:VALUE && wmic os get caption /format:value

------------GET PCNAME from export DHCP.service
 Get-Content .\pc.txt | foreach {($_ -split '\s+',4)[1]} | foreach {$_ -replace ".local.global.ru", ""} | Out-File -FilePath ".\pcname.txt" -Encoding default

cat ./pcname
------------
--exclude XP machines
Get-Content .\pcname.txt | Where-Object { $_ -notmatch "^*\.$" }
-----------
___ GET  FROM LIST ___
wmic /FAILFAST:ON /node:@pcname.txt /user:admin /password:$ekReT os get caption
__GET MEM
wmic


#==== создание службы >> пробелы важны после равно <<
sc create CommFortChat binPath= "C:\Program Files\CommFort_server\CommFort_server.exe" DisplayName= "CommFortServer Service" type= own start= auto


---------------------------
CERTEFICATES
    Install openssl package (if you are using Windows, download binaries here).

    Generate private key: openssl genrsa 2048 > private.pem
    Generate the self signed certificate: openssl req -x509 -days 1000 -new -key private.pem -out public.pem

    If needed, create PFX: openssl pkcs12 -export -in public.pem -inkey private.pem -out mycert.pfx

==================

    w32tm /register — Регистрация и включение службы со стандартными параметрами.
    w32tm /unregister — Отключение службы и удаление параметров конфигурации.
    w32tm /monitor — Просмотр информации по домену.
    w32tm /resync — Команда принудительной синхронизации с заданным в конфигурации источником.
    w32tm /config /update — Применить и сохранить конфигурацию.
    w32tm /config /syncfromflags:domhier /update – Задаем настройку синхронизации с контроллером домена.
    w32tm /config /syncfromflags:manual /manualpeerlist:time.windows.com – задать конкретные источники синхронизации времени по протоколу NTP.

Просмотр параметров (/query)

    w32tm /query /computer:<target>  — Информация о стутусе синхронизации определенной станции (если имя не указано — используется локальный компьютер).
    w32tm /query /Source – Показать источник времени.
    w32tm /query /Configuration — Вывод всех настроек службы времени Windows.
    w32tm /query /Peers – Показать источники времени и их состояние.
    w32tm /query /Status – Статус службы времени.
    w32tm /query /Verbose – Подробный вывод всей информации о работе службы.
==================


select user,value from test_base  where store="pep_urn:xmpp:vcard4" and user like "%username";
update test_base set value = REGEXP_REPLACE(value, '<tel><uri>.*</uri>', '<tel><uri>tel:1111</uri>') where user like "%username%";


==========
языки и службы текстового ввода.
Rundll32 Shell32.dll,Control_RunDLL input.dll,,{C07337D3-DB2C-4D0B-9A93-B722A6C106E2}


--------------
DND is stored in the asterisk DB. To switch off DND for extension 1000, for example, you would type at the asterisk CLI:
database del DND 1000

-------------


Unfortunately this will not update the DND hints so things like BLFs
 will not work properly unless you figure out how to change the hints via CLI.
 Not sure this is the best way to do this, but it works:

devstate change Custom:DND201 INUSE devstate change Custom:DND201 NOT_INUSE


////////LDAP
ldapsearch -h dc.local.global.ru -p 389 -LLL -b "OU=Пользователи,DC=local,DC=global,DC=ru" -s sub "(objectClass=person)" -U jabber sAMAccountName cn memberOf   | perl -MMIME::Base64 -n -00 -e 's/\n +//g;s/(?<=:: )(\S+)/decode_base64($1)/eg;print'


Get-ADUser -SearchBase "OU=04. Local,OU=SSH users,OU=Users,OU=Global,DC=gdcname,DC=global,DC=ru" -filter {En abled -eq $True} -properties * | select SamAccountName, name ,UserPrincipalName | Export-csv -path "S:\Userlist.csv" -Encoding UTF8

///LDAP_OTHER_SERVER

$secpasswd = ConvertTo-SecureString "PlaintextPassword" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("USER", $secpasswd)
Get-ADUser -Server "1.2.3.4" -Credential $mycreds  -SearchBase "OU=name1,OU=name2,OU=name3,OU=name4,DC=dcname,DC=gloabl,DC=ru" -filter {Enabled -eq $True} -properties * | export-csv -path "C:\TMP\FILE.csv" -Encoding UTF8
--==SELECT---0
Get-ADUser -Server "1.2.3.4" -Credential $mycreds  -SearchBase "OU=name1,OU=name2,OU=name3,OU=name4,DC=dcname,DC=global,DC=ru" -filter {Enabled -eq $True} -properties * |Select DisplayName, Name,mail,Department,title,EmailAddress,SID,homeMDB,ObjectCategory | Export-Csv -Path "C:\ldap_selected.csv" -Encoding UTF8
==

----

//// найти адрес КД
nslookup
set type=all
_ldap._tcp.dc._msdcs.DOMAIN_NAME

//// запуск PowerSell в скрытом режиме

powershell.exe -nologo -noninteractive -windowStyle hidden -command ?C:\Temp\hello.ps1?

////|

Boot UEFI USB
mount E: - WindowsInstall.iso
usbflash M:

diskpart.exe
	list disk
	select disk %DES%
	clean
	convert gpt
	create partition primary
	# if more then 16Gb # create partition primary size=16000
	format fs=FAT32 quick
	#optional# assign letter=M
	exit
xcopy e:\* m:\ /H /F /E

dism /Split-Image /ImageFile:e:\sources\install.wim /SWMFile:m:\sources\install.swm /FileSize:4096

-------------

#выборка из DNS зоны local.global.ru A статичных записей.
Get-DnsServerResourceRecord -ZoneName local.global.ru -RRType A | Where-Object Timestamp -EQ $NULL


#Выборка пользователей ....
Get-ADUser -SearchBase "DC=st,DC=local,DC=ru" -filter {Enabled -eq $True} -properties *


#узнать сколько памяти на ПК
wmic memorychip list Capacity

---
принудительная синхронизация AD
repadmin /syncall <server.name0>
repadmin /syncall <server.name1>
repadmin /syncall <server.name2>


-----------powershell проверка сетевого подключения 
tnc pc-name [-Port <1-65535>]
-=---
	Тестирование выборок wmi
c:\Windows\System32\wbem>wbemtest.exe
---
--powershell работа с файрволом
 Get-NetFirewallRule -name 'WMI-*-In-TCP'
--powershell
Enable-NetFirewallRule -Name 'WMI-*-In-TCP'
Disable-NetFirewallRule -Name 'WMI-*-In-TCP'

---powershell работа с сервисами
get-service -Name 'dcomlaunch','RpcSs'



----------
:: информация об образах для установки нужен MS windows setup
dism /get-imageinfo /imagefile:D:\TFTP\DIR\sources\boot.wim
:: монтирование wim файла в папку
dism /mount-wim /wimfile:d:\TFTP\DIR\sources\boot.wim /index:2 /mountdir:D:\WIM
:: добавление драйверов в wim файл
dism.exe /image:D:\WIM /Add-Driver /Driver:d:\TMP\DRIVERS\Realtek_LAN_Driver_Win10\64 /Recurse
:: сохраниение wim файла !!!не должен быть занят!!!
dism.exe /unmount-wim /mountdir:D:\WIM /commit

----------------
# выбор имен компов из домена с именем A3*
(Get-ADComputer -SearchBase "DC=company,DC=local,DC=ru" -Filter 'Name -like "A3*"').name 

