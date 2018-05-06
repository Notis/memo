@ECHO OFF
   
REM echo            Без кавычек : %~1 
REM echo     Полное имени файла : %~f1
REM echo       Только имя диска : %~d1
REM echo    Только путь к файлу : %~p1
REM echo       Только имя файла : %~n1
REM echo Расширение имени файла : %~x1
REM echo     Путь в формате 8.3 : %~s1
REM echo               Атрибуты : %~a1
REM echo    Даты /времени файла : %~t1
REM echo          Размера файла : %~z1
REM echo               Венегрет : %~ztasxnpdf1

REM ECHO %~n1_%~x1
REM ECHO %2
REM ECHO %*
====================
REM reduce to 720
if "%3"=="720" (set Scale=-vf scale=-1:720) else (set Scale=)
REM set videobitrate
if "%2"=="" (set BR=3000) else (set BR=%2)
set VBR=-b:v %BR%k
==================
REM main
ECHO ffmpeg.exe -hide_banner -i %1 %Scale% -c:v h264_nvenc -preset slow -tune film %VBR% -pass 1 -c:a aac -b:a 128k -f mp4 NUL
ECHO ffmpeg.exe -hide_banner -i %1 %Scale% -c:v h264_nvenc -preset slow -tune film %VBR% -pass 2 -c:a aac -b:a 128k -f mp4 %~n1_%~x1
