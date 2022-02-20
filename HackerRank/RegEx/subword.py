import re as RegEx

s = ''

for _ in range(int(input())):
    s += input() + '\n'
s = s[:-1]

for _ in range(int(input())):
    q = input()
    p = r'\B' + q + r'\B'
    print(len(RegEx.findall(p,s)))