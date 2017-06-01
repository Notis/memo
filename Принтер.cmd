net stop spooler
del /F /q  %SYSTEMROOT%\system32\spool\PRINTERS\*.*
net start spooler