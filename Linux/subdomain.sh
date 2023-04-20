#!/bin/bash
######################################################################
#注：工具地址是绝对路径，适配个人机器需要更改！
# Requirements:
# -------------------------------------------------------------------
# subDomainsBrute
# subfinder
# oneforall
# gau
# nuclei && nuclei-templates
######################################################################

domain=$1
touch NewSubDomainsBrute.txt oneforall.txt subfinder.txt
# 使用subDomainsBrute进行子域名枚举
echo -e "\033[5m\033[1;33m[+]Start processing subDomainsBrute...\033[0m"
python3 /root/subDomainsBrute/subDomainsBrute.py  $domain -o subDomainsBrute.txt

# 使用subfinder进行子域名枚举
echo -e "\033[5m\033[1;33m[+]Start processing subfinder...\033[0m"
subfinder -d $domain -all -silent -o subfinder.txt

sleep 1
# 使用OneForAll进行子域名枚举
echo -e "\033[5m\033[1;33m[+]Start processing OneForAll...\033[0m"
python3 /root/OneForAll/oneforall.py --target $domain --req False run

#子域结果处理
echo -e "\033[5m\033[0;36m[+]Start sorting results...\033[0m"
cat /root/OneForAll/results/$domain.csv |awk -F ',' 'NR>1 {print $6}' | sort | uniq | tee oneforall.txt

sed -r 's/([0-9]{1,3}\.){3}[0-9]{1,3}//g' subDomainsBrute.txt > NewSubDomainsBrute.txt | cat NewSubDomainsBrute.txt subfinder.txt oneforall.txt | sort | uniq > $domain-subdoamin.txt

sleep 1
# GAU
echo -e "\033[5m\033[0;36m[+]Start fetching all the urls...\033[0m"
#cat $domain_subdoamin.txt | /home/kali/go/bin/waybackurls | /home/kali/go/bin/unfurl -u domains > $domain_waybackurls.txt
cat $domain-subdoamin.txt | gau --threads 50 > $domain-gau.txt
rm subDomainsBrute.txt NewSubDomainsBrute.txt subfinder.txt oneforall.txt

# Nuclei
echo -e "\033[5m\033[0;36m[+]Start detecting vulns...\033[0m"
nuclei -t /root/nuclei-templates/ -severity critical,high,medium,low -l $domain-subdoamin.txt -bs 50 -c 50 -rl 120 -nc -o $domain-nuclei-res.txt

echo -e "\033[5m\033[1;36m[+]Success! Good luck!\033[0m"
