#批量fuzz测试多个url的脚本工具
import sys
import os
from urllib.parse import urlparse

file = sys.argv[1]
wordlist = sys.argv[2]

with open(file) as file_in:
    lines = []
    for line in file_in:
        lines.append(line.strip('\n'))
    for url in lines:
    	output = urlparse(url).netloc
    	cmd = os.system("ffuf -u {}/FUZZ -w {} -o {}".format(url,wordlist,output))
    	
out = os.system('cat *  | jq -r '"'"'.results[] |   "\(.length)"+ " " +"\(.url)" + " " +  "\(.status)"  '"'"' >> result.txt')
result = open("result.txt", "r")
print(result.read())
