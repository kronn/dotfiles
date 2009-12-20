source ~/.profile
source ~/.bash/git-completion.bash
source ~/.bash/aliases

for FILE in `ls ~/.bash/functions/*`; do
  source $FILE
done

# rvm-install added line:
if [[ -s ~/.rvm/scripts/rvm ]] && [[ $rvm_loaded_flag != 1 ]] ; then source ~/.rvm/scripts/rvm ; fi

