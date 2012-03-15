#ls
alias ls='ls --color=auto'
alias l='ls -l'
alias la='ls -la'

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
alias ack="ack-grep"
alias grep="ack"

#list files after grep and strip colors; this works surprisingly well
alias list="cut -d':' -f1 | sort -u | b"

#git
alias gd="git diff | colordiff | less -R"

#Keep some aliases on the server .. alone
[ -f ~/.bash_aliases_here ] && . ~/.bash_aliases_here
