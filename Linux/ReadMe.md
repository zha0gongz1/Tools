## Linux/Macos小工具
### 1.[破解采用Bcrypt进行hash处理的密文](https://github.com/zha0gongz1/Tools/blob/main/Linux/Crack_BcryptHash.py)

使用方法：

同级目录下，准备字典文件`pass.txt`、密文文件`hashed.txt`，运行如下命令即可：

``` python
python3 Crack_BcryptHash.py
```

<div align=left><img width="600" height="500" src="https://github.com/zha0gongz1/Tools/blob/main/Linux/Img/1.jpg" alt="demo1"/></div>

### 2.[内网web服务批量探测脚本](https://github.com/zha0gongz1/Tools/blob/main/Linux/httpscan.sh)

使用方法：

``` shell
./httpscan.sh [CIDR IP] [Thread,Default 4]
```

<div align=left><img width="700" height="400" src="https://github.com/zha0gongz1/Tools/blob/main/Linux/Img/httpscan.jpg?raw=true" alt="demo2"/></div>

### 3.[子域名收集脚本](https://github.com/zha0gongz1/Tools/blob/main/Linux/.sh)

使用方法：

``` shell
#注：使用前确保本地已经配置 subDomainsBrute、subfinder、oneforall、ksubdomain、gau、katana、nuclei 以及 nuclei-templates
./detect_subdomains.sh [domain.com]
```

### 4.[IP端口及web服务探测脚本](https://github.com/zha0gongz1/Tools/blob/main/Linux/detect_ipwebs.sh)

使用方法：

``` shell
#注：使用前确保本地已经配置 dnsx、naabu、httpx、nuclei 以及 nuclei-templates
./detect_ipwebs.sh.sh [domain.com]
```
