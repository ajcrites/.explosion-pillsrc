# FUNCTIONS BY - ajcrites (Andrew Crites)
# Copyright 2010-2012

#Does: Makes a dir and cds into it
#Used: Shorthand for making a directory whose contents you immediately want to edit
#Note: See /home/ajcrites/.bash_aliases /mkdirs -- better than into && into..
function into() {
   mkdirs $@ && cd $@
}

#Does: See if a file exists and is readable
#Used: to check existence of a file
function see {
   test -r $1 && echo "File exists"
}

#Does: create a feature branch in git with required info
#Used: to create such a branch
function gfs {
   git flow feature start $(date +%m%d%y)_$@
}

#Does: search history
#Used: to search history for the command
function hs {
    noglob fc -l -m "$1*" 1
    noglob fc -l -m "sudo $1*" 1
}

#Include local functions, if available
[ -f ~/.bash_functions_here ] && . ~/.bash_functions_here
