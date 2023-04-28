#!/bin/bash
######################################################################
# IP Ports Detect and web title
# Requirements:
# -------------------------------------------------------------------
# dnsx
# naabu
# httpx
# nuclei && nuclei-templates
# -------------------------------------------------------------------
# Output:$domain-ips.txt && $domain-ip-ports.txt && $domain-ipactives.txt && $domain-ip-webs.txt && $domain-ipweb-nuclei-res.txt
######################################################################
domain=$1

echo -e "\033[5m\033[1;33m[+]Start parsing IP address...\033[0m"
#asnmap -d $domain | naabu -exclude-cdn -pts 100 -o test2 -rate 5000 -p -
#asnmap -d $domain | naabu -exclude-cdn -timeout 500 -pts 100 -rate 10000 -silent -o $domain-ip-ports.txt
dnsx -l $domain-subdoamin.txt -silent -a -resp | sed -r 's/.*\[([0-9]{1,3}(\.[0-9]{1,3}){3})\].*/\1/' > $domain-ips.txt	#可以尝试HOST碰撞测试,本脚本中不做任何操作

echo -e "\033[5m\033[1;33m[+]Start detecting ports...\033[0m"
cat $domain-ips.txt | sort | uniq | naabu -exclude-cdn -timeout 800 -pts 100 -rate 8000 -silent -top-ports 1000 -o $domain-ip-ports.txt

echo -e "\033[5m\033[1;33m[+]Start detecting WebTitle...\033[0m"
cat $domain-ip-ports.txt | httpx -title -tech-detect -status-code -probe -cname -location -http2 -t 100 -nc -o $domain-ipactives.txt | grep -oP '.*(?=\[SUCCESS\])' > $domain-ip-webs.txt

nuclei -t /root/nuclei-templates/ -severity critical,high,medium,low -ept ssl -l $domain-ip-webs.txt -bs 30 -c 40 -rl 120 -nc -o $domain-ipweb-nuclei-res.txt

echo "Runtime: $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo -e "\033[5m\033[1;36m[+]Success! Good luck for penetration! \033[0m"
