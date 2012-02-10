# FUNCTIONS BY - ajcrites (Andrew Crites)
# Copyright 2010 Gleim Publications

# Does: Runs hg export on a mercurial changeset.  If no changeset is specified, then tip is used
# Used: Review changes in the changeset; especially useful for code reviews
function review_old() {
   if [ -z $1 ]; then
      rev="tip"
   else
      rev=$1
   fi
   hg export $rev | colordiff | less -R;
}

# Does: Recursive file grep that ignores case and has color
# Used: Finding just about any text in a file
function igrep() {
   grep -irn --color=always "$@" *
}

# Does: Recursive file grep that ignores case and has color
# Used: Finding just about any text in a file
function rgrep() {
   grep -rn --color=always "$@" *
}

# Does: Same as above, but only for php files
# Used: Finding text in php files
function phpgrep() {
   grep --include=*.php -irn --color "$@" *
}


# Does: hg diff on your current changes if no rev is specified.  Otherwise, hg diff on two revs and up to one file
# Used: Comparing changes between revisions or reviewing your own work before submitting it
function hgdf() {
   if [ -z "$1" ]; then
      hg diff -bB -rtip |colordiff -w |less -R
   else
      hg diff -bB -r$1 |colordiff -w |less -R
   fi
}

# Does: hg diff on the specified file (if desired)
# Used: Review your own work on a specific file (hgdf is shorter for all files)
function hgfdf() {
   hg diff -bB -rtip "$1" |colordiff |less -R
}

# Does: Syntax check on all php files in the specified revision or currently changed files
# Used: Confirm syntax okay during review or before submitting work or review a changeset
# Note: This will not run php -l on the files as they were in the revision, but as they are
#  in the location you run it. This is probably desired, fortunately.
# Gotcha: If the dev uploads a changeset with a syntax error that has been corrected in a later
#  changeset or in their current file changes and that changeset becomes the tip of the repo,
#  the syntax error will not be caught simply by phpl.  Devs should avoid doing this, though.
# Deprecated: Keeping around just in case, but replaced by the hgcallback script which can
#  call to other functions as well
function phpl_old() {
   local fileslist filesarr count
   count=0
   if [ "$1" ]; then
      fileslist=$(hg log -r$1 --template "{files} " 'glob:**.php'  |sed 's/ /\n/g' | grep '\.php$')
   else
      fileslist=$(hg st 'glob:**.php' | sed 's/^[M|R|A|!|?] //' | grep '\.php$')
   fi
   for d in ${fileslist} ; do
      filesarr[$count]="$d"
      if [ -a ${filesarr[$count]} ]; then
         php -l ${filesarr[$count]}
      else
         echo "Could not find ${filesarr[$count]}. It may have been removed."
      fi
      count=$(($count+1))
   done
}

# Does: Spell check on all files in the specified revision or currently changed files
#  if no revision is specified
# Used: Confirm spelling okay during review or before submitting work or review a changeset
# Note: This will not run ispell on the files as they were in the revision, but as they are
#  in the location you run it. This is probably desired, fortunately.
# Gotcha: If the dev uploads a changeset with a syntax error that has been corrected in a later
#  changeset or in their current file changes and that changeset becomes the tip of the repo,
#  the spelling error will not be caught simply by spell.  Devs should avoid doing this, though.
function spell() {
   if [ -z $@ ]; then
      /home/ajcrites/bin/hgcallback -f"ispell"
   else
      /home/ajcrites/bin/hgcallback -f"ispell" -r"$@"
   fi
}

# Does: Remove trailing whitespace from lines in a file of the given revision or currently chagned
#  files list if no revision is specified.
# Used: Trims files and prevents incorrect HEREDOC syntax
function trim() {
   if [ -z $@ ]; then
      /home/ajcrites/bin/hgcallback -s -f"s/\s*$//"
   else
      /home/ajcrites/bin/hgcallback -r"$@" -s -f"s/\s*$//"
   fi
}

