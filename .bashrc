source ~/.profile

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# source completions if not already defined
for FILE in {git,capistrano,rake,thor,git-flow}; do
  complete -p $FILE 1>/dev/null 2>&1 || source ~/.bash/$FILE-completion.bash
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
if [ -e "$HOME/.bash/local" ]; then
  source "$HOME/.bash/local"
fi

# restore last saved path
if [ -f ~/.last_dir ]; then
  cd `cat ~/.last_dir`
  rm ~/.last_dir
fi

# BEGIN Ruboto setup
source ~/.rubotorc
# END Ruboto setup
