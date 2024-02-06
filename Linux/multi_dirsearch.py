import argparse
import sys
import signal
import subprocess

parser = argparse.ArgumentParser()
parser.add_argument('-f', '--file', help='The file with URLs to scan')

args = parser.parse_args()
if args.file is None:
    parser.print_help()
    sys.exit(0)

with open(args.file, 'r') as f:
    urls = [line.strip() for line in f]

def signal_handler(sig, frame):
    #接收到SIGINT信号时，结束子进程
    if p:
        p.terminate()
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

for url in urls:
    #根据不同需求更改此处执行！
    p = subprocess.Popen(f"python3 dirsearch.py -u {url} --random-agent -F", shell=True)
    p.wait()
