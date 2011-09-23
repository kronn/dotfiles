source ~/.profile

# source git completion if none is defined
complete -p git 1>/dev/null 2>&1 || source ~/.bash/git-completion.bash

source ~/.bash/capistrano-completion.bash
source ~/.bash/rake-completion.bash
source ~/.bash/git-flow-completion.bash
source ~/.bash/aliases

for FILE in `ls ~/.bash/functions/*`; do
  source $FILE
done

# update lines and columns upon window resize
shopt -s checkwinsize

# Tweak History handling
export HISTCONTROL=erasedups:ignoredups
export HISTSIZE=100000
export HISTFILESIZE=200000
shopt -s histappend
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# manage prompt and terminal title with git-prompt
[[ $- == *i* ]] && source "$HOME/Code/opensource/git-prompt/git-prompt.sh"

# rvm-install added line:
if [[ -s ~/.rvm/scripts/rvm ]] && [[ $rvm_loaded_flag != 1 ]]; then
  source ~/.rvm/scripts/rvm
fi
