#!/bin/bash
#注：工具地址是绝对路径，适配个人机器需要更改！
#此脚本调用subDomainsBrute、subfinder、oneforall进行子域名收集工作，同级目录下生成结果文件

domain=$1
output=$2

# 使用subDomainsBrute进行子域名枚举
echo -e "\033[5m\033[1;33m[+]start processing subDomainsBrute...\033[0m"
python3 /home/kali/Tool/subDomainsBrute/subDomainsBrute.py  $domain -o subDomainsBrute.txt

# 使用subfinder进行子域名枚举
echo -e "\033[5m\033[1;33m[+]start processing subfinder...\033[0m"
subfinder -d $domain -all -silent -o subfinder.txt

sleep 1
# 使用OneForAll进行子域名枚举
echo -e "\033[5m\033[1;33m[+]start processing OneForAll...\033[0m"
python3 /home/kali/Tool/OneForAll/oneforall.py --target $domain --req False run

#结果处理
echo -e "\033[5m\033[0;34m[+]start processing results...\033[0m"
cat /home/kali/Tool/OneForAll/results/$domain.csv |awk -F ',' 'NR>1 {print $6}' | sort | uniq | tee oneforall.txt

sleep 1

sed -r 's/([0-9]{1,3}\.){3}[0-9]{1,3}//g' subDomainsBrute.txt > subDomainsBrute_new.txt | cat subDomainsBrute_new.txt subfinder.txt oneforall.txt | sort | uniq > $output
rm subDomainsBrute.txt subDomainsBrute_new.txt subfinder.txt oneforall.txt
