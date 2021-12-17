# This is a bash file that is executed
# everytime a terminal session is started.
# Thus, it can be mainly used to make custom 
# commands. To sync this file, the following
# command may be used:
#
#   cp $path_to_this_file ~/.bash_aliases

####################################### Start #######################################
function Coding() {
	cd ~/Documents/Coding/$1
}

function Compiled() {
	cd ~/Documents/Compiled/$1
}

function Brainfuck() {
	lua ~/Documents/Coding/Lua/brainfCompiler.lua "$@"
}

alias coding=Coding $@
alias compiled=Compiled $@
alias bf=Brainfuck $@
alias brainf=Brainfuck $@
alias brainfuck=Brainfuck $@


######################################## End ########################################