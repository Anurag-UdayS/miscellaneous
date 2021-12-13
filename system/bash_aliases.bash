function Coding() {
	cd ~/Documents/Coding/$1
}

function Compiled() {
	cd ~/Documents/Compiled/$1
}

alias coding=Coding $@
alias compiled=Compiled $@