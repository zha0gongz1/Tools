import argparse
import hashlib
from concurrent.futures import ThreadPoolExecutor

def crack_md5_hash(hash_file, wordlist, num_threads):
    with open(hash_file, 'r') as f:
        lines = f.read().splitlines()
    hashes = []
    emails = []
    for line in lines:
        parts = line.split()
        for part in parts:
            if len(part) == 32:
                try:
                    int(part, 16)
                    hashes.append(part)
                except ValueError:
                    pass
            else:
                emails.append(part)
    with open(wordlist, 'r') as f:
        words = f.read().splitlines()

    def crack_hash(hash, email):
        for word in words:
            if hashlib.md5(word.encode()).hexdigest() == hash:
                print(f'{hash} : {word} : {email}')
                return

    with ThreadPoolExecutor(max_workers=num_threads) as executor:
        executor.map(crack_hash, hashes, emails)

parser = argparse.ArgumentParser()
parser.add_argument('-p', '--password-file', required=True, help='Path to password file')
parser.add_argument('-H', '--hash-file', required=True, help='Path to hash file')
args = parser.parse_args()

crack_md5_hash(args.hash_file, args.password_file, 10)
