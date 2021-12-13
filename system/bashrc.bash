#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\e[1;2;31m[\@] \e[0m\e[1;32m\u@\e[1;32m\H\e[0m:\e[1;34m\w\e[0m\e[3m$\e[0m '

if [ -e ~/.bashrc.aliases ] ; then
   source ~/.bashrc.aliases
fi

if [ -e ~/.bash_aliases ] ; then
   source ~/.bash_aliases
fi


# ---> Added by Cnchi RebornOS Installer Gnome based <--- #
BROWSER=/usr/bin/firefox
EDITOR=/usr/bin/subl
# ---> End added by Cnchi RebornOS Installer Gnome based <--- #
