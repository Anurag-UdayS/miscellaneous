# This is the default .bashrc file for root.
# This stores some information to modify
# the appearance of the terminal and it
# loads all aliases. To sync this file, 
# the following command may be used:
#
# cp $path_to_this_file /root/.bashrc


####################################### Start #######################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

B=$(tput bold)
I="\e[3m"
R=$(tput sgr0)

r=$(tput setaf 1)
gr=$(tput setaf 2)
bl=$(tput setaf 4)
o="\e[38;5;208;165m"

PS1='\['$r'\]\u\['$R'\]:\['$B$o'\]\w\['$R$I'\]\$ \['$R'\]'

if [ -e ~/.bashrc.aliases ] ; then
   source ~/.bashrc.aliases
fi


######################################## End ########################################