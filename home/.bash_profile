# Setup rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi

### added by the heroku toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Put bundle on the path
export PATH="./.bundle/bin:$PATH"

if [ -f $HOME/.tapas_auth ]; then
  source "$HOME/.tapas_auth"
fi

export HISTCONTROL=ignorespace
export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

export EDITOR=mate

export CLICOLOR=1

source ~/.bash_alias

# Set git autocompletion and PS1 integration

source ~/.git-completion.bash

__git_ps1 ()
{
  local b="$(git symbolic-ref HEAD 2>/dev/null)";
  if [ -n "$b" ]; then
    printf " (%s)" "${b##refs/heads/}";
  fi
}

function psg() {
  ps aux | grep -v grep | grep "$@" -i --color=auto;
}

function hsg() {
  history | grep -v grep | grep "$@" -i --color=auto;
}

# set 2-line color prompt (with git branch if possible)
if type __git_ps1 >/dev/null 2>&1; then
  PS1='\n\[\033[01;35m\]\t \[\033[00m\]\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\n\[\033[01;32m\]\u\[\033[00m\]:-> '
else
  PS1='\n\[\033[01;35m\]\t \[\033[00m\]\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\[\033[01;32m\]\u\[\033[00m\]:-> '
fi

