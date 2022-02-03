import re as RegEx;

data = [];
# Getting the input.
while True:
    try:
        data.append(input());
    except EOFError:
        break 

n = int(data.pop(0));
assert n <= 100 and n >= 1;
assert len(data) == n; 

pattern = r"^[\.\_]\d+[A-Za-z]*_?$"

for field in data:
    matches = (RegEx.search(pattern, field));
    if matches != None:
        print("VALID");
    else:
        print("INVALID");