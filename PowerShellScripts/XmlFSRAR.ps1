# LINK powershell -windowstyle hidden -exec bypass -file "myscript.ps1"
Set-ExecutionPolicy RemoteSigned -Scope Process
#Set-ExecutionPolicy Unrestricted -Scope Process

# определение текущей даты в указанном формате
$date = Get-Date -Format "yyyy-MM-dd" #)ToString()


# формирование и запись файла xml для ФСРАР отчет о получении спирта
function CreateTicket ([int]$index, $date, [string]$TTN)
{

# создание объекта XML // -InformationAction SilentlyContinue - выключение дебага.
$WayBillTicket = New-Object Xml.XmlDocument -InformationAction SilentlyContinue
# Добавление XML заголовка
$WayBillTicket.AppendChild($WayBillTicket.CreateXmlDeclaration("1.0","UTF-8",$null))
# Создание пространства имён.
$nsMan = New-Object System.Xml.XmlNamespaceManager ($WayBillTicket.NameTable)
$nsMan.AddNamespace('xsi' , 'http://www.w3.org/2001/XMLSchema-instance')
$nsMan.AddNamespace('ns' , 'http://fsrar.ru/WEGAIS/WB_DOC_SINGLE_01')
$nsMan.AddNamespace('wa' , 'http://fsrar.ru/WEGAIS/ActTTNSingle_v3')
$nsMan.AddNamespace('ce' , 'http://fsrar.ru/WEGAIS/CommonV3')



# Формирование тела документа
$root = $WayBillTicket.CreateElement("ns:Documents",$nsMan.LookupNamespace("ns")) 
# добавление атрибута версии раздела Documents
$docattr = $root.OwnerDocument.CreateAttribute("Version") 
$docattr.Value = "1.0"
$root.Attributes.Append($docattr) 
#
$docattr = $root.OwnerDocument.CreateAttribute("xmlns:xsi")
$docattr.Value = 'http://www.w3.org/2001/XMLSchema-instance'
$root.Attributes.Append($docattr)

$docattr = $root.OwnerDocument.CreateAttribute("xmlns:ns")
$docattr.Value = 'http://fsrar.ru/WEGAIS/WB_DOC_SINGLE_01e'
$root.Attributes.Append($docattr)

$docattr = $root.OwnerDocument.CreateAttribute("xmlns:wa")
$docattr.Value = 'http://fsrar.ru/WEGAIS/ActTTNSingle_v3'
$root.Attributes.Append($docattr)

$docattr = $root.OwnerDocument.CreateAttribute("xmlns:ce")
$docattr.Value = 'http://fsrar.ru/WEGAIS/CommonV3'
$root.Attributes.Append($docattr)
#==




#Раздел владелец (содержит ИД ФСРАР)
$node = $WayBillTicket.CreateElement("ns:Owner",$nsMan.LookupNamespace("ns")) 
$ownernode = $root.AppendChild($node) 
#Непосредственно таг ФСРАР
$node = $WayBillTicket.CreateElement("ns:FSRAR_ID",$nsMan.LookupNamespace("ns")) 
$fsrar = $ownernode.AppendChild($node) 
$txtnode = $WayBillTicket.CreateTextNode("000000000000") 
$fsrar.AppendChild($txtnode)
# раздел основного документа
$node = $WayBillTicket.CreateElement("ns:Document",$nsMan.LookupNamespace("ns"))
$docnode = $root.AppendChild($node)
# подраздел накладной
$node = $WayBillTicket.CreateElement("ns:WayBillAct_v3",$nsMan.LookupNamespace("ns"))
$ticket = $docnode.AppendChild($node)
#заголовок
$node = $WayBillTicket.CreateElement("wa:Header",$nsMan.LookupNamespace("wa"))
$header = $ticket.AppendChild($node)
#содержание документа
$node = $WayBillTicket.CreateElement("wa:IsAccept",$nsMan.LookupNamespace("wa"))
$hnode = $header.AppendChild($node)
$txtnode = $WayBillTicket.CreateTextNode("Accepted")
$hnode.AppendChild($txtnode)
#-
$node = $WayBillTicket.CreateElement("wa:ACTNUMBER",$nsMan.LookupNamespace("wa"))
$hnode = $header.AppendChild($node)
$txtnode = $WayBillTicket.CreateTextNode($index)
$hnode.AppendChild($txtnode)
#-
$node = $WayBillTicket.CreateElement("wa:ActDate",$nsMan.LookupNamespace("wa"))
$hnode =  $header.AppendChild($node)
$txtnode = $WayBillTicket.CreateTextNode($date)
$hnode.AppendChild($txtnode)
#-
$node = $WayBillTicket.CreateElement("wa:WBRegId",$nsMan.LookupNamespace("wa"))
$hnode = $header.AppendChild($node)
$txtnode = $WayBillTicket.CreateTextNode($TTN)
$hnode.AppendChild($txtnode)
#-
$node = $WayBillTicket.CreateElement("wa:Note",$nsMan.LookupNamespace("wa"))
$hnode = $header.AppendChild($node)
$txtnode = $WayBillTicket.CreateTextNode("Ok!")
$hnode.AppendChild($txtnode)


#формирование xml-объекта
[void]$WayBillTicket.AppendChild($root) 

#Write-Host $WayBillTicket.InnerXml
$WayBillTicket.Save("./test.xml")  

return ,$WayBillTicket

}


