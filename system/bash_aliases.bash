# This is a bash file that is executed
# everytime a terminal session is started.
# Thus, it can be mainly used to make custom 
# commands. To sync this file, the following
# command may be used:
#
#   cp $path_to_this_file ~/.bash_aliases

####################################### Start #######################################
function coding() {
	cd ~/Documents/Coding/$1
}

function compiled() {
	cd ~/Documents/Compiled/$1
}

function brainfuck() {
	lua ~/Documents/Coding/Lua/brainfInterpreter.lua "$@"
}

function urlencode() {
    # urlencode <string>

    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c";;
            *) printf '%%%02X' "'$c";;
        esac
    done
    echo
    LC_COLLATE=$old_lc_collate
}

function urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
    echo
}

alias bf=brainfuck $@
alias brainf=brainfuck $@
alias brainfuck=brainfuck $@
alias py=python $@


######################################## End ########################################