# Does: Similar to getghp, checks out a crons repository and specifies a name, if desired
# Used: quickly check out crons project and rename repo, if desired
function getcrons_old() {
   cd ~/all_crons
   if [ -z $@ ]; then
      hg clone https://hg.teamgleim.com/noc/crons
   else
      hg clone https://hg.teamgleim.com/noc/crons crons-$@
   fi
}

# Does: Tab completion set up for run_cron function
# Used: Quickly find the specified project/service you want to run
# Note: This must be used at the cron repo root
function cron_completion() {
   local cur prev
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   prev="${COMP_WORDS[COMP_CWORD-1]}"
   opts=$(ls -d project/* 2>/dev/null | sed 's/project\///' | sed 's/example.*//')
   if [ $(expr match "$opts" ".*$prev") \> 0 ] && [ $(expr length "$prev") \> 0 ]; then
      opts=$(cat project/$prev/config/cron.xml | sed 's/<.*services>//g' | sed 's/<service name="//g' | sed 's/".*//')
   fi
   COMPREPLY=($(compgen -W "${opts}" -- $cur))
}

complete -F cron_completion run_cron

# Does: Tab completion for reportus function
# Used: Find class names available in _reports for faster running
function completion_reportus() {
   local cur prev
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   prev="${COMP_WORDS[COMP_CWORD-1]}"
   opts="-c"
   if [ $(expr match "$opts" ".*$prev") \> 0 ] && [ $(expr length "$prev") \> 0 ]; then
      opts=$(ls _creators | sed -lpe 's/\.php//' | sed -lpe '/^_/d')
   fi
   COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
}

complete -F completion_reportus rptus

# Does: Tab completion set up for goto function
# Used: Finds users -> available sandboxes with tabbing for fast access
function completion_goto() {
   local cur prev
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   prev="${COMP_WORDS[COMP_CWORD-1]}"
   opts=$(ls /home)
   opts+=" "$(ls ~/ | egrep '^httpd' | sed -lpe 's/httpd-//g')
   if [ $(expr match "$opts" ".*$prev") \> 0 ] && [ $(expr length "$prev") \> 0 ]; then
      opts=$(ls /home/$prev | egrep '^httpd' | sed -lpe 's/httpd-//g')
   fi
   COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
}

complete -F completion_goto goto

# Does: Quickly go to a specified httpd sandbox
# Used: Pure speed
goto () {
   if [ $# -lt 1 ]; then
      cd ~/httpd
   elif [ $# -lt 2 -a -e ~/httpd-$1 ]; then
      cd ~/httpd-$1
   elif [ $# -lt 2 ]; then
      echo "Sandbox not found: ~/httpd-$1"
   elif [ -e /home/$1/httpd-$2 ]; then
      cd /home/$1/httpd-$2
   elif [ -e /home/$1/httpd ]; then
      cd /home/$1/httpd
   else
      echo "Sandbox not found: /home/$1/httpd-$2"
   fi
}

# Does: Tab completion set up for goto function
# Used: Finds users -> available sandboxes with tabbing for fast access
function completion_sgoto() {
   local cur prev
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   prev="${COMP_WORDS[COMP_CWORD-1]}"
   opts=$(ls /home)
   opts+=" "$(ls ~/public_html | grep '^scc' | sed -lpe 's/scc-//g')
   if [ -d ~/public_html/hg ];then
      opts+=" "$(ls ~/public_html/hg | grep '^scc' | sed -lpe 's/scc-//g')
   fi
   if [ -d ~/public_html/truth ];then
      opts+=" "$(ls ~/public_html/truth | grep '^scc' | sed -lpe 's/scc-//g')
   fi
   if [ -d ~/public_html/untruth ];then
      opts+=" "$(ls ~/public_html/untruth | grep '^scc' | sed -lpe 's/scc-//g')
   fi
   if [ $(expr match "$opts" ".*$prev") \> 0 ] && [ $(expr length "$prev") \> 0 ]; then
      if [ -e /home/$prev/public_html ]; then
         opts=$(ls /home/$prev/public_html | egrep '^scc' | sed -lpe 's/scc-//g')
      fi
   fi
   COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
}

complete -F completion_sgoto sgoto

# Does: Quickly go to a specified SCC sandbox
# Used: Pure speed
# Note: sandbox must be in public_html or public_html/hg
#  If you decide to put it in another place, you will have to alter this function

sgoto () {
   if [ $# -lt 1 ]; then
      if [ -a ~/public_html/scc ]; then
         cd ~/public_html/scc
      elif [ -a ~/public_html/hg/scc ]; then
         cd ~/public_html/hg/scc
      else
         echo "Sandbox 'scc' not found in ~public_html or ~public_html/hg"
      fi
   elif [ $# -lt 2 ]; then
      if [ -d ~/public_html/scc-$1 ]; then
         cd ~/public_html/scc-$1
      elif [ -d ~/public_html/hg/scc-$1 ]; then
         cd ~/public_html/hg/scc-$1
      elif [ -d ~/public_html/untruth/scc-$1 ]; then
         cd ~/public_html/untruth/scc-$1
      elif [ -d ~/public_html/truth/scc-$1 ]; then
         cd ~/public_html/truth/scc-$1
      else
         echo "Sandbox not found: ~/public_html/scc-$1 or ~/public_html/hg/scc-$1"
      fi
   elif [ -e /home/$1/public_html/scc-$2 ]; then
      cd /home/$1/public_html/scc-$2
   elif [ -e /home/$1/public_html/hg/scc-$2 ]; then
      cd /home/$1/public_html/hg/scc-$2
   elif [ -e /home/$1/public_html/scc ]; then
      cd /home/$1/public_html/scc
   elif [ -e /home/$1/public_html/hg/scc ]; then
      cd /home/$1/public_html/hg/scc
   else
      echo "Sandbox not found: /home/$1/public_html/scc-$2 or /home/$1/public_html/hg/scc-$2"
   fi
}

# Does: tab completion for cron goto.
# Used: Pure speed

function completion_cgoto() {
   local cur prev
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   prev="${COMP_WORDS[COMP_CWORD-1]}"
   opts=$(ls /home)
   opts+=" "$(ls ~/all_crons | egrep '^crons' | sed -lpe 's/crons-//g')
   opts+=" "$(ls ~/public_html/untruth | egrep '^crons' | sed -lpe 's/crons-//g')
   if [ $(expr match "$opts" ".*$prev") \> 0 ] && [ $(expr length "$prev") \> 0 ]; then
      if [ -e /home/$prev ]; then
         opts=$(ls /home/$prev/ | egrep '^crons' | sed -lpe 's/crons-//g')
      fi
      if [ -e /home/$prev/public_html ]; then
         opts+=" "$(ls /home/$prev/public_html | egrep '^crons' | sed -lpe 's/crons-//g') 
         if [ -e /home/$prev/public_html/hg ]; then
            opts+=" "$(ls /home/$prev/public_html/hg | egrep '^crons' | sed -lpe 's/crons-//g')
         fi
         if [ -e /home/$prev/public_html/untruth/ ]; then
            opts+=" "$(ls /home/$prev/public_html/untruth | egrep '^crons' | sed -lpe 's/crons-//g')
         fi
      fi
      if [ -e /home/$prev/all_crons ]; then
         opts+=" "$(ls /home/$prev/all_crons | egrep '^crons' | sed -lpe 's/crons-//g') 
      fi
      if [ -e /home/$prev/projects ]; then
         opts+=" "$(ls /home/$prev/projects | egrep '^crons' | sed -lpe 's/crons-//g')
      fi
   fi
   COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
}

complete -F completion_cgoto cgoto

# Does: Take you to a crons sandbox
# Used: Pure Speed
# Note: People put crons in many different places.  There is no "wrong" place to put them,
#  so instead I just check all the common places before giving up; if you have another 
#  place where you put them, please tell me.
#  The order is also important.  If you have 'crons' in public_html AND public_html/hg,
#  Then cgoto will take you to public_html/crons without even checking if public_html/hg exists.
#  Finally, I wrote this function for myself and I always keep the crons in ~/all_crons
#  You will have to update it for your default folder if you use it

function cgoto() {
   if [ $# -lt 1 ]; then
      cd ~/all_crons/crons
   elif [ $# -lt 2 -a -e ~/all_crons/crons-$1 ]; then
      cd ~/all_crons/crons-$1
   elif [ $# -lt 2 -a -e ~/public_html/untruth/crons-$1 ]; then
      cd ~/public_html/untruth/crons-$1
   elif [ $# -lt 2 ]; then
      echo "Sandbox not found: ~/all_crons/crons-$1"
   elif [ -e /home/$1/crons-$2 ]; then
      cd /home/$1/crons-$2
   elif [ -e /home/$1/public_html/crons-$2 ]; then
      cd /home/$1/public_html/crons-$2
   elif [ -e /home/$1/projects/crons-$2 ]; then
      cd /home/$1/projects/crons-$2
   elif [ -e /home/$1/all_crons/crons-$2 ]; then
      cd /home/$1/all_crons/crons-$2
   elif [ -e /home/$1/public_html/untruth/crons-$2 ]; then
      cd /home/$1/public_html/untruth/crons-$2
   elif [ -e /home/$1/crons ]; then
      cd /home/$1/crons
   elif [ -e /home/$1/public_html/crons ]; then
      cd /home/$1/public_html/crons
   elif [ -e /home/$1/public_html/hg/crons ]; then
      cd /home/$1/public_html/hg/crons
   elif [ -e /home/$1/projects/crons ]; then
      cd /home/$1/projects/crons
   elif [ -e /home/$1/public_html/untruth/crons ]; then
      cd /home/$1/public_html/untruth/crons
   else
      echo "Sandbox not found: /home/$1/crons-$2 or /home/$1/public_html/crons-$2 or /home/$1/all_crons/crons-$2 or /home/$1/projects/crons-$2"
   fi
}

function completion_mysql() {
   local cur
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   opts=$(cat /home/ajcrites/.my.schemas)
   COMPREPLY=($(compgen -W "${opts}" -- $cur))
}

complete -F completion_mysql mysql

function completion_hgready() {
   local cur
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   opts=$(ls ~/ | egrep '^httpd' | sed -lpe 's/httpd-//g')
   if [ -e ~/public_html ]; then
      opts+=" "$(ls ~/public_html | egrep '^scc' | sed -lpe 's/scc-//g')
   fi
   if [ -e ~/public_html/hg ]; then
      opts+=" "$(ls ~/public_html/hg | egrep '^scc' | sed -lpe 's/scc-//g')
   fi
   COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
}

complete -F completion_hgready hgready

# Does: Copies bashrc and vimrc (or just vimrc, with argument) over to core/dev
# Used: Make sure your development environment is up to date on both servers
# Note: You must change 'dev' to 'core' or vice versa in this function and compile it
#  on the other server

function sendrc() {
   if [ $# -lt 1 ]; then
      scp -r ~/.bashrc ~/.vimrc ajcrites@core:/home/ajcrites; 
      echo "You must manually update the sendrc alias on core "
   elif [ $1 = "-v" ]; then
      scp -r ~/.vimrc ajcrites@core:/home/ajcrites;
   else
      echo "Unknown command specified.  Use -v to send only vimrc; no arguments to send both"
   fi
}

#Does: Makes a dir and cds into it
#Used: Shorthand for making a directory whose contents you immediately want to edit
#Note: See /home/ajcrites/.bash_aliases /mkdirs -- better than into && into..
function into() {
   mkdirs $@ && cd $@
}

#Does: tab completion for mysbcdump -- note there is a small delay due to the connetion
#Used: pure speed
function completion_mysbcdump() {
   local cur
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   opts=$(mysbc -e "SHOW DATABASES" | sed -e 's/|//' | sed -e 's/Database//')
   COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
}

complete -F completion_mysbcdump mysbcdump

#Does: mysqldump using your mysql sandbox socket connection including CREATE DATABASE and excluding data
#Used: Creating a schema change request for NOC, among other reasons
function mysbcdump() {
   if [ $# -lt 1 ]; then
      echo "You must specify a database name"
   elif [ -r ~/public_mysql/sock ]; then
      mysqldump --skip-comments --skip-add-drop-table -dBS ~/public_mysql/sock $@
   else
      echo "Socket file not found.  Please start mysql sandbox (mysbc)"
   fi
}

#Does: hg commit with message and make sure that outstanding files are taken care of
#Used: Helps make sure you commit correctly
#Deprecated: By /home/ajcrites/bin/hgsafeci
function hgci_old() {
   if [ $# -ne 1 ]; then
      echo "You must specify a commit message"
      return
   fi
   outstanding=$(hg st | egrep "^(\!|\?).*" | cut -d' ' -f2)
   if [ $(expr length "$outstanding") -gt 0 ]; then
      echo $outstanding | sed 's/\s/\n/g'
      echo
      echo "The above files are not currently tracked by Mercurial.  Use hg add/rm as needed"
      echo "Type 'c' to continue anyway"
      read -s -n 1 user
      if [ $(expr match "$user" "c") == 0 ]; then
         if [ $(expr match "$user" "C") == 0 ]; then
            return
         fi
      fi
   fi
   echo "Committing.."
   hg ci -m "$@"
}

#Does: Builds a string of files in the specified changesets
#Used: Correctly populate the <files> box in code reviews
function hgcrfiles {
   if [ $# -lt 1 ]; then
      revs="-rtip"
   else
      revs="-r$@"
   fi
   echo $(hg log -q --template "{files} " $revs | tr ' ' '\n' | sort -u | tr '\n' ',' | sed 's/,$//')
}

#Does: clone an ajcrites mercurial repository
#Used: for what it Does
function cloneus {
   if [[ -z "$@" ]]; then
      exit
   fi
   hg clone /home/ajcrites/.mercurial_repos/$1 $2
}

#Does: clone reporter and set up permissions properly
#Used: correct cloning of reporter
function getreporter {
   cloneus reporter $1 && cd $1 && chmod go+w _reports && cloneus reporter_plugins _plugins
}

#Does: See if a file exists and is readable
#Used: to check existence of a file
function see {
   test -r $1 && echo "File exists"
}

#Does: syntax checker for tal templates
#Used: commit lint files
function tal_lint {
   LINT_CHECKER=~/bin/phptal_lint.php
   TMP_DIR=~/tmp
   DEST_PATH=$TMP_DIR/$1
   CREATE_DIR=${DEST_PATH%/*}

   if [ ! -d ~/bin ]; then
      mkdir ~/bin;
   fi

   if [ ! -f $LINT_CHECKER ]; then
      echo "PHPTAL Lint Checker NOT FOUND -- Downloading"
      curl --silent -o ~/bin/phptal_lint.php https://svn.motion-twin.com/phptal/trunk/tools/phptal_lint.php
      chmod +x ~/bin/phptal_lint.php
   fi

   if [ $# -ne "1" ]; then
      echo "Please provide a file to check"
   else
      if [ ! -d $CREATE_DIR ]; then
         mkdir -p $CREATE_DIR
      fi
      cp $1 $TMP_DIR/$1
      $LINT_CHECKER $TMP_DIR/$1
   fi
}

function tall {
   if [ -z "$1" ]; then
      /home/ajcrites/bin/hgcallback -f"tal_lint"
   else
      /home/ajcrites/bin/hgcallback -f"tal_lint" -r"$1"
   fi
}

function cvim () {
   vim scp://core//home/ajcrites/public_html/$1
}

function txgrep() {
   grep "$1" *
}

function ge {
   if [ $1 == "1" ]
      then
      echo 'it works'
   fi
}