function RegisterIncrement () {
#блок работы с реестром с сохранением номера документа подтверждения.
# читаем значение, если нет отправляем на обработку ошибок, если есть то инкремент и записываем обратно.
try {
 $reg = Get-ItemProperty -Path Registry::HKEY_CURRENT_USER\Environment\ -Name "spiritus" -ErrorAction Stop
 $index = $reg.spiritus
 [int]$index = [int]$index + 1
 #Write-Host "ДОКУМЕНТ НОМЕР " $index.ToString()
 Set-ItemProperty -Path Registry::HKEY_CURRENT_USER\Environment\ -Name "spiritus" -Value $index.ToString()
 return $index
 }
  catch  [System.Exception]  {
     # в случае отсуствия ключа реестра он создается с значением по умолчанию 19
     Write-Host "Отсутствует индексное значение в реестре!"
     $index = Read-Host "ВВедите индекс накладной"
     $index = $index / 1
   #Write-Host $Error[0].Exception
   New-ItemProperty -Path  Registry::HKEY_CURRENT_USER\Environment\ -Name "spiritus" -PropertyType String -Value $index.ToString() -InformationAction SilentlyContinue
   return $index
  } 
 #------------------------
  }

function GetTTN {
# получение полного имени файла по шаблону
try {
$wildcard = "FORM2REGINFO*.xml"
$filename = (Get-ChildItem -Path $PSScriptRoot -Filter $wildcard -File).Name
#--
#загрузка xml
[xml]$FORM = Get-Content $filename -ErrorAction Stop
}
catch [System.Exception] {
Write-Host "Ошибка чтения файла."
return 0
}
#$FORM = Select-Xml -Path $filename -XPath "Documents/Document/TTNInformF2Reg/Header/WBRegId"
#определение пространства имен
$namespace = New-Object System.Xml.XmlNamespaceManager ($FORM.NameTable)
$namespace.AddNamespace("wbr", $FORM.DocumentElement.wbr)
#получение номера транспортной накладной
$TTNname = ($FORM.SelectNodes("//wbr:Header",$namespace)).WBRegId
#write-host $TTNname.ToString()
return $TTNname.ToString()
}

#-XPath "/Documents/Document/TTNInformF2Reg/Header/WBRegId"

$TTN = GetTTN

if  ($TTN -eq "0" )  {
Write-Host  "Не найден файл с выгрузкой накладных FORM2REGINFO*.xml"
} else {

#Remove-Variable -Name index
$index = RegisterIncrement

if ($index -is [System.Array]) {
#Write-Host $index
$index = $index[0].spiritus
#Write-Host $index
}

Write-Host $filename
Write-Host ""
write-host "Документ № " $index
write-host "Дата создания " $date
write-host "Номер накладной " $TTN


# запуск функции формирования XML файла и его записи.

$index.GetType()

if ($index -isnot [int]) {
    $index = $index / 1
}


$index.GetType()

CreateTicket $index $date  $TTN 
#write-Host (CreateTicket ([int]$index)  $date  $TTN ).innerxml
Write-Host $filename
Write-Host ""
write-host "Документ № " $index
write-host "Дата создания " $date
write-host "Номер накладной " $TTN
Write-Host ""
Write-Host "Файл Сформирован"
pause
}

#=========================================================
#пример автоматического добавления ссылки на неймспейс.
#$xmlSub = $docnode.CreateTextNode("ns:FSRAR_ID",$nsMan.LookupNamespace("ns"))
#$lv2.AppendChild($xmlSub)
#-------------------------------------------------------------------------------------------------------


#$PCname = $env:COMPUTERNAME
#$HKCU = "2147483649"
#$reg = [wmiclass] "\\$PCname\root\default:StdRegProv"
#Name                                    Value
#HKEY_CLASSES_ROOT	  	2147483648
#HKEY_CURRENT_USER	  	2147483649
#HKEY_LOCAL_MACHINE	  	2147483650
#HKEY_USERS	  	2147483651
#HKEY_CURRENT_CONFIG	  	2147483653
#HKEY_DYN_DATA	  	2147483654
