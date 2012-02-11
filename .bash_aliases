alias l='ls -l'
alias la='ls -la'

#typos
alias clera='clear'
alias cleat='clear'
alias sugo='sudo'
alias sl='ls'
alias igerp='igrep'
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

#Shortcut for long hg log
alias hgless='hg log -v |less'
alias hgles='hgless'

#Prints the tip in your current repo
alias tip='hg tip -v'

#Recursively remove files
alias rmr='nice rm -rf'

alias mkdire='mkdir'
alias ti='tip'

#Remove unwanted files from a repository (.rej, .orig); useful before committing
alias hgrmu="hg status -u | cut -d' ' -f2 | xargs rm"
alias hgrmd="hg status -d | cut -d' ' -f2 | xargs hg rm"

#See /home/ajcrites/bin/*
alias hgci="hgsafeci -ic"

#More shortcuts
alias mkdirs="mkdir -p"
alias p="less"
alias cld="cd && clear"

#View errors
alias phperr="tail /var/log/apache2/error.log"

#Directories I go to a lot
alias ttp="cd ~ttpearso"
alias mtl="cd ~mtlance"
alias clw="cd ~clwalker"
alias mdw="cd ~mdwillia"
alias cdp="cd ~/public_html"

alias ac="cd html/accounting || cd accounting"
alias av="cd html/aviation"
alias store="cd html/store"

alias truth="cd ~/public_html/truth"
alias untruth="cd ~/public_html/untruth"
alias phptest="cd ~/public_html/untruth/test"

alias spense="vim ~/public_html/truth/information/suspense.html"

alias repos="cd ~/.mercurial_repos"

#mysql connection shortcuts (shh!)
alias mysqp="mysql -p"
alias mycore="mysql -hcore -uwww"
alias myemp="mysqp EmploymentApplication"
alias mygcss="mysql -ugcss -pgleim GCSSOnlineStore"
alias mysitel="mysqp SiteLic"
alias mysec="mysqp -hsec.db.teamgleim.com -ugcss"
alias mysecg="mysqp -hsec.db.teamgleim.com -ugcss -pgleim GCSSOnlineStore"
alias mysece="mysqp -hsec.db.teamgleim.com -ugcss EmploymentApplication"
alias mysecs="mysqp -hsec.db.teamgleim.com -ugcss SiteLic"

alias core="ssh core"
alias mail1="ssh mail1.teamgleim.com"

#tar
alias untar="tar -zxvf"

#screen
alias scree="screen -x 1>/dev/null || screen"

#up
alias up=". up"
alias pu="up"
alias u="up"
alias reup="cd - && . up"

#grep
#alias exgrep="grep --color=always -v"

#exit
alias exti="exit"

#hgready
alias hready="hgready"

#py
alias py="python"

#ack
alias ack="ack-grep"
alias grep="ack"

#short
alias list="cut -d':' -f1 | sort -u"

#git
alias gd="git diff | colordiff | less -R"
