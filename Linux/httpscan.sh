#!/bin/bash
#Intranet web service detection.
#Author:zha0gongz1@影

# 最大进程数
if [ $# -ge 2 ]
then
	PROCESS_NUM=${2}
else
	PROCESS_NUM=4
fi

main(){
	output=$BASE_IP"_result"
	status_code=$(curl -H 'Accept-Language: en-US,en;q=0.5' -A 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; Touch; rv:11.0) like Gecko' -I -s -m 6 http://$subip:80/ | grep HTTP/ | awk {'print $2'})
	#echo $status_code
	title=$(curl -H 'Accept-Language: en-US,en;q=0.5' -A 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; Touch; rv:11.0) like Gecko' -L -s -m 10 http://$subip:80/ | grep -iPo '(?<=<title>)(.*)(?=</title>)')
	if [[ "$status_code" -ge 200 ]]; then
  		echo -e "\033[92m[+]"$subip" status_code:"$status_code"\033[0m"
		echo -e "IP:"$subip"\t||status_code:"$status_code"\t||web_title:"$title >>$output
	#else
  		#echo -e "\033[91m[-]"$subip" not exist web service\033[0m"
	fi

}


FIFO_FILE=/tmp/$$.fifo
mkfifo $FIFO_FILE


exec 6<>$FIFO_FILE      # 将fd6指向fifo类型
rm $FIFO_FILE

for((idx=0;idx<${PROCESS_NUM};idx++))
do
	echo >&6
done



BASE_IP=${1%/*}	#get IP
IP_CIDR=${1#*/} #get CIDR value


if [ ${IP_CIDR} -lt 8 ]; then
    echo "The maximum range is /8."
    exit
fi

IP_MASK=$((0xFFFFFFFF << (32 - ${IP_CIDR})))

IFS=. read a b c d <<<${BASE_IP}

ip=$((($b << 16) + ($c << 8) + $d))

ipstart=$((${ip} & ${IP_MASK}))

ipend=$(((${ipstart} | ~${IP_MASK}) & 0x7FFFFFFF))

seq ${ipstart} ${ipend} | while read i; do
	read -u6
	{
		subip=$a.$((($i & 0xFF0000) >> 16)).$((($i & 0xFF00) >> 8)).$(($i & 0x00FF))
		main $subip $BASE_IP
		echo >&6 
	}&

	
done

wait


# 关闭fd6
exec 6<&-
exec 6>&-

sleep 10
echo -e "\033[36mThe detection has been completed,Good luck!\n\t\t\t By zha0gongz1@影\033[0m"
