# This is the default .bashrc file.
# This stores some information to modify
# the appearance of the terminal and it
# loads all aliases. To sync this file, 
# the following command may be used:
#
#   cp $path_to_this_file ~/.bashrc


####################################### Start #######################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

B=$(tput bold)
I="\e[3m"
gr=$(tput setaf 2)
bl=$(tput setaf 4)
R=$(tput sgr0)

PS1='\['$B$gr'\]\u\['$R'\]:\['$B$bl'\]\w\['$R$I'\]\$ \['$R'\]'

if [ -e ~/.bashrc.aliases ] ; then
   source ~/.bashrc.aliases
fi

if [ -e ~/.bash_aliases ] ; then
   source ~/.bash_aliases
fi

# ---> Added by Cnchi RebornOS Installer Gnome based <--- #
BROWSER=/usr/bin/brave
EDITOR=/usr/bin/nano
# ---> End added by Cnchi RebornOS Installer Gnome based <--- #

######################################## End ########################################
