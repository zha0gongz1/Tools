#!/bin/bash
######################################################################
#注：工具地址是绝对路径，适配个人机器需要更改！
# Requirements:
# -------------------------------------------------------------------
# subDomainsBrute
# subfinder
# oneforall
# ksubdomain
# gau
# katana
# nuclei && nuclei-templates
# -------------------------------------------------------------------
# Output:$domain-subdoamin.txt && $domain-links.txt && $domain-nuclei-res.txt
######################################################################
domain=$1
touch NewSubDomainsBrute.txt oneforall.txt subfinder.txt ksubdomain.txt

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

# 使用Ksubdomain进行子域名枚举
ksubdomain e -d $domain --silent --only-domain --skip-wild -o ksubdomain.txt

#子域结果处理
echo -e "\033[5m\033[0;36m[+]Start sorting results...\033[0m"
cat /root/OneForAll/results/$domain.csv |awk -F ',' 'NR>1 {print $6}' | sort | uniq | tee oneforall.txt
sed -r 's/([0-9]{1,3}\.){3}[0-9]{1,3}//g' subDomainsBrute.txt > NewSubDomainsBrute.txt | cat NewSubDomainsBrute.txt subfinder.txt oneforall.txt ksubdomain.txt| sort | uniq > $domain-subdoamins.txt

# 链接爬取
# gau
echo -e "\033[5m\033[0;36m[+]Start fetching all the urls...\033[0m"
#cat $domain_subdoamin.txt | /home/kali/go/bin/waybackurls | /home/kali/go/bin/unfurl -u domains > $domain_waybackurls.txt
cat $domain-subdoamins.txt | gau --threads 50 > $domain-gau.txt
sleep 1
#Katana
cat $domain-subdoamins.txt | katana -iqp -kf all > $domain-katana.txt
sleep 1
cat $domain-katana.txt $domain-gau.txt | sort | uniq > $domain-links.txt

rm subDomainsBrute.txt NewSubDomainsBrute.txt subfinder.txt oneforall.txt ksubdomain.txt $domain-gau.txt $domain-katana.txt

# Nuclei
echo -e "\033[5m\033[0;36m[+]Start detecting vulns...\033[0m"
nuclei -t /root/nuclei-templates/ -severity critical,high,medium,low -l $domain-subdoamins.txt -bs 30 -c 30 -rl 120 -nc -o $domain-nuclei-res.txt

echo "Runtime: $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo -e "\033[5m\033[1;36m[+]Success! Good luck for penetration! \033[0m"
