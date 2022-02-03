import re as RegEx;

data = [];
# Getting the input.
while True:
    try:
        data.append(input());
    except EOFError:
        break 

n = int(data.pop(0));
assert len(data) == n; 

IPv4 = r"^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$"
IPv6 = r"^([\da-fA-F]{1,4}\:){7}[\da-fA-F]{1,4}$"

for field in data:
    matchesv4 = (RegEx.search(IPv4, field));
    matchesv6 = (RegEx.search(IPv6, field));

    if matchesv4 != None:
        matches = (RegEx.findall(IPv4, field))[0]
        try:
            for match in matches:
                match = int(match)
                assert match <= 255
                assert match >= 0
            print("IPv4")
        except Exception as e:
            print("Neither")
            #raise e;
    elif matchesv6 != None:
        print("IPv6");
    else: 
        print("Neither")