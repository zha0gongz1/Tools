## Linux/Macos小工具
### 1.[破解采用Bcrypt进行hash处理的密文](https://github.com/zha0gongz1/Tools/blob/main/Linux/Crack_BcryptHash.py)

使用方法：

``` python
#同级目录下，准备字典文件`pass.txt`、密文文件`hashed.txt`，运行如下命令即可：
python3 Crack_BcryptHash.py
```

<div align=left><img width="600" height="500" src="https://github.com/zha0gongz1/Tools/blob/main/Linux/Img/1.jpg" alt="demo1"/></div>

### 2.[内网web服务批量探测脚本](https://github.com/zha0gongz1/Tools/blob/main/Linux/httpscan.sh)

使用方法：

``` shell
./httpscan.sh [CIDR IP] [Thread,Default 4]
```



### 3.[子域名收集脚本](https://github.com/zha0gongz1/Tools/blob/main/Linux/.sh)

使用方法：

``` shell
#注：使用前，确保本地已经配置 subDomainsBrute、subfinder、oneforall、ksubdomain、gau、katana、nuclei 以及 nuclei-templates
./detect_subdomains.sh [domain.com]
```

### 4.[IP端口及web服务探测脚本](https://github.com/zha0gongz1/Tools/blob/main/Linux/detect_ipwebs.sh)

使用方法：

``` shell
#注：使用前，确保本地已经配置 dnsx、naabu、httpx、nuclei 以及 nuclei-templates
./detect_ipwebs.sh.sh [domain.com]
```

### 5.[CME工具RDP/SMB批量PTH脚本](https://github.com/zha0gongz1/Tools/blob/main/Linux/CME_BatchPTH.sh)

使用方法：

``` shell
#注：使用前，确保当前目录准备好cme工具、IP列表及收集的哈希值列表
./CME_BatchPTH.sh [mode]
```

### 5.[cmd5批量解密脚本](https://github.com/zha0gongz1/Tools/blob/main/Linux/DecCMD5.py)

场景：获取数据库用户数据后，批量解密cmd5值脚本

<div align=left><img width="700" height="400" src="https://github.com/zha0gongz1/Tools/blob/main/Linux/Img/hashes.jpg?raw=true" alt="demo3"/></div>

使用方法：

``` shell
#注：使用前，准备好hashes和password文件
python3 DecCMD5.py -H hashes.txt -p password.txt
```
