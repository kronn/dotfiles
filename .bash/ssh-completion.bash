#!/usr/bin/env bash

complete -W "$(grep --color=no -e '^Host' ~/.ssh/config | sort -u | sed 's/^Host //')" ssh
