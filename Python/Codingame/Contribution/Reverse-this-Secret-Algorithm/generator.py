import random
import string

a = []

msg = "Codingame is one of the most famous tech-recruiting platforms!".split()

alpha = string.ascii_letters 
alpha += string.digits 
alpha += string.punctuation
alpha += ' \t'

# for m in msg:
# 	s1 = " " * random.randint(0,20)
# 	s2 = " " * random.randint(0,20)
# 	a.append(s1 + m + s2)

# print(len(msg))
# print('\n'.join(a))


for _ in range(n := random.randint(12, 20)):
	m = ""
	s1 = " " * random.randint(0,400)
	s2 = " " * random.randint(0,400)
	for _ in range(20,40):
		m += random.choice(alpha)
	a.append(s1+m+s2)

print(n)
print('\n'.join(a))
