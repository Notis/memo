@ECHO OFF
   
REM echo            ��� ������� : %~1 
REM echo     ������ ����� ����� : %~f1
REM echo       ������ ��� ����� : %~d1
REM echo    ������ ���� � ����� : %~p1
REM echo       ������ ��� ����� : %~n1
REM echo ���������� ����� ����� : %~x1
REM echo     ���� � ������� 8.3 : %~s1
REM echo               �������� : %~a1
REM echo    ���� /������� ����� : %~t1
REM echo          ������� ����� : %~z1
REM echo               �������� : %~ztasxnpdf1

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
