# Usage: python3 Multi_targets_detect_subdomains.py
import subprocess

with open('domains.txt', 'r') as file:
    domains = file.readlines()

for domain in domains:
    domain = domain.strip() 
    if domain:
        print(f"Executing: ./detect_subdomains.sh {domain}")

        result = subprocess.run(['./detect_subdomains.sh', domain], capture_output=True, text=True)
        
        if result.returncode == 0:
            print(f"Success: {result.stdout}")
        else:
            print(f"Error: {result.stderr}")
