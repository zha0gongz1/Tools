@echo off
set "folder=C:\ProgramData\Microsoft\Windows" "Defender\Scans\History\Service\DetectionHistory"
if not exist "%folder%" (echo;"%folder%" no found&goto end)
if "%folder:~-1%" equ "\" (set "folder=%folder:~,-1%")
(forfiles /p %folder% /s /d %date:~0,10% /c "cmd /c echo @path-@fdate-@ftime >C:\Temp\record.txt"
forfiles /p %folder% /s /d %date:~0,10% /c "cmd /c del /q @file"
::如果只显示目录名，则为空文件夹，说明最新记录文件已删除
forfiles /p %folder% /s /d %date:~0,10% /c "cmd /c echo @file" 
)
exit
