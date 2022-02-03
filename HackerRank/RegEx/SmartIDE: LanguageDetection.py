import re as RegEx

data = "";
# Getting the input.
while True:
    try:
        data += input();
    except EOFError:
        break

if (RegEx.match(r"public static .+ main(.*)\s+{", data)
or RegEx.match(r"import java.+", data)
or RegEx.match(r"class .+", data)
or RegEx.match(r"System.+")):
    print("Java")
elif RegEx.match(r"(?:int|void) main(.*)\s+{", data):
    print("C")
else:
    print("Python")