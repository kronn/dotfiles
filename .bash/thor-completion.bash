#!/bin/bash
# sorry, but thats the way it is...

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_check_thorfile() {
  if [ ! -e Thorfile ]; then
    return
  fi

  local cache_file=".cache_thor_t"

  if [ ! -e "$cache_file" ]; then
      thor -T | grep -v "^\-\+\|Tasks" | awk '{{print $2}}' | grep -v -e '^$' > $cache_file
      thor help | grep -v "^\-\+\|Tasks" | awk '{{print $2}}' | grep -v -e '^$' >> $cache_file
  fi

  local tasks=$(cat $cache_file)
  COMPREPLY=( $(compgen -W "${tasks}" -- $2) )
}
complete -F _check_thorfile -o default thor
