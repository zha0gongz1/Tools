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


text_file = open("pass.txt", "r", encoding="utf8")
words = text_file.read().splitlines()

hash = input('Hash to crack: ')

length = len(words)

correct_word = ""
found = 0
for (index,word) in enumerate(words):
	
	correct = bcrypt.checkpw(word.encode('utf8'), hash.encode('utf8'))
	pingo(index, length, prefix='Wait:', suffix='Words complete from the list')
	if (correct):
		correct_word = word
		found += 1
		break

if (found == 1):
    print("\n[+]Password found!")
    print("[*]Results:", correct_word)
else:
    print("\n[-]Unfortunately, password not found.")
