source ~/.profile

# source git completion if none is defined
complete -p git 1>/dev/null 2>&1 || source ~/.bash/git-completion.bash

for FILE in {capistrano,rake,thor,git-flow,ssh}; do
  source ~/.bash/$FILE-completion.bash
done

source ~/.bash/aliases

for FILE in `ls ~/.bash/functions/*`; do
  source $FILE
done

# update lines and columns upon window resize
shopt -s checkwinsize

# Tweak History handling
export HISTCONTROL=erasedups:ignoredups:ignorespace
export HISTSIZE=100000
export HISTFILESIZE=200000
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# manage prompt and terminal title with git-prompt
[[ $- == *i* ]] && source "$HOME/Code/opensource/git-prompt/git-prompt.sh"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin

# source purely local additions
[[ -e "$HOME/.bash/local" ]] && source "$HOME/.bash/local"
