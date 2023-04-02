#!/bin/bash
#注：工具地址是绝对路径，适配个人机器需要更改！
#此脚本调用subDomainsBrute、subfinder、oneforall进行子域名收集工作，以及httpx、waybackurls检测爬取等工作，同级目录下生成三个文件

domain=$1

# 使用subDomainsBrute进行子域名枚举
echo -e "\033[5m\033[1;33m[+]Start processing subDomainsBrute...\033[0m"
python3 /home/kali/Tool/subDomainsBrute/subDomainsBrute.py  $domain -o subDomainsBrute.txt

# 使用subfinder进行子域名枚举
echo -e "\033[5m\033[1;33m[+]Start processing subfinder...\033[0m"
subfinder -d $domain -all -silent -o subfinder.txt

sleep 1
# 使用OneForAll进行子域名枚举
echo -e "\033[5m\033[1;33m[+]Start processing OneForAll...\033[0m"
python3 /home/kali/Tool/OneForAll/oneforall.py --target $domain --req False run

#结果处理
echo -e "\033[5m\033[0;36m[+]Start sorting results...\033[0m"
cat /home/kali/Tool/OneForAll/results/$domain.csv |awk -F ',' 'NR>1 {print $6}' | sort | uniq | tee oneforall.txt

sed -r 's/([0-9]{1,3}\.){3}[0-9]{1,3}//g' subDomainsBrute.txt > subDomainsBrute_new.txt | cat subDomainsBrute_new.txt subfinder.txt oneforall.txt | sort | uniq > $domain_subdoamin.txt
rm subDomainsBrute.txt subDomainsBrute_new.txt subfinder.txt oneforall.txt

# 使用httpx进行存活判断
echo -e "\033[5m\033[0;36m[+]Start judging the status...\033[0m"
cat $domain_subdoamin.txt | /home/kali/go/bin/httpx -silent --fc 0,502,400,405,410,503,504 -timeout 8  | cut -d '/' -f3 | sort -u | > $domain_active.txt

sleep 2
# waybackurls爬取url
echo -e "\033[5m\033[0;36m[+]Start fetching all the urls...\033[0m"
cat $domain_subdoamin.txt | /home/kali/go/bin/waybackurls | unfurl -u domains > $domain_waybackurls.txt
echo -e "\033[5m\033[1;36m[+]Success! Good luck!\033[0m"
