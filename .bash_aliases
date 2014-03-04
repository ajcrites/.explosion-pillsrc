#ls
alias ls='ls --color=auto'
alias l='ls -l'
alias la='ls -lA'

#typos
alias clera='clear'
alias cleat='clear'
alias sugo='sudo'
alias sl='ls'
alias nab='man'

#Run after changing the bashrc to make new functions available
alias bsah='source ~/.bashrc'
alias bsh='source ~/.bashrc'
alias bhs='bsh'

#Quickly edit the bashrc or vimrc
alias ebash='vim ~/.bashrc'
alias eals='vim ~/.bash_aliases'
alias efnc='vim ~/.bash_functions'
alias econ='vim ~/.bash_constants'
alias evim='vim ~/.vimrc'
alias evin='evim'
alias ecron='crontab -e'
alias egit='vim ~/.gitconfig'
alias ezsh='vim ~/.zshrc'

#Recursively remove files
alias rmr='nice rm -rf'

alias mkdire='mkdir'

#More shortcuts
alias mkdirs="mkdir -p"
alias cld="cd && clear"

#tar
alias untar="tar -zxvf"

#screen
alias scree="screen -x 1>/dev/null || screen"

#up
alias up=". up"
alias pu="up"
alias u="up"
alias reup="cd - && . up"

#exit
alias exti="exit"

#py
alias py="python"

#ack
alias grep="ack"

#list files after grep and strip colors; this works surprisingly well
alias list="cut -d':' -f1 | sort -u | b"

#github
compdef hub=git

#Keep some aliases on the server .. alone
[ -f ~/.bash_aliases_here ] && . ~/.bash_aliases_here

#js
alias js="java -jar ~/tools/rhino1_7R4/js.jar"
alias jslint="java -jar ~/tools/jslint4java-2.0.3/jslint4java-2.0.3.jar --browser --indent 3 --predef '\$'"

#skype crashes
alias skype="LD_PRELOAD=/usr/lib/i386-linux-gnu/mesa/libGL.so.1 skype > /dev/null 2>&1 &"

#django
alias djm="python manage.py"

#undoing plugin aliases
unalias gd

#mt
alias kilall=killall

#standup
alias stup="vim $(date --date=tomorrow +%Y-%m-%d).md"
