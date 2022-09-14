import bcrypt

def pingo(iteration,
          total,
          prefix='',
          suffix='',
          decimals=1,
          length=100,
          fill='█'):

    length = length - (len(prefix) + len(suffix) +10)
    iteration += 1
    percent = ("{0:." + str(decimals) + "f}").format(
        100 * (iteration/ float(total)))
    fillLength = int(length * iteration // total)
    bar = fill * fillLength + '-' * (length - fillLength-1)
    print('\r%s |%s| %s%% %s' % (prefix, bar, percent, suffix), end='\r')
    if iteration == total:
        print('')


pawd_file = open("pass.txt", "r", encoding="utf-8")
words = pawd_file.read().splitlines()

hashed_file = open("hashed.txt", "r", encoding="utf-8")
hashed = hashed_file.read().splitlines()

length = len(words)

correct_word = ""
found = 0
break_out_flag = False

for temp in hashed:
    hash = str(temp)
    print('Hash to crack: '+hash)
    for (index,word) in enumerate(words):
        correct = bcrypt.checkpw(word.encode('utf8'), hash.encode('utf8'))
        pingo(index, length, prefix='Wait:', suffix='Words complete from the list')
        if (correct):
            correct_word = word
            found += 1
            break
    if break_out_flag:
        break
        
    if (found == 1):
            print("\n\033[92m[+]Congratulations!Password found!\033[0m")
            print("\033[92m[*]Results:", correct_word+'\033[0m\n')
            found = 0
            
    else:
            print("\033[91m[-]Unfortunately, password not found.\033[0m\n")
