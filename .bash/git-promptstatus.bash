#!bash
# http://jeditoolkit.com/2010/09/04/git-status-in-bash-prompt.html

txtblk='\033[0;30m' # Black - Regular
txtred='\033[0;31m' # Red
txtgrn='\033[0;32m' # Green
txtylw='\033[0;33m' # Yellow
txtblu='\033[0;34m' # Blue
txtpur='\033[0;35m' # Purple
txtcyn='\033[0;36m' # Cyan
txtwht='\033[0;37m' # White
bldblk='\033[1;30m' # Black - Bold
bldred='\033[1;31m' # Red
bldgrn='\033[1;32m' # Green
bldylw='\033[1;33m' # Yellow
bldblu='\033[1;34m' # Blue
bldpur='\033[1;35m' # Purple
bldcyn='\033[1;36m' # Cyan
bldwht='\033[1;37m' # White
unkblk='\033[4;30m' # Black - Underline
undred='\033[4;31m' # Red
undgrn='\033[4;32m' # Green
undylw='\033[4;33m' # Yellow
undblu='\033[4;34m' # Blue
undpur='\033[4;35m' # Purple
undcyn='\033[4;36m' # Cyan
undwht='\033[4;37m' # White
bakblk='\033[40m'   # Black - Background
bakred='\033[41m'   # Red
badgrn='\033[42m'   # Green
bakylw='\033[43m'   # Yellow
bakblu='\033[44m'   # Blue
bakpur='\033[45m'   # Purple
bakcyn='\033[46m'   # Cyan
bakwht='\033[47m'   # White
txtrst='\033[m'   # Text Reset

__vcs_status() {
  if type -p __git_ps1; then
    branch=$(__git_ps1)
  else
    branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  fi
  if [ $branch ]; then
    # not updated
    color="${txtrst}"
    status=$(git status --porcelain 2> /dev/null)
    # if we have untracked files
    if $(echo "$status" | grep '?? ' &> /dev/null); then
      color="${txtblu}"
    fi
    #  added to index (green)
    if $(echo "$status" | grep '^A  ' &> /dev/null); then
      color="${txtgrn}"
    fi
    # updated in index (Cyan)
    if $(echo "$status" | grep '^M ' &> /dev/null); then
      color="${txtcyn}"
    fi
    # updated in index (Cyan)
    if $(echo "$status" | grep '^ M ' &> /dev/null); then
      color="${txtcyn}"
    fi
    #  deleted from index (red)
    if $(echo "$status" | grep '^ D ' &> /dev/null); then
      color="${txtred}"
    fi
    echo -e $color
  fi
}

