source ~/.profile
source ~/.bash/git-completion.bash
source ~/.bash/git-promptstatus.bash
source ~/.bash/aliases

for FILE in `ls ~/.bash/functions/*`; do
  source $FILE
done

# update lines and columns upon window resize
shopt -s checkwinsize

# Tweak History handling
export HISTCONTROL=erasedups
export HISTSIZE=100000
shopt -s histappend

# rvm-install added line:
if [[ -s ~/.rvm/scripts/rvm ]] && [[ $rvm_loaded_flag != 1 ]] ; then source ~/.rvm/scripts/rvm ; fi

