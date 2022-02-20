N = int(input())

for i in range(N):

	s = input().strip()
	b = ""
	for c in list(s):
		b += hex(ord(c))[2:]
	print(int(b,16))