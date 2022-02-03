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

languages = "C:CPP:JAVA:PYTHON:PERL:PHP:RUBY:CSHARP:HASKELL:CLOJURE:BASH:SCALA:ERLANG:CLISP:LUA:BRAINFUCK:JAVASCRIPT:GO:D:OCAML:R:PASCAL:SBCL:DART:GROOVY:OBJECTIVEC"
languages = languages.split(":");

for field in data:
    matches = (RegEx.findall(r"(\d+) (\w+)", field))[0];
    try:
        api_id = matches[0];
        api_id = int(api_id);
        assert api_id < 10**5 and api_id >= 10**4;

        language = matches[1];
        languages.index(language);
        print("VALID");
    except AssertionError:
        print("INVALID");
    except ValueError:
        print("INVALID");


    
