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

#Include local functions, if available
[ -f ~/.bash_functions_here ] && . ~/.bash_functions_here
