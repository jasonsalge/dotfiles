# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
export EDITOR=/usr/bin/vim

test -s ~/.alias && . ~/.alias || true

set -o vi

# Have grin ignore my tags file
export GRIN_ARGS="-e tags"

# SSH Agent
if [ -f ~/.bash_ssh_agent ]; then
    . ~/.bash_ssh_agent
fi

# git completion and set prompt
if [ -f ~/.bash_git_completion.sh ]; then
    . ~/.bash_git_completion.sh
    PS1='\[\033[01;34m\]\u@\h\[\033[00m\]:\w$(__git_ps1 " (%s)")\$ '
else
    PS1='\[\033[01;34m\]\u@\h\[\033[00m\]:\w\$ '
fi

export TERM=screen-256color

export GIT_SSL_NO_VERIFY=true

if [ -d ${HOME}/.profile.d ]; then
    for i in ${HOME}/.profile.d/*
    do
        #echo "Including ${i}"
        . ${i}
    done
fi

