@echo off
:: 命令中/c会将后面参数/q识别为字符串！
cmd /q /c "REG ADD HKLM\SYSTEM\CurrentControlSet\Control\Terminal" "Server /v fDenyTSConnections /t REG_DWORD /d 00000000 /f"
cmd /q /c "netsh advfirewall firewall add rule name='Remote Desktop' protocol=TCP dir=in localport=3389 action=allow"
exit